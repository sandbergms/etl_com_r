# testando o 'while' e o 'if'

x <- 1
while (x <= 20) {
    if (x <= 10) {
        print(paste("Ainda não passei do número 10.",
                    "Estou no número",
                    x))
    } else {
      print(paste("Finalmente passei do número 10.",
                  "Estou no número",
                  x))
    }
    x <- x + 1
}
