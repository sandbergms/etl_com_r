tarefaSemente <- addTaskCallback(function(...) {set.seed(97); TRUE})

tarefaSemente

# Distribuição normal de 150 casos gerados aleatoriamente

distribuicaoNormal <- rnorm(150)

# Função que recebe uma distribuição normal e faz um bootstrapping, calculando
# 100 vezes o desvio padrão para amostras de 20 casos. Retorna a média dos 100
# desvios padrões.

funcaoSdBoots100 <- function(x) {
    y <- replicate(100,
                   sd(sample(x, 20, replace = TRUE),
                      na.rm = FALSE))
    return(mean(y))
}

# Teste da função

funcaoSdBoots100(distribuicaoNormal)

removeTaskCallback(tarefaSemente)
