library(tidyverse)
library(ggplot2)


# Histograma de densidad con curva de normalidad superpuesta
histogram_plot <- function(data, var, bins = 50){
  if (!var %in% colnames(data)) {
    stop("La variable especificada no existe en el dataframe")
  }
  
  var_sym <- as.symbol(var)
  
  data_na_omit <- data %>% select(!!var_sym) %>% filter(!is.na(!!var_sym))
  
  media <- mean(data_na_omit[[1]])
  desv  <- sd(data_na_omit[[1]])
  
  ggplot(data_na_omit, aes(x = !!var_sym)) +
    geom_histogram(aes(y = after_stat(density)), bins = bins, fill = "lightblue", color = "white") +
    stat_function(fun = dnorm, args = list(mean = media, sd = desv), color = "red", linewidth = 1) +
    ggtitle(paste("Histograma de", var)) +
    ylab("Densidad") +
    theme_minimal()
}


# Histograma segmentado por variable objetivo
histogram_var_target_plot <- function(data, var, target_var = "Diagnosis", bins = 50){
  if (!(var %in% colnames(data)) || !(target_var %in% colnames(data))) {
    stop("Una o ambas variables especificadas no existen en el dataframe")
  }
  
  var_sym    <- as.symbol(var)
  target_sym <- as.symbol(target_var)
  
  data_na_omit <- data %>% select(!!var_sym, !!target_sym) %>% filter(!is.na(!!var_sym))
  
  ggplot(data_na_omit, aes(x = !!var_sym, fill = !!target_sym)) +
    geom_histogram(bins = bins, position = "identity", alpha = 0.6) +
    ggtitle(paste("Histograma de", var, "según", target_var)) +
    ylab("Frecuencia") +
    theme_minimal()
}


# Boxplot segmentado por variable objetivo
boxplot_var_target_plot <- function(data, var, target_var = "Diagnosis"){
  if (!(var %in% colnames(data)) || !(target_var %in% colnames(data))) {
    stop("Una o ambas variables especificadas no existen en el dataframe")
  }
  
  var_sym    <- as.symbol(var)
  target_sym <- as.symbol(target_var)
  
  data_na_omit <- data %>% select(!!var_sym, !!target_sym) %>% filter(!is.na(!!var_sym))
  
  ggplot(data_na_omit, aes(x = !!target_sym, y = !!var_sym, fill = !!target_sym)) +
    geom_boxplot() +
    ggtitle(paste("Cajas y bigotes de", var, "según", target_var)) +
    ylab(var) +
    xlab(target_var) +
    theme_minimal()
}


# Gráfico de barras apiladas proporcional para variables categóricas binarias
barplot_categorica_target_plot <- function(data, var, target_var = "Diagnosis"){
  if (!(var %in% colnames(data)) || !(target_var %in% colnames(data))) {
    stop("Una o ambas variables especificadas no existen en el dataframe")
  }
  
  var_sym    <- as.symbol(var)
  target_sym <- as.symbol(target_var)
  
  ggplot(data, aes(x = factor(!!var_sym), fill = !!target_sym)) +
    geom_bar(position = "fill") +
    ggtitle(paste(var, "según", target_var)) +
    xlab(var) +
    ylab("Proporción") +
    theme_minimal()
}


# Gráfico de dispersión entre dos variables numéricas coloreado por la variable objetivo
scatter_plot <- function(data, var_x, var_y, target_var = "Diagnosis"){
  if (!(var_x %in% colnames(data)) || !(var_y %in% colnames(data))) {
    stop("Una o ambas variables especificadas no existen en el dataframe")
  }
  
  var_x_sym  <- as.symbol(var_x)
  var_y_sym  <- as.symbol(var_y)
  target_sym <- as.symbol(target_var)
  
  data_na_omit <- data %>%
    select(!!var_x_sym, !!var_y_sym, !!target_sym) %>%
    drop_na()
  
  ggplot(data_na_omit, aes(x = !!var_x_sym, y = !!var_y_sym, color = !!target_sym)) +
    geom_point(alpha = 0.4) +
    ggtitle(paste(var_x, "vs", var_y)) +
    xlab(var_x) +
    ylab(var_y) +
    theme_minimal()
}


# Imputación de una variable numérica por la mediana estratificada
imputar_mediana_estratado <- function(df, col_num, col_grupo) {
  col_num   <- as.symbol(col_num)
  col_grupo <- as.symbol(col_grupo)
  
  mediana_ <- df %>%
    filter(!is.na(!!col_num)) %>%
    group_by(!!col_grupo) %>%
    summarize(mediana_col = median(!!col_num, na.rm = TRUE), .groups = "drop")
  
  df <- df %>%
    left_join(mediana_, by = rlang::as_name(col_grupo)) %>%
    mutate(!!col_num := coalesce(!!col_num, mediana_col)) %>%
    select(-mediana_col)
  
  return(df)
}


# Detección de outliers univariantes por IQR
outliers_univariantes <- function(data, var) {
  if (!var %in% colnames(data)) {
    stop("La variable especificada no existe en el dataframe")
  }
  
  outliers <- boxplot.stats(data[[var]])$out
  
  outlier_col_name <- paste0("outlier_", var)
  data[[outlier_col_name]] <- ifelse(data[[var]] %in% outliers, "YES", "NO")
  
  return(data)
}


# Tabla de frecuencias y porcentajes de una variable
distinct_function_count <- function(data, var){
  var <- as.symbol(var)
  
  counts_values_var <- data %>%
    group_by(!!var) %>%
    count() %>%
    arrange(desc(n))
  
  total <- sum(counts_values_var$n)
  counts_values_var <- counts_values_var %>%
    mutate(percentage = round(n / total * 100, 3))
  
  return(counts_values_var)
}