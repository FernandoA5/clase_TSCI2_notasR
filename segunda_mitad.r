#Frecuencias
#diffcumspec() Esta cosa sirve para ver la distancia acumulada de dos espectrogramas

#Kolmogorov-Smirnov -> No es paramétrica (lo que sea que eso signifique)
#ks.dist()
#La distancia se puede asociar a una frecuencia. Saber cual frecuencia causa una mayor distancia es útil
#HAcer lo de ks.dist() y ver en los argumentos cómo graficarla

library("seewave")
library("tuneR")



ks.dist(night.mspec, day.mspec)

#itakuro-saito -> Distancias logarítimicas entre los espectros. Aparentemente es parecida a las entropias. No es simétrica, usa base logarítmica: x vs y no es lo mismo que y vs x
#Itakura.dist() = Itakuro Asimetric Distance.
itakura.dist(night.mspec, day.mspec)

#Información Mutua
#Entropía espectral y temporal?
# Comparamos 2 audios y mientras menos se empaten más información obtenemos
#symba() <--- lo que nos intereca es su complemento so:
#res <- 1 - symba(audio.spec, audio2.spec)$I
library("seewave")
library("tuneR")

derrape <- readWave(file.choose())
tren <- readWave(file.choose())

derrape.cut <- cutw(derrape, from=0, to=3, output = "Wave")
tren.cut <- cutw(tren, from=0, to=3, output = "Wave")
derrape.cut <- downsample(derrape.cut, tren.cut@samp.rate)

derrape.cut
tren.cut

derrape.spec.cut <- spec(derrape.cut, main="Spec Derrape")
tren.spec.cut <- spec(tren.cut, main="Spec Tren")

res <- 1 - (symba(tren.spec.cut, derrape.spec.cut)$I)
res
  
#log-spectral distance
#logspec.dist(nigth.spec, day.mspec) ESTO DA EN EL EJEMPLO: 76.72
logspec.dist(derrape.spec.cut, tren.spec.cut)

#Terminando indices beta
#100 - simspec(audio1.spec, audio2.spec, PMF = TRUE) EL PMF es la cosa acumulada
100 - simspec(derrape.spec.cut, tren.spec.cut)
plot(derrape.spec)

#Correlación entre espectros de frecuenca o algo así envento similar= cosa similar  <1 es correlación negativa
sqrt(1-cor(derrape.spec.cut[,2] / sum(derrape.spec.cut[,2]), tren.spec.cut[,2]/ sum(tren.spec.cut[,2])))

#indice de disimilaridad temporal
#diffenv(day@left, day@right, f=day.samp_rate)
diffenv(derrape.cut, tren.cut)

#ESTO ES LO MISMO SOLO ESTABA TESTEANDO LO DE EL SAMPLE RATE
derrape.cut
tren.cut
derrape.downsampled <- downsample(derrape.cut, samp.rate = 11025)

derrape.downsampled
tren.cut

#Aparentemente para que esta mierda funcione deben tener sample rates idénticos
#diffenv(derrape.downsampled, tren.cut)

#cap 16 del libro
#bioacustic_index   
#Biodiversidad acustica entre 2000 y 8000 Hz
#La forma de eso se parece a periodogram
#No es de seewave, es de soundecology
#EN MONO
#frecuencias de 2000 a 8000
#bioacustic_index(audio, min_freq=2000, max_freq=8000)
bioacoustic_index(derrape, min_freq=2000, max_freq=8000)
#en el libro viene algo de res$left_area, eso no lo usamos porque nuestros audios ya son mono
#hacer tambien para orni
bioacustic_index(orni, min_freq=2000, max_freq=8000)
#Aparentemente, eso nos dice que tan frecuentemente aparecen ciertas frecuencias, mientras más aparezca alguna frequencia, más elementos de esa especie hay

#La mediana
#Profundidad de digitación de la grabación
#Puedo usar la envoltura absoluta o la de hilbert dependiendo de que dominio me interesa
#M(audio)
#SI LA MEDIANA ESTÁ DEMASIADO CERCA A 0: Hay ruido

#indice de entropía temporal
#si el audio varía poco la entropía tiende a 0
#más fuentes emisoras diferentes: más entropía
#El logarítmo es base 10 
#th(audio.env)

#acousitic richest index
#para este no se usa un solo audio, se utiliza un directorio completo:
#oldwd <- getwd()
#setwd("sample/guiana")
res <- AR(getwd(), datatype = "files")
res

oldwd <- getwd()
oldwd
setwd("/home/alcss/Documentos/Programación/Clase/sonidos_ar/")
res<- AR(getwd(), datatype = "files")
res


#ENTROPÍA ESPECTRAL
#EN EL DOMINIO DE LA FRECUENCIA
#se usa log n
#res <-sh(mspec, plot=false)

sh(derrape.spec) #Esta cosa dio 0.89

#SI QUEREMOS LA ENTROPÍA COMPLETA: MULTIPLICAMOS LA ESPECTRAL Y LA TEMPORAL
#ESO LO HACE LA FUNCIÓN H(wave)
#LA MULTIPLICACiÖN DE AMBAS MIERDAS ES LA ENTROPÍA NETA
#H()
H(derrape)

#ADI  //INDICE DE DIVERSIDAD ACÚSTICA
#TRABAJA EN UNA BANDA DE FRECUENCIAS DE 0-10
#APARENTEMENTE LAS DIVIDE
#TIENE CIERTO UMBRAL DE DECIBELIOS
#UTILIZA UN ARCHIVO: MONO WAVE
derrape.acoustic_diversity <-acoustic_diversity(derrape) #ESTA COSA DIO 1.9370
#Aparentemente barplot() sirve para graficar gráfica de barras

left<-derrape.acoustic_diversity$adi_left
right<-derrape.acoustic_diversity$adi_right
left
right

barplot(height = left, names=right, ylab="Proportion")

#Síntesis aditiva
#coeficiente gini?
#Mide la desigualdad de una distribución
#indice ai //acoustic evenness index
acoustic_evenness(derrape) #Un valor de 0 significaría que la amplitud y frecuencia es uniforme
#freq_step es cómo sample rate, dice cada cuantas frecuencias se toma una muestra #No necesitamos usarlo

#ACI

ACI(derrape) #Esta cosa da 166.1095
#Matriz de los coeficientes de fourier.
#Filas y columnas, num de identidad y el peso (importancia (como la cosa de la regresión lineal))
#El coeficiente de una transformada 
#El índices computa los coeficientes individuales, cuanto más varíen mas complejo será el audio 
#y el valor será mayor


#Biofónica vs antropofónica
#Los sintéticos no van en ninguno de los dos, es una categoría por si mismo
#Esta cosa va de -1 a 1.
# 1 = no antropofónico
# -1 = no biofónico
#Esta cosa no sirve para audios sintéticos (So: si es sintético: no se hace)
sdspec <- soundscapespec(derrape)
NDSI(sdspec) #Esto da -0.7975702
#Tiene porcentaje de biofónicos y porcentaje de antropofónicos, 
#Los antropofónicos se encuentran entre 1-2kHz
#de 2 a 8 son antropofónicos kHz 
#(banda de bark) arriba de 8khz (i mean, 8000 a 9200 hz)



#La cosa de la 125, tiene algo que ver con positivos y negativos (Absolutos)
#La cosa 26 tiene algo que ver con la parte imaginaria de una sinosoidal
# (una transformada de Hilbert)

#La forma de parametrizar eso con seewave es con env()
#Por defecto eso pone la parametrización de Hilbert, 
#Si cambiamos el parametro (fftw= TRUE) nos da la otra cosa de la página 125, que es el absoluto
#Absoluto vs Hilbert

env(derrape) #Por default ya hace lo de Hilbert
env(derrape, envt = "abs")







