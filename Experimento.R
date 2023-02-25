library("tuneR")
library("seewave")
library("stats")


#EXPERIMENTO 
do5<- readWave(file.choose()) 
do5
do5_oscillo <- oscillo(do5, title="Oscillogram DO5")

do5_per <- periodogram(do5, main="Periodogram DO5")
plot(do5_per)
do5
do5.downsamped <- downsample(do5, samp.rate =24000)

do5_spec <- spec(do5.downsamped)
plot(do5_spec)

dfDo5 <- as.data.frame(do5_spec)
max(dfDo5)
min(dfDo5)



