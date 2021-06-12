library(dplyr)
library(data.table)

# Carrega dados covid19 Pernambuco

covid19PE <- fread('https://dados.seplag.pe.gov.br/apps/basegeral.csv')

covid19PEMun <- covid19PE %>%
  count(municipio, sort = T, name = 'casos') %>%
  mutate(casos2 = sqrt(casos), casosLog = log10(casos))

# Identificação de outliers na variável 'casosLog', utilizando a distância
# interquartil

# Valores considerados destoantes (outliers)

(covid19PEOut <- boxplot.stats(covid19PEMun$casosLog)$out)

# Observações que apresentaram esses valores destoantes

which(covid19PEMun$casosLog %in% c(covid19PEOut))
