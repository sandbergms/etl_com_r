# carrega a base de sinistros de transito do site da PCR

sinistrosRecife2019Raw <- read.csv2(
  'http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv',
  sep = ';',
  encoding = 'UTF-8')

sinistrosRecife2020Raw <- read.csv2(
  'http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv',
  sep = ';',
  encoding = 'UTF-8')

sinistrosRecife2021Raw <- read.csv2(
  'http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv',
  sep = ';',
  encoding = 'UTF-8')

# observa a estrutura dos dados das 3 bases
# a partir daí, percebe-se que a base de 2019 possui 3 colunas a mais (colunas
# 10, 11 e 12) e que o label da coluna 'data' está escrito todo em minúsculo nas
# bases de 2020 e 2021 (data), mas está escrito todo em maiúsculo na base de
# 2019 (DATA)

str(sinistrosRecife2019Raw)
str(sinistrosRecife2020Raw)
str(sinistrosRecife2021Raw)

# cria uma nova base a partir da base de 2019, excluindo as 3 colunas extra e
# renomeando a coluna 'DATA' para 'data'

sinistrosRecife2019Filtered <- data.frame(data = sinistrosRecife2019Raw$DATA)

sinistrosRecife2019Filtered[ , 2:38] <- sinistrosRecife2019Raw[ , c(2:9, 13:41)]

# junta as 3 bases de dados com comando rbind (juntas por linhas)

sinistrosRecifeRaw <- rbind(sinistrosRecife2019Filtered, sinistrosRecife2020Raw,
                            sinistrosRecife2021Raw)

# observa a estrutura dos dados

str(sinistrosRecifeRaw)

# modifica a data para formato date

sinistrosRecifeRaw$data <- as.Date(sinistrosRecifeRaw$data, format = "%Y-%m-%d")

# modifica natureza do sinistro de texto para fator

sinistrosRecifeRaw$natureza_acidente <-
  as.factor(sinistrosRecifeRaw$natureza_acidente)

# mais uma coluna do data frame transformada de texto para fator

sinistrosRecifeRaw$tempo_clima <- as.factor(sinistrosRecifeRaw$tempo_clima)

# cria função para substituir not available (na) por 0

naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}

# aplica a função naZero a todas as colunas de contagem

sinistrosRecifeRaw[, 15:25] <- sapply(sinistrosRecifeRaw[, 15:25], naZero)

# exporta em formato nativo do R

saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrão para interoperabilidade

write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")
