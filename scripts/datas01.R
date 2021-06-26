# Objeto de data e tempo (vetor de strings)

dataETempo <- c("2001-01-25 13:30", "2007-03-16 21:20", "2013-05-03 18:45",
                "2020-07-29 05:50")

# Conversão para data

data01 <- as.Date(dataETempo)

# Conversão para POSIXct

data02 <- as.POSIXct(dataETempo)

# Conversão para POSIXlt

data03 <- as.POSIXlt(dataETempo)

library(lubridate)

# Extração do mês, pelo nome

month(data03, label = T) 

# Sequência de datas

sequencia <- seq(data01[1], data01[2], by = "27 days")

# Acrescentando um período

data03 + minutes(250)
