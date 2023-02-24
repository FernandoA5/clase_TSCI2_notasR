
#EXPERIMENTO 
do_pecho <- readWave(file.choose())
do_pecho

oscillo(do_pecho, title="Ocillograma Do de Pecho")
do_pecho_per <- periodogram(do_pecho)
plot(do_pecho_per, main="Periodogram Do de Pecho")


sol <- readWave(file.choose())
sol
oscillo(sol, title="Oscillograma Sol")
sol_per <- periodogram(sol)
plot(sol_per, main="Periodogram Sol")
