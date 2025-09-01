# Bienvenidos a mi primer codigo R
# Librerias
library(dplyr)
library(ggplot2)

# inicio mi codigo R
# operador de asignacion: "  <-  "
mensaje <- "Hola mundo, este es mi primer codigo en R"
print(mensaje)

PrimerNota <- 10
SegundaNota <- 4
NotaFinal <- (PrimerNota + SegundaNota) / 2
print(NotaFinal)

# Transformacion de datos 
data <- read.csv(file = "C:/Users/joaqu/OneDrive/Escritorio/Analisis de datos/Modulo 4/COMPRAS.csv",
                 sep = ";",
                 encoding = "latin1")
# mutate 
data_mutate <- mutate(data, ValorItem = Total / Cantidad)

#select
data_select <- select(data_mutate, PaisTienda,
                                   Total,
                                   ValorItem)
#filter
data_filter <-filter(data_select, Total > 10000)

## ¿se puede hacer toda la transformacion de una sola vez?
data_trf <- data %>% mutate(ValorItem = Total / Cantidad)%>%
                     select(PaisTienda,
                            Total,
                            ValorItem) %>%
                            filter(Total > 10000)

## resumenes
data_summarise <- summarise(data_trf, ValorTotalizado =sum(Total),
                                      MedianaItem = median(ValorItem))

data_agrupado <- data_trf %>% group_by(PaisTienda) %>%
                         summarise(ValorTotalizado = sum(Total),
                                   MedianaItem = median(ValorItem))

## ggplot2
data %>% group_by(PaisTienda, Forma.de.envío) %>% summarise(ItemsTotales = sum(Cantidad)) %>%
   ggplot(aes(x=ItemsTotales, y=PaisTienda, fill = Forma.de.envío)) + geom_col()

data %>% filter(Cantidad < 50) %>%
ggplot(aes(x=Cantidad)) + geom_histogram(bins = 10)