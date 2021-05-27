library(data.table)
library(dplyr)
library(tidyverse)
library(funModeling) 

general_data <- fread("https://covid.ourworldindata.org/data/owid-covid-data.csv") # carrega dados de covid19 no mundo

latin_america_countries <-c("Argentina", "Brazil", "Bolivia", "Chile", "Colombia", "Costa Rica", "Cuba", "Dominican Republic", "Ecuador", "El Salvador", "Guatemala", "Haiti", "Honduras", "Mexico", "Nicaragua", "Panama", "Paraguay", "Peru", "Uruguay", "Venezuela") # vetor que identifica países latino americanos

latin_america <- general_data %>% filter(location %in% latin_america_countries) # filtra casos apenas no vetor

latin_america <- latin_america %>% select(location, new_cases, new_deaths)

status(latin_america) # estrutura dos dados (missing etc)
freq(latin_america) # frequência das variáveis fator
plot_num(latin_america) # exploração das variáveis numéricas
profiling_num(latin_america) # estatísticas das variáveis numéricas

latin_america %>% filter(new_cases < 0)

# Modifiquei o filter aplicado aqui. A variável 'location' já não apresentava
# nenhum NA. A condição 'new_cases >= 0' dentro do filter já remove todos os NA
# (e todos os valores menores que 0) da variável 'new_cases'. A condição que
# acrescentei ao filter remove os NA restantes.

latin_america <- latin_america %>% filter(new_cases >= 0,
                                          !is.na(new_deaths))

# Prova de que todos os NA foram removidos da base

status(latin_america)
