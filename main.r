#READWAVE
derrape <- readWave(file.choose()) #Abre explorador para elegir archivo
derrape
guitarra <- readWave(file.choose())
guitarra
camion <- readWave(file.choose())
camion
fire <- readWave(file.choose())
fire
tren <- readWave(file.choose())
tren

#LISTEN
listen(derrape)

#OSCILLO
oscillo(derrape, title="DERRAPE")
oscillo(guitarra, title="GUITARRA")
oscillo(camion, title="CAMION")
oscillo(fire, fastdisp=TRUE, title="FIRE")
oscillo(tren, title="TREN")

#ESTO SE HIZO EN LA CLASE
data(orni)
s<-orni
oscillo(orni, title="Oscillogram Orni")
s
sound1p<-periodogram(s) #ESTO DA UN ERROR PERO NO AFECTA
plot(sound1p, main="Periodogram Orni")

#Eje Y en periodogram: frecuencia de la frecuencia

derrape_p <- periodogram(derrape)
plot(derrape_p, main="Periodogram Derrape")
guitarra_p <- periodogram(guitarra)
plot(guitarra_p, main="Periodogram Guitarra")
camion_p <- periodogram(camion)
plot(camion_p, main="PEriodogram Camión")
fire_p <- periodogram(fire)
plot(fire_p, main="Periodogram Fire")
tren_p <- periodogram(tren)
plot(tren_p, main="Periodogram Tren")

#BAJAR LA FRECUENCIA DE MUESTREO
derrape
derrape.downsampled <- downsample(derrape, samp.rate = 11050)
derrape #ESTA MUESTRA LA VARIABLE ORIGINAL CON SU SAMPLE RATE ORIGINAL
derrape.downsampled #AQUÍ YA SE MUESTRA EL SAMPLE RATE CAMBIADO
guitarra
guitarra.downsampled <- downsample(guitarra, samp.rate = 11050)

#RESAMPLEAR LA FRECUENCIA DE MUESTREO
library("seewave")
derrape.resampled<- resamp(derrape.downsampled, f= 11050, g=24000, output="Wave")
derrape.resampled

oscillo(derrape.downsampled, title="derrape_down")
oscillo(derrape.resampled, title="derrape_resamp")

derrape_d_p <- periodogram(derrape.downsampled)
plot(derrape_d_p, main="Periodogram Derrape_downsample")

derrape_r_p <- periodogram(derrape.resampled)
plot(derrape_r_p, main="Periodogram Derrape_resampled")

#AUTOC >> ESTA COSA MUESTRA LOS ARMÓNICOS Y LA FRECUENCIA FUNDAMENTAL
autoc(derrape.downsampled)
autoc(guitarra, main="Autoc Guitarra")
autoc(orni, main="Orni")  #2kHz con un armónico de 4.

#PARA SACAR LOS VALORES EXACTOS SE SACA LA ONDA COMO DATAFRAME  OBTENER COMO CSV 
#ESTO MUESTRA LOS VALORES PERO NO SE VE VISUALMENTE LOS ARMÓNICOS NI LA FRECUENCIA FUNDAMENTAL
#ESO HAY QUE DETERMINARLO MANUALMENTE  (TOLERANCIA +- 10%)
autoc_orni <- autoc(orni)
write.csv(autoc_orni, file="orni.csv")


#SETEAMOS EL WORK DIRECTORY
setwd("/home/alcss/Documentos/Programación/Clase")
#ALMACENAMOS EL CSV EN UN DATAFRAME
datos <- read.csv("orni.csv")
datos

nota_fundamental <- min(datos$y)

nota_fundamental





#BUSCAR AUDIO DE ESCALA NOTAL


