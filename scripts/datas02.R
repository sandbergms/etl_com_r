url = 'https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv'

# Baixar a base de covidBR

covidBR = read.csv2(url, encoding='latin1', sep = ',')

# Filtrar para Pernambuco

covidPE <- subset(covidBR, state == 'PE')

# Modificar a coluna data de string para date

covidPE$date <- as.Date(covidPE$date, format = "%Y-%m-%d")

# Criar um sequencial de dias de acordo com o total de datas para a predição

covidPE$dia <- seq(1:length(covidPE$date))

# Criar vetor auxiliar de predição

predDia = data.frame(dia = covidPE$dia)

# Criar segundo vetor auxiliar

predSeq = data.frame(dia = seq(max(covidPE$dia)+1, max(covidPE$dia)+180))

# Juntar os dois vetores auxiliares

predDia <- rbind(predDia, predSeq)

library(drc)

# Fazendo a predição (log-log) de óbitos

fitLL <- drm(deaths ~ dia, fct = LL2.5(), data = covidPE, robust = 'mean')

# Observando o ajuste

plot(fitLL, log = "", main = "Log logistic")

# Usando o modelo para prever para frente, com base no vetor predDia

predLL <- data.frame(predicao = ceiling(predict(fitLL, predDia)))

# Criando uma sequência de datas para corresponder aos dias extra na base de
# predição

predLL$data <- seq.Date(as.Date('2020-03-12'), by = 'day',
                        length.out = length(predDia$dia))

# Juntando as informações observadas da base original

predLL <- merge(predLL, covidPE, by.x ='data', by.y = 'date', all.x = T)

library(plotly)

# Plotando tudo junto, para comparação

plot_ly(predLL) %>%
  add_trace(x = ~data, y = ~predicao, type = 'scatter', mode = 'lines',
            name = "Óbitos - Predição") %>%
  add_trace(x = ~data, y = ~deaths, name = "Óbitos - Observados",
            mode = 'lines') %>%
  layout(title = 'Predição de Óbitos por COVID 19 em Pernambuco',
         xaxis = list(title = 'Data', showgrid = FALSE),
         yaxis = list(title = 'Óbitos Acumulados por Dia', showgrid = FALSE),
         hovermode = "compare")

library(zoo)

# Média móvel de 7 dias para o número de novos óbitos divulgados

covidPE <- covidPE %>%
  mutate(newDeathsMM7 = round(rollmean(x = newDeaths, 7, align = "right",
                                       fill = NA),
                              2))

# Valor defasado em 7 dias

covidPE <- covidPE %>%
  mutate(newDeathsL7 = dplyr::lag(newDeaths, 7))

# Plotando tudo junto, para comparação

plot_ly(covidPE) %>%
  add_trace(x = ~date, y = ~newDeaths, type = 'scatter', mode = 'lines',
            name = "Novos Óbitos") %>%
  add_trace(x = ~date, y = ~newDeathsMM7, name = "Novos Óbitos MM7",
            mode = 'lines') %>%
  layout(title = 'Novos Óbitos por COVID19 em Pernambuco',
         xaxis = list(title = 'Data', showgrid = FALSE),
         yaxis = list(title = 'Novos Óbitos por Dia', showgrid = FALSE),
         hovermode = "compare")

library(xts)

# Transformar em séries temporais

covidPETS <- xts(covidPE$newDeaths, covidPE$date)

autoplot(covidPETS)

acf(covidPETS)
