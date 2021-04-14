# Função que transforma os valores de um vetor numérico em percentuais
# (considerando o maior valor do vetor como 100%)

calculaPercentuais <- function(x) {
    x <- x / max(x) * 100
    return(x)
}

# Utilizando o 'sapply': aplicando a função 'calculaPercentuais' a todas as
# colunas da base de dados 'iris' (com exceção da coluna 5). O resultado é
# atribuído a uma nova base: 'irisPercentuais'.

irisPercentuais <- sapply(iris[ , -5], calculaPercentuais)
