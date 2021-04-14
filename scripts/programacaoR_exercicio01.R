nome <- c("Luiz", "Ana", "Amanda", "Pedro", "Maria")

tipoSanguineo <- c("AB-", "B+", "O+", "A-", "O+")

altura <- c(1.70, 1.82, 1.64, 1.90, 1.60)

# vetor booleano que diz se a pessoa tem menos do que 1,80m

menorQue1m80 <- altura < 1.80

informacoes <- data.frame(nome,
                          tipoSanguineo,
                          altura,
                          menorQue1m80)
