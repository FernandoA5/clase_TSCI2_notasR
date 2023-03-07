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

#PERIODOGRAM
data(orni)
s<-orni
oscillo(orni, title="Oscillogram Orni")
s
sound1p<-periodogram(s) #ESTO DA UN ERROR PERO NO AFECTA
plot(sound1p, main="Periodogram Orni")

#Eje Y en periodogram: frecuencia de la frecuencia

derrape.per <- periodogram(derrape)
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


#FILTROS DE FRECUENCIA
#pág: 478

#Filtos: low-pass, high-pass, band-pass.

#ffilter de seewave


#por cada filtro hacer un periodogram
der_per <- periodogram(derrape)
plot(der_per, main="Periodogram Derrape Original")
library("seewave")
der_filt <- ffilter(derrape, from=5000, to=30000, bandpass=TRUE, output="Wave")

der_filt
#oscillo(der_filt, title="Oscillograma Derrape filtrado")
der_filt_per <- periodogram(der_filt)
plot(der_filt_per, main="Periodogram Derrape Filtrado")

guitar_per <- periodogram(guitarra)
plot(guitar_per, main="Periodogram Guitarra Original")
guitar_filt <- ffilter(guitarra, from=500, to=3100, bandpass=TRUE, output="Wave")
guitar_filt
#oscillo(guitar_filt, title="Osicllograma Guitarra Filtrado")
guitar_filt_per <- periodogram(guitar_filt)
plot(guitar_filt_per, main="Periodogram Guitarra Filtrado")

camion_per <- periodogram(camion)
plot(camion_per, main="Periodogram Camion Original")
camion_filt <- ffilter(camion, from=0, to=1000, bandpass=TRUE, output="Wave")
camion_filt
camion_filt_per <- periodogram(camion_filt)
plot(camion_filt_per, main="Periodogram Camion Filtrado")
#Escuchar despues de flitrar

#AUDIOS NUESTROS BANDA DE BARK 8000 a 9200 -> aplicamos periodogram y obtenemos la frecuencia
#De aparición de cada frecuencia de ruido, (aplicamos un arbol de huffman en eso)
#Agregar al final la códificicación
guitar_bark <- ffilter(guitarra, from=8000, to=9200, bandpass=TRUE, output="Wave")
guitar_bark_per <- periodogram(guitar_bark)
#APARENTEMENTE LA GUITARRA NO TIENE FRECUENCIAS EN ESE RANGO (8000,9200)

derrape_bark <- ffilter(derrape, from=8000, to=9200, bandpass=TRUE, output="Wave")
derrape_bark_per <- periodogram(derrape_bark)

plot(guitar_per, main="Periodogram Guitarra")
plot(guitar_bark_per, main="Periodogram Guitarra Bark")

plot(derrape_bark_per, main="Periodogram Derrape")


#PARA GUARDAR EL WAVE MODIFICADO COMO UN ARCHIVO .wav usamos
#writeWave(sonido_mod, "sonido_mod.wav")  USAMOS ESTA NOTACIÓN

#DEL GRUPO E USAR LOS CUATRO FILTROS EN UN AUDIO Y GENERAR 4 AUDIOS DE SALIDA
#AUDIO-E3: Loreen - Statements
#HACER LOS 4 TIPOS DE FILTROS DE BANDA

loreen <- readWave(file.choose()) #48000Hz, 181.84s
loreen
loreen.downsampled <- downsample(loreen, samp.rate = 24000)
oscillo(loreen.downsampled, title="Oscillograma Loreen")

#CONVERTIR PERIODOGRAM EN DATAFRAME
p<- derrape_bark_per
p
df <- data.frame(frequency = p@freq, spec = p@spec)
df



#analizar relacion de spec con oscilo y periodogram
library("seewave")
oscillo(derrape, title="Oscillo Derrape") #Amplitud vs Tiempo
plot(derrape.per) #Frecuencia de las frecuencias (normalized periodograma vs Frequencia)
derrape.spec <- spec(derrape) #Amplitud vs Frecuencia

#para pasar del dominio del tiempo a la frecuencia se utiliza un escalon de transformación
#En este caso el escalon de paso es un espectrograma, spec pasa lo que vemos en oscillo a lo
#que vemos en periodogram (distancias estadísticas)

#wave, Wspec, spec
#capitulo 4 del libro manipulación de audios.

#APLICACIÓN DE ESO A LOS AUDIOS

#Documentación de seewave: fpeaks. 
#Aparentemente fpeaks puede llegar a consumir muchos recursos, para solucionar eso.
#Se baja el sample rate, pero con el cuidado de tener en cuenta las frecuencias
#presentes en el audio. #ATENCIÓN: La salida es una matriz de cada pico, su amplitud y su frecuencia.
derrape.fpeaks <- fpeaks(derrape.spec, plot = TRUE)
derrape
plot(derrape.fpeaks, main="Derrape fpeaks")
derrape.fpeaks
#Frecuenciad dominante puede ser útil: dfreq(), sirve para algo parecido, pero toma un wave
dfreq(derrape, plot=TRUE)
#FRECUENCIA DOMINANTE: el audio principal, (nos puede servir para poder aislarla)

