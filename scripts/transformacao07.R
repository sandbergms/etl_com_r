library(arules)
library(forcats)

# Número de casos

casos = 500

# Base com uma coluna de números

base = data.frame(numero = rnorm(casos))

# A base ganha uma nova coluna: a discretização da coluna 'numero'

base$categoriaDoNumero <- discretize(base$numero,
                                     method = "interval",
                                     breaks = 4,
                                     labels = c("1st quarter", "2nd quarter",
                                                "3rd quarter", "4th quarter"))

# Os fatores da base são transformados em 3 tipos: o mais frequente, o segundo
# mais frequente e outros

base$categoriaDoNumero <- fct_lump(base$categoriaDoNumero, n = 2)
