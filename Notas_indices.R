library("seewave")
library("tuneR")

audio_ejercicio <- readWave(file.choose())
audio_ejercicio

audio_ejercicio.periodogram <- periodogram(audio_ejercicio)
plot(audio_ejercicio.periodogram, main="Periodogram Audio-Derrape")

audio_ejercicio.bark <- ffilter(audio_ejercicio, bandpass = TRUE, from=8000, to=9200, output = "Wave")

audio_ejercicio.bark.periodogram <- periodogram(audio_ejercicio.bark)
plot(audio_ejercicio.bark.periodogram, main="Periodogram audio-Derrape Bark")

#LA COSA DE LA BANDA DE BARK, DEBE SUMAR UNO, SI NO DA UNO SE DEBE NORMALIZAR.


#AHORA SI LO DE INDICES
#USAMOS SPEC, PORQUE ES UNA COSA DE COSAS ESTADÍSTICAS
tren <- readWave(file.choose())
camion <- readWave(file.choose())
#SPEC O MEANSPEC.
tren.spec <- spec(tren, main="Spec Tren")
camion <- spec(camion, main="Spec Camión")

tren.cut <- cutw(tren, from=0, to=3)
camion.cut <- cutw(camion, from=0, to=3)


#Diffspec Dice  la distancia de 2 specs. Esta cosa es simétrica (El orden de los factores no altera el producto)

