library(poliscidata)
library(tidyverse)
library(fuzzyjoin)

# Nesta atividade, será utilizada a base 'world', do pacote 'poliscidata'.

# Criação de uma base de dados em que os nomes dos países estão em português

paises <- c("Brasil", "Canadá", "Egito", "França", "Grécia", "Itália", "Japão",
            "Jordânia", "Luxemburgo", "Uruguai")

basePaisesEmPortugues <- data.frame(country = paises,
                                    x = rnorm(10))

# Para a criação dessa nova base de dados, foi realizada a junção de duas bases
# por nomes não categorizados (em uma, os nomes dos países estão em inglês; na
# outra, estão em português)

worldModificado <- world[ , c(1:3, 15)] %>%
  stringdist_join(basePaisesEmPortugues, mode = 'left') %>%
  mutate(x = ifelse(is.na(x), 0, x))

# Para a criação dessa nova base de dados, foi realizada uma busca pelos textos
# 'Latin' ou 'USA' na coluna 'regionun'. Desse modo, a base foi filtrada: foram
# capturados os casos com os valores 'Latin America/Caribbean' ou 'USA/Canada',
# e os demais casos foram descartados.

newWorld <- worldModificado[grepl("Latin|USA", worldModificado$regionun), ]
