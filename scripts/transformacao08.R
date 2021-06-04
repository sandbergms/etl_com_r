library(data.table)
library(dplyr)

# Criação de um data table a partir da base 'mtcars'

mtcarsDT <- mtcars %>% setDT()

# Aplicação direta do sumário de uma regressão linear

mtcarsDT[ , summary(lm(wt ~ drat + qsec + gear))]
