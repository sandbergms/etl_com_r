# carrega base de dados original (Diário Oficial de Recife 2021)

diarioOficial <- read.csv2("http://dados.recife.pe.gov.br/dataset/e968d1ba-a1f3-4c7c-ab91-b1ecf0919178/resource/bc3c2173-6d0f-42c3-bac7-563205b21175/download/diario-oficial-iso-8859-1.csv",
                           sep = ',', encoding = 'UTF-8')

# mantém só os 40 primeiros casos da base, para garantir que, quando a base para
# atualização for carregada, haja "novos casos" (simulação de novos casos para
# este exercício)

diarioOficial <- diarioOficial[1:40, ]

# carrega base de dados para atualização

diarioOficialNew <- read.csv2("http://dados.recife.pe.gov.br/dataset/e968d1ba-a1f3-4c7c-ab91-b1ecf0919178/resource/bc3c2173-6d0f-42c3-bac7-563205b21175/download/diario-oficial-iso-8859-1.csv",
                              sep = ',', encoding = 'UTF-8')

# compara usando a chave primária

diarioOficialIncremento <- (!diarioOficialNew$id %in% diarioOficial$id)

# junta base original e incremento

diarioOficial <- rbind(diarioOficial,
                       diarioOficialNew[diarioOficialIncremento, ])
