#Examen
#Primer Audio
audio1 <- readWave(file.choose()) #1B mono
audio2 <- readWave(file.choose()) #1C mono

#Comparación de Periodogramas
audio1.per <- periodogram(audio1)
audio2.per <- periodogram(audio2)

plot(audio1.per, main="Periodograma audio1(1B)")
plot(audio2.per, main="Periodograma audio2(1C)")

#Comparación de Spectrogramas
par(mfrow= c(1, 2))
spec(audio1, main="Audio1 (1B)")
spec(audio2, main="Audio2 (1C)")

#Frecuencia fundamental y armónicos
audio1.autoc <- autoc(audio1, main="Autoc Audio1 (1B)")
audio2.autoc <- autoc(audio2, main="Autoc Audio2(1C)")

write.csv(audio1.autoc, file="audio1_autoc.csv")
write.csv(audio2.autoc, file="audio2_autoc.csv")

datos_audio1 <-read.csv("audio1_autoc.csv")
datos_audio2 <-read.csv("audio2_autoc.csv")

nota_fundamental_audio1 <- min(datos_audio1$y)
nota_fundamental_audio2 <- min(datos_audio2$y)

nota_max1 <-max(datos_audio1$y)
nota_max2 <-max(datos_audio2$y)

nota_max1
nota_max2


nota_fundamental_audio1
nota_fundamental_audio2

