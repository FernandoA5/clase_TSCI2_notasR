audio <- readWave(file.choose())


audio.per <- periodogram(audio)
plot(audio.per, main="Periodograma Audio")

audio.bark <- ffilter(audio, from = 8000, to=9200, bandpass = TRUE, output="Wave")
audio.bark.per <- periodogram(audio.bark, main="Periodograma Audio Bark")
