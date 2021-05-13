library(ff)

enderecoBase <- "bases_originais/baseAmpla.csv"

# Leitura do large data (e medição do tempo)

system.time(extracaoFF <- read.csv.ffdf(file = enderecoBase))

# Média dos valores da coluna 4

mean(extracaoFF[ , 4])

# Produto de 2 colunas

produtoColunas <- extracaoFF[ , 3] * extracaoFF[ , 6]

# Criação de uma amostra da base (25000 casos)

extracaoFFamostra <- extracaoFF[sample(nrow(extracaoFF), 25000), ]

# Regressão linear (usando a amostra)

lm(d ~ c + f, extracaoFFamostra)
