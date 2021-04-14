# Criação de um vetor de probabilidades, para ser usado nas duas funções
# quantílicas que virão a seguir.

vetorProbabilidades <- 1:99 / 100

# Criação de uma variável normal, que recebe o resultado de uma função
# quantílica para a distribuição normal. A função quantílica recebe como entrada
# um vetor de probabilidades.

variavelNormalQuantilica <- qnorm(vetorProbabilidades, lower.tail = TRUE,
                                  log.p = FALSE)

# Criação de uma variável binomial, que recebe o resultado de uma função
# quantílica para a distribuição binomial com tamanho igual a 1 e probabilidade
# igual a 30%. A função quantílica recebe como entrada um vetor de
# probabilidades.

variavelBinomialQuantilica <- qbinom(vetorProbabilidades, 1, 0.3,
                                    lower.tail = TRUE, log.p = FALSE)

# Criação de uma variável de index, com o tamanho da variável normal (que, nos
# exemplos aqui criados, é igual ao tamanho da variável binomial).

variavelIndex <- seq(1, length(variavelNormalQuantilica))
