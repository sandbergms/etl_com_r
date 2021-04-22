set.seed(25)

# Criação da base de dados original
# A variável qualitativa é criada inicialmente com o valor "No value" para
# todos os casos. Um pouco mais adiante, ela recebe os devidos valores, de
# acordo com o que é solicitado no exercício.

baseOriginal <- data.frame(variavelNormal01 = rnorm(500),
                           variavelNormal02 = rnorm(500),
                           variavelPoisson = rpois(500, 5),
                           variavelBinomNegativa = rnbinom(500, mu = 5,
                                                           size = 15),
                           variavelBinomial = rbinom(500, 1, 0.6),
                           variavelQualitativa = rep("No value", 500),
                           variavelIndex = seq(1, 500))

# Prova de que as duas variáveis normais da base de dados original possuem
# diferentes desvios padrões. O resultado do teste abaixo é FALSE.

sd(baseOriginal$variavelNormal01) == sd(baseOriginal$variavelNormal02)

# Atribuição dos devidos valores à variável qualitativa da base de dados
# original

for (i in 1:500) {
  if (baseOriginal$variavelBinomial[i] == 1) {
    baseOriginal$variavelQualitativa[i] <- "Number one"
  } else {
    baseOriginal$variavelQualitativa[i] <- "Number zero"
  }
}

# Centralização das variáveis normais da base de dados original

baseOriginal$variavelNormal01 <-
  baseOriginal$variavelNormal01 - mean(baseOriginal$variavelNormal01)

baseOriginal$variavelNormal02 <-
  baseOriginal$variavelNormal02 - mean(baseOriginal$variavelNormal02)

# Trocando os zeros (0) por um (1) nas variáveis de contagem

for (i in 1:500) {
  if (baseOriginal$variavelPoisson[i] == 0) {
    baseOriginal$variavelPoisson[i] <- 1
  }
  if (baseOriginal$variavelBinomNegativa[i] == 0) {
    baseOriginal$variavelBinomNegativa[i] <- 1
  }
}

# Criação de um novo data frame com uma amostra (100 casos) da base de dados
# original

baseAmostra <-
  baseOriginal[sample(baseOriginal$variavelIndex, 100, replace = FALSE), ]
