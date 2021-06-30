# Extraindo a base geral de covid em Pernambuco

baseGeral <- read.csv2("https://dados.seplag.pe.gov.br/apps/basegeral.csv",
                       sep = ';', encoding = 'UTF-8')

baseModif <- baseGeral

# Substituindo os "" por NA

baseModif$sintomas <- ifelse(baseModif$sintomas == "", NA, baseModif$sintomas)

library(Hmisc)

# Corrigindo os NA da coluna 'sintomas' através de imputação randômica

baseModif$sintomas <- impute(baseModif$sintomas, "random")

library(tidyverse)

# Criando 2 variáveis binárias, indicando se cada caso foi ou não confirmado, e
# se foi ou não negativo

baseModif <- baseModif %>%
  mutate(confirmado = ifelse(classe == "CONFIRMADO", 1, 0),
         negativo = ifelse(classe == "NEGATIVO", 1, 0))

# Calculando, para cada município do Estado, o total de casos confirmados e
# negativos

confirmadosENegativos <- baseModif %>%
  group_by(municipio) %>%
  summarise(totalConfirmados = sum(confirmado),
            totalNegativos = sum(negativo))

# Criando uma variável binária, indicando se o sintoma inclui tosse ou não

baseModif <- baseModif %>%
  mutate(tosse = ifelse(grepl("TOSSE", sintomas), 1, 0))

# Criando 2 variáveis binárias, indicando se cada caso foi ou não "confirmado e
# com tosse", e se foi ou não "negativo e com tosse"

baseModif <- baseModif %>%
  mutate(confirmadoComTosse = ifelse(confirmado & tosse, 1, 0),
         negativoComTosse = ifelse(negativo & tosse, 1, 0))

# Calculando quantos casos confirmados e negativos tiveram tosse como sintoma

totalConfirmadosComTosse <- sum(baseModif$confirmadoComTosse)
totalNegativosComTosse <- sum(baseModif$negativoComTosse)

# Agrupando os dados para o Estado, pela data de notificação

basePelaData <- baseModif %>%
  mutate(dt_notificacao = as.Date(dt_notificacao, format = "%Y-%m-%d")) %>%
  group_by(dt_notificacao) %>%
  summarise(nConfirmados = sum(confirmado),
            nNegativos = sum(negativo),
            nTosse = sum(tosse),
            nConfirmadosComTosse = sum(confirmadoComTosse),
            nNegativosComTosse = sum(negativoComTosse))

# Excluindo a última linha (data com valor NA) e convertendo a base para data
# frame

basePelaData <- as.data.frame(basePelaData[1:498, ])

# Criando uma nova base com as datas contínuas (dia a dia), fechando os
# "buracos" da base anterior

baseCompletaData <- data.frame(
  dt_notificacao = seq(basePelaData[1,1], basePelaData[498, 1], by = "day")
)

# Enriquecendo a nova base com os dados da base anterior

baseCompletaData <- left_join(baseCompletaData, basePelaData)

# Função que substitui NA por 0

substituiNA <- function(x) {
  
  ifelse(is.na(x), 0, x)
  
}

# Substituindo os NA por 0 na nova base

baseCompletaData[ , 2:6] <- sapply(baseCompletaData[ , 2:6], substituiNA)

library(zoo)

# Estimando a média móvel de 7 dias de confirmados e negativos

baseCompletaData <- baseCompletaData %>%
  mutate(nConfirmadosMM7 = round(rollmean(x = nConfirmados, 7, align = "right",
                                          fill = NA),
                                 2),
         nNegativosMM7 = round(rollmean(x = nNegativos, 7, align = "right",
                                        fill = NA),
                               2))
