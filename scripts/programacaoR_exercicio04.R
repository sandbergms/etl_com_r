# centralização da base de dados 'iris': as 4 primeiras colunas são as
# centralizações das 4 colunas originais, e 5a coluna permaneceu inalterada

irisCentralizada <- iris

irisCentralizada$Sepal.Length <-
    irisCentralizada$Sepal.Length - mean(irisCentralizada$Sepal.Length)

irisCentralizada$Sepal.Width <-
    irisCentralizada$Sepal.Width - mean(irisCentralizada$Sepal.Width)

irisCentralizada$Petal.Length <-
    irisCentralizada$Petal.Length - mean(irisCentralizada$Petal.Length)

irisCentralizada$Petal.Width <-
    irisCentralizada$Petal.Width - mean(irisCentralizada$Petal.Width)

# histogramas de algumas colunas (da base original e da base centralizada) para
# comparação

hist(iris$Petal.Length)

hist(irisCentralizada$Petal.Length)

hist(iris$Sepal.Width)

hist(irisCentralizada$Sepal.Width)
