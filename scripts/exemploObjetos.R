# criação de uma lista

lista <- list(9, TRUE, "porta")


# modelo de regressão linear multivariada (bivariada), utilizando a base 'iris'
# variável dependente: área da pétala (Petal.Length * Petal.Width)
# variáveis independentes: Sepal.Length e Sepal.Width

regressaoIris <- lm( (Petal.Length * Petal.Width) ~ Sepal.Length + Sepal.Width,
                     iris)


# "prova" de que 'lista' é um objeto simples e
#                'regressaoIris' é um objeto complexo

str(lista)
str(regressaoIris)
