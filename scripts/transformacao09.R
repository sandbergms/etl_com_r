library(dplyr)

# Número de casos

casos = 500

# Base de dados

base = data.frame(a = rnorm(casos),
                  b = rnbinom(casos, mu = 5, size = 15),
                  c = sample(c("Norte", "Nordeste", "Sudeste", "Sul",
                               "Centro-Oeste"),
                             casos,
                             replace = TRUE),
                  d = sample(c(1920, 1960, 2000), casos, replace = TRUE))

# Exemplo de sumário

base %>% summarise("mediana de b" = median(b))

# Exemplo de agrupamento

base %>% group_by(c) %>% summarise("mediana de a" = median(a))

# Exemplo de manipulação de colunas

base <- base %>% rename(regiao = c, ano = d)

# Exemplo de manipulação de casos

baseFiltrada <- base %>% filter(a >= 0)
