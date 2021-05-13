library(data.table)

casos = 2e7

# Criação de uma base de dados ampla

baseAmpla = data.table(a = seq(1, casos),
                       b = sample(c("Norte", "Nordeste", "Sudeste", "Sul",
                                    "Centro-Oeste"),
                                  casos,
                                  replace = TRUE),
                       c = rpois(casos, 5),
                       d = rnorm(casos),
                       e = rbinom(casos, 1, 0.6),
                       f = rnbinom(casos, mu = 5, size = 15),
                       g = sample(c(1920, 1960, 2000), casos, replace = TRUE))

enderecoBase <- "bases_originais/baseAmpla.csv"

# A base é salva no disco

write.table(baseAmpla, enderecoBase, sep = ",",
            row.names = FALSE, quote = FALSE)

# Extração direta via read.csv

system.time(extracaoDireta <- read.csv(enderecoBase))

# Extração via função fread, que já faz amostragem automaticamente

system.time(extracaoFread <- fread(enderecoBase))

# Conferindo a interpretação das colunas

str(extracaoDireta)
str(extracaoFread)
tail(extracaoDireta)
tail(extracaoFread)
