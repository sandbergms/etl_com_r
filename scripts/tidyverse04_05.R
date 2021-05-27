library(funModeling)
library(tidyverse)
library(poliscidata)
library(validate)

# Eu fiz as atividades 4 e 5 (enriquecimento e validação) sobre tidyverse
# juntas, neste script.

# Nestas atividades, serão utilizadas as bases 'data_country' e 'world',
# respectivamente dos pacotes 'funModeling' e 'poliscidata'.

# Teste para identificar países que estão na base 'data_country', mas não estão
# na base 'world': foram encontrados 7 países; 5 deles estão nas 2 bases, mas
# com nomes diferentes; o tratamento desses 5 países é feito um pouco mais
# adiante.

unique(data_country$country[!(data_country$country %in% world$country)])

# Enriquecimento a partir de um left join entre as bases 'data_country' e
# 'world'. Resultado: uma base com o id de cada pessoa, informação se a pessoa
# está ou não gripada, e muitos dados sobre seu país de origem.

fluAndCountryData <- data_country %>%
  
  # Recodificação dos nomes de países que estão escritos de formas diferentes
  # nas bases 'data_country' e 'world'
  mutate(country = recode(country,
                          "Russian Federation" = "Russia",
                          "Moldova, Republic of" = "Moldova",
                          "Korea, Republic of" = "Korea, South",
                          "Iran, Islamic Republic of" = "Iran",
                          "Palestinian Territory" = "Palestine")) %>%
  
  # Left join entre as bases 'data_country' (após a recodificação) e 'world'. O
  # join foi feito pela coluna 'country' (não foi necessário colocar isso de
  # forma explícita no código, pois ambas as bases tinham essa coluna com o
  # mesmo nome).
  left_join(world)

# Validação

regras_fluAndCountryData <- validator(!is.na(person),
                                      !is.na(country),
                                      has_flu == "yes" | has_flu == "no")

validacao_fluAndCountryData <- confront(fluAndCountryData,
                                        regras_fluAndCountryData)

summary(validacao_fluAndCountryData)

plot(validacao_fluAndCountryData)
