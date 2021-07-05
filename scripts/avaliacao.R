# 1. Extraia a base geral de covid em Pernambuco --------------------------

baseGeral <- read.csv2("https://dados.seplag.pe.gov.br/apps/basegeral.csv",
                       sep = ';', encoding = 'UTF-8')

#--------------------------------------------------------------------------


baseModif <- baseGeral

library(tidyverse)
library(lubridate)

baseModif <- baseModif %>%
  mutate(semanaEpi = epiweek(as.Date(dt_notificacao)),
         confirmado = ifelse(classe == "CONFIRMADO", 1, 0),
         obito = ifelse(is.na(dt_obito), 0, 1))


# 2. Calcule, para cada município do Estado, o total de casos confirmados e o
# total de óbitos por semana epidemiológica ---------------------------------

confirmadosEObitos <- baseModif %>%
  group_by(municipio, semanaEpi) %>%
  summarise(totalConfirmados = sum(confirmado),
            totalObitos = sum(obito))

#----------------------------------------------------------------------------


library(readxl)

tabela6579 <- read_excel('bases_originais/tabela6579.xlsx', sheet=1)

tabela6579 <- tabela6579 %>%
  as.data.frame() %>%
  rename(municipio = `Tabela 6579 - População residente estimada`,
         populacao = ...2) %>%
  filter(grepl("PE", municipio)) %>%
  mutate(municipio = toupper(sub(" \\(PE\\).*", "", municipio)),
         populacao = as.numeric(populacao))

library(fuzzyjoin)


# 3. Enriqueça a base criada no passo 2 com a população de cada município,
# usando a tabela6579 do sidra ibge.

confirmadosEObitos <- stringdist_join(as.data.frame(confirmadosEObitos),
                                      tabela6579,
                                      mode='left')


# 4. Calcule a incidência (casos por 100.000 habitantes) e letalidade (óbitos
# por 100.000 habitantes) por município a cada semana epidemiológica.

confirmadosEObitos <- confirmadosEObitos %>%
  mutate(incidencia = totalConfirmados * 100000 / populacao,
         letalidade = totalObitos * 100000 / populacao)
