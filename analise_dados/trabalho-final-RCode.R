options(scipen = 999)

library(tidyverse)

# Base de dados

base <- readRDS("surveyFiltrado.rds")

# Removendo a variável 'intenção de voto' (ela não será utilizada neste
# trabalho), transformando as variáveis que são strings em fatores, e
# reordenando os níveis de alguns fatores

base <- base %>%
  select(1:7, 9, 10) %>%
  mutate(genero = as_factor(genero),
         estadoCivil = as_factor(estadoCivil),
         raca = as_factor(raca),
         religiao = as_factor(religiao),
         escolaridade = as_factor(escolaridade),
         renda = as_factor(renda),
         raca = fct_relevel(raca, "Branca"),
         religiao = fct_relevel(religiao, "Evangélicos"),
         escolaridade = fct_relevel(escolaridade, "Pré-escolar",
                                    "Ensino fundamental", "Ensino médio",
                                    "Graduação", "Especialização", "Mestrado"),
         renda = fct_relevel(renda, "Até 1 SM", "De 1 a 2 SM", "De 2 a 4 SM",
                             "De 4 a 10 SM"))

# Gráficos adequados para cada uma das variáveis

ggplot(base, aes(mudancaVoto)) +
  geom_bar()

ggplot(base, aes(crencaFakeNews)) +
  geom_histogram()

ggplot(base, aes(genero)) +
  geom_bar()

ggplot(base, aes(idade)) +
  geom_histogram(binwidth = 0.5)

ggplot(base, aes(estadoCivil)) +
  geom_bar()

ggplot(base, aes(raca)) +
  geom_bar()

ggplot(base, aes(religiao)) +
  geom_bar()

ggplot(base, aes(escolaridade)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(base, aes(renda)) +
  geom_bar()

# Gráficos e testes para descrever a associação entre pares de variáveis

ggplot(base, aes(mudancaVoto, crencaFakeNews)) +
  geom_jitter(alpha = 0.1)
cor.test(base$mudancaVoto, base$crencaFakeNews)

ggplot(base, aes(mudancaVoto, fill = genero)) +
  geom_bar(position = "fill")
t.test(mudancaVoto ~ genero, data = base)

ggplot(base, aes(mudancaVoto, idade)) +
  geom_jitter(alpha = 0.1)
cor.test(base$mudancaVoto, base$idade)

ggplot(base, aes(mudancaVoto, fill = estadoCivil)) +
  geom_bar(position = "fill")
aov(mudancaVoto ~ estadoCivil, data = base) %>%
  summary()
aov(mudancaVoto ~ estadoCivil, data = base) %>%
  TukeyHSD()

ggplot(base, aes(mudancaVoto, fill = raca)) +
  geom_bar(position = "fill")
aov(mudancaVoto ~ raca, data = base) %>%
  summary()
aov(mudancaVoto ~ raca, data = base) %>%
  TukeyHSD()

ggplot(base, aes(mudancaVoto, fill = religiao)) +
  geom_bar(position = "fill")
aov(mudancaVoto ~ religiao, data = base) %>%
  summary()
aov(mudancaVoto ~ religiao, data = base) %>%
  TukeyHSD()

ggplot(base, aes(mudancaVoto, fill = escolaridade)) +
  geom_bar(position = "fill")
aov(mudancaVoto ~ escolaridade, data = base) %>%
  summary()
aov(mudancaVoto ~ escolaridade, data = base) %>%
  TukeyHSD()

ggplot(base, aes(mudancaVoto, fill = renda)) +
  geom_bar(position = "fill")
aov(mudancaVoto ~ renda, data = base) %>%
  summary()
aov(mudancaVoto ~ renda, data = base) %>%
  TukeyHSD()

ggplot(base, aes(crencaFakeNews, fill = genero)) +
  geom_histogram(position = "fill")
t.test(crencaFakeNews ~ genero, data = base)

ggplot(base, aes(crencaFakeNews, idade)) +
  geom_jitter(alpha = 0.1)
cor.test(base$crencaFakeNews, base$idade)

ggplot(base, aes(crencaFakeNews, fill = estadoCivil)) +
  geom_histogram(position = "fill")
aov(crencaFakeNews ~ estadoCivil, data = base) %>%
  summary()
aov(crencaFakeNews ~ estadoCivil, data = base) %>%
  TukeyHSD()

ggplot(base, aes(crencaFakeNews, fill = raca)) +
  geom_histogram(position = "fill")
aov(crencaFakeNews ~ raca, data = base) %>%
  summary()
aov(crencaFakeNews ~ raca, data = base) %>%
  TukeyHSD()

ggplot(base, aes(crencaFakeNews, fill = religiao)) +
  geom_histogram(position = "fill")
aov(crencaFakeNews ~ religiao, data = base) %>%
  summary()
aov(crencaFakeNews ~ religiao, data = base) %>%
  TukeyHSD()

ggplot(base, aes(crencaFakeNews, fill = escolaridade)) +
  geom_histogram(position = "fill")
aov(crencaFakeNews ~ escolaridade, data = base) %>%
  summary()
aov(crencaFakeNews ~ escolaridade, data = base) %>%
  TukeyHSD()

ggplot(base, aes(crencaFakeNews, fill = renda)) +
  geom_histogram(position = "fill")
aov(crencaFakeNews ~ renda, data = base) %>%
  summary()
aov(crencaFakeNews ~ renda, data = base) %>%
  TukeyHSD()

# Regressão logística

regressaoLogistica <- glm(mudancaVoto ~ ., data = base, family = "binomial")

# Pressupostos da regressão:

# Pressuposto de homoscedasticidade

plot(regressaoLogistica, 3)

library(lmtest)
library(sandwich)

# Correção das estimativas do modelo

coeftest(regressaoLogistica, vcov = vcovHC(regressaoLogistica, type = "HC3"))

# Pressuposto de linearidade dos parâmetros

plot(regressaoLogistica, 1)

# Pressuposto de autocorrelação

acf(regressaoLogistica$residuals)

# Pressuposto de normalidade dos resíduos

plot(regressaoLogistica, 2)

library(car)

# Pressuposto de não-multicolinearidade

vif(regressaoLogistica)

library(margins)

# Sumário da regressão

margins_summary(regressaoLogistica)

# Previsões das probabilidades

previsoes <- predict(regressaoLogistica, type = "response")

library(InformationValue)

# Matriz de confusão com o resultado em proporções

confusionMatrix(base$mudancaVoto, previsoes) %>%
  prop.table()

# Sensitividade

sensitivity(base$mudancaVoto, previsoes)

# Especificidade

specificity(base$mudancaVoto, previsoes)

library(pscl)

# Pseudo-R2

pR2(regressaoLogistica)

library(sjPlot)

# Gráfico das razões de chance. Algumas categorias (de algumas variáveis) não
# foram exibidas no gráfico, pois elas estavam se apresentando de forma anômala
# no mesmo.

plot_model(regressaoLogistica,
           rm.terms = c("raca [Amarela, Indígena, Outra]", "religiaoAteu",
                        "escolaridade [Ensino fundamental, Ensino médio,
                        Graduação, Especialização, Mestrado, Doutorado]",
                        "rendaDe 1 a 2 SM"))

# Gráfico refeito: as razões de chance foram transformadas para uma mesma escala
# (quantidade de desvios padrões)

plot_model(regressaoLogistica,
           rm.terms = c("raca [Amarela, Indígena, Outra]", "religiaoAteu",
                        "escolaridade [Ensino fundamental, Ensino médio,
                        Graduação, Especialização, Mestrado, Doutorado]",
                        "rendaDe 1 a 2 SM"),
           type = "std")

# Testando a associação entre gênero e estado civil

chisq.test(base$genero, base$estadoCivil)

# Regressão logística com uma interação entre gênero e estado civil

regrInteracao <-
  glm(mudancaVoto ~ crencaFakeNews + genero + idade + estadoCivil + raca +
        religiao + escolaridade + renda + genero * estadoCivil,
      data = base,
      family = "binomial")

summary(regrInteracao)

# Representação gráfica dessa regressão

plot_model(regrInteracao, type = "pred", terms = c("genero", "estadoCivil"),
           data = base)
