library(data.table)

(tarefaSemente <- addTaskCallback(function(...) {set.seed(135); TRUE}))

# Criação de uma base de dados com 500 casos e 4 variáveis (inicialmente, são
# criadas 3 variáveis, e, logo em seguida, é inserida mais 1)

base = data.table(x1 = rnorm(500),
                  x2 = rnorm(500),
                  x3 = rnorm(500))

base$y = 3 * base$x1 - 27 * base$x2 + 13 * base$x3 - 10

# A base 500 x 4 é enxergada como um vetor de 2000 de posições (seguindo a ordem
# da leitura ocidental: primeiro, da esquerda para a direita; depois, de cima
# para baixo). Desse vetor, 200 posições são escolhidas aleatoriamente.

posicoesAleatorias <- sample(1:2000, 200, replace = FALSE)

# Cada posição aleatória é mapeada para a respectiva linha e coluna da base de
# dados. Na base, cada uma dessas posições recebe o valor NA. Desse modo, é
# gerada uma base simulada, em que os NA estão distribuídos de maneira
# aleatória.

for (i in 1:200) {
  
  coluna <- posicoesAleatorias[i] %% 4
  
  if (coluna == 0)
    coluna <- 4
  
  ifelse(coluna == 4, linha <- posicoesAleatorias[i] / 4,
         linha <- posicoesAleatorias[i] %/% 4 + 1)
  
  base[linha, coluna] <- NA
  
}

library(Hmisc)

# Substituição dos NA da variável 'x1' via imputação numérica por tendência
# central, utilizando a média

base$x1 <- impute(base$x1, fun = mean)

# Substituição dos NA da variável 'x2' via hot deck por aleatoriedade

base$x2 <- impute(base$x2, "random")

removeTaskCallback(tarefaSemente)
