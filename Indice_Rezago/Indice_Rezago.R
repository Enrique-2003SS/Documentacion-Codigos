# https://www.coneval.org.mx/Medicion/IRS/Paginas/Que-es-el-indice-de-rezago-social.aspx
# Unicamente indica que es un analisis de componentes
indice_rezago = function(base){
  base = as.data.frame(lapply(base, as.numeric))              # Verificas que todas las columnas sean numerico
  componentes = prcomp(base,  center = TRUE, scale. = TRUE)   # Aplicas analis de componetes
  indice = scale(scale(as.matrix(base))%*%as.matrix(componentes$rotation[,1])) # Multiplicas la matriz estandarizada por el primer componente para obtener los pesos.
  return(as.data.frame(indice))
}


prueba = indice_rezago(datos_estatal)
