tarefaSemente <- addTaskCallback(function(...) {set.seed(97); TRUE})

tarefaSemente

# distribuição normal de 150 casos gerados aleatoriamente

distribuicaoNormal <- rnorm(150)

# bootstrapping: calculando 100 vezes o desvio padrão para amostras de 20 casos
# da distribuição normal acima

sdBoots100 <- replicate(100,
                        sd(sample(distribuicaoNormal,
                                  20,
                                  replace = TRUE),
                           na.rm = FALSE))

# exibe a média do bootstrapping acima

mean(sdBoots100)

removeTaskCallback(tarefaSemente)
