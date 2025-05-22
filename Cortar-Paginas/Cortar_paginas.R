# Este codigo tiene 2 partes
# Parte 1: Cortas un pdf, solo las paginas seleccionadas
# Parte 2: Cortas un pdf en varias partes.

### Parte 1
library(pdftools)   # Cargas la librera para leer pdf's.

# Defines tu directorio de trabajo
setwd("C:/Users/eagel/OneDrive/Escritorio/Lalo/Escuela/Articulo/Libros/")

# Define das tu archivo de entrada
input_file = "Introductory Time Series with R.pdf"

# Defines como se llamara tu archivo de salida
output_file = "Introductory Time Series with R_Cortado.pdf"

# Das el numero de las paginas que quires mantener(El numero va respecto a la pagina del pdf no del libro o documento)
paginas = c(56:77)

# Crea un nuevo archivo PDF que contiene solo un subconjunto de las páginas de un archivo PDF original.
pdf_subset(input_file, pages = paginas, output = output_file)











##############################################################
### Parte 2
library(pdftools)      # Cargas la librera para leer pdf's.

# Defines tu directorio de trabajo
setwd("C:/Users/eagel/OneDrive/Escritorio/Lalo/Escuela/Servicio Social/Septiembre/Archivos Utilizados/25 sep/")

# Define das tu archivo de entrada
input_file <- "REGIÓN ACTOPAN.pdf"

# Aqui unicamente es pensar en el patron de como tomar las paginas deseadas.
for (n in 1:12) {
  output_file <- paste0("Region_", n, ".pdf") # Defines como se llamara tu archivo de salida
  
  # Páginas que quieres extraer
  paginas <- c( ((4*n) - 3):(4*n) )     #Aqui estoy tomando 1,2,3,4 y despues 5,6,7,8 asi de manera sucesiva
  
  pdf_subset(input_file, pages = paginas, output = output_file) # Guarda los archivos
}

