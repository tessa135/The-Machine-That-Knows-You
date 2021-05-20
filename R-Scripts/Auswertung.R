#install.packages("MVN")
#install.packages("ggpubr")
#install.packages("psych")
#install.packages("matrixStats")

library(dplyr)
library(tidyverse)
library(e1071)
library(purrr)
library(MVN)
library(ggpubr)
library(psych)
library(GGally)
library(matrixStats)

dat_auswertung <-
  read_csv("/Users/tessalottermann/Documents/Dokumente/Thesis/clean_data.csv")

# Auswertung KIT ---------------
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (Misstrauen = mean(c(KIT_1, KIT_2, KIT_3, KIT_4, KIT_5)))
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (Vertrauen = mean(c(KIT_6, KIT_7, KIT_8, KIT_9, KIT_10, KIT_11)))

#Auswertung Godspeed --------------
dat_auswertung <- dat_auswertung %>% rowwise() %>% mutate (GQS_5_1_i = 6 - GQS_5_1)

dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (Likeability = mean(c(
    GQS_3_1, GQS_3_2, GQS_3_3, GQS_3_4, GQS_3_5
  )))
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (Kompetenz = mean(c(
    GQS_4_1, GQS_4_2, GQS_4_3, GQS_4_4, GQS_4_5
  )))
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (Sicherheit = mean(c(GQS_5_1_i, GQS_5_2, GQS_5_3)))

dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (Sicherheit2 = mean(c(GQS_5_1_i, GQS_5_2)))


#Cronbach's Alpha Skalen------------------------

alpha(subset(dat_auswertung, select = c(KIT_1, KIT_2, KIT_3, KIT_4, KIT_5)), check.keys =
        TRUE)
alpha(subset(
  dat_auswertung,
  select = c(KIT_6, KIT_7, KIT_8, KIT_9, KIT_10, KIT_11)
), check.keys = TRUE)

alpha(subset(
  dat_auswertung,
  select = c(GQS_3_1, GQS_3_2, GQS_3_3, GQS_3_4, GQS_3_5)
), check.keys = TRUE)
alpha(subset(
  dat_auswertung,
  select = c(GQS_4_1, GQS_4_2, GQS_4_3, GQS_4_4, GQS_4_5)
), check.keys = TRUE)
alpha(subset(dat_auswertung, select = c(GQS_5_1_i, GQS_5_2, GQS_5_3)), check.keys =
        TRUE)
alpha(subset(dat_auswertung, select = c(UEQS_1_t, UEQS_2_t, UEQS_3_t, UEQS_4_t)), check.keys =
        TRUE)
alpha(subset(dat_auswertung, select = c(UEQS_5_t, UEQS_6_t, UEQS_7_t, UEQS_8_t)), check.keys =
        TRUE)

alpha(subset(dat_auswertung, select = c(GQS_5_1_i, GQS_5_2)), check.keys =
        TRUE)
cor(dat_auswertung[c(
  "GQS_5_1_i",
  "GQS_5_2",
  "GQS_5_3"
)]) %>% round(2)
cor(c(GQS_5_1_i, GQS_5_2, GQS_5_3))
#Auswertung UEQS -------------------------
#Für weitere Details siehe Short_UEQ_Data_Analysis_Tool

dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (UEQS_1_t = UEQS_1-4)
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (UEQS_2_t = UEQS_2-4)
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (UEQS_3_t = UEQS_3-4)
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (UEQS_4_t = UEQS_4-4)
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (UEQS_5_t = UEQS_5-4)
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (UEQS_6_t = UEQS_6-4)
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (UEQS_7_t = UEQS_7-4)
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (UEQS_8_t = UEQS_8-4)

dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (Pragmatische_Qualität = mean(c(UEQS_1_t, UEQS_2_t, UEQS_3_t, UEQS_4_t)))

dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (Hedonische_Qualität = mean(c(UEQS_5_t, UEQS_6_t, UEQS_7_t, UEQS_8_t)))

dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (Allg_Qualität = mean(c(UEQS_1_t, UEQS_2_t, UEQS_3_t, UEQS_4_t, UEQS_5_t, UEQS_6_t, UEQS_7_t, UEQS_8_t)))

# Unterschiede zwischen Vrohersage und tatsächlichem Wert ermitteln -----------------------

dat_auswertung <-
  dat_auswertung %>% mutate(Abweichung1 = abs(Prediction1 - E7))

dat_auswertung <-
  dat_auswertung %>% mutate(Abweichung2 = abs(Prediction2 - O2))

dat_auswertung <-
  dat_auswertung %>% mutate(Abweichung3 = abs(Prediction3 - A6))

dat_auswertung <-
  dat_auswertung %>% mutate(Abweichung4 = abs(Prediction4 - A4))

dat_auswertung <-
  dat_auswertung %>% mutate(Abweichung5 = abs(Prediction5 - C8))

#Abweichungen für Vorhersage 6 berechnen, falls tatsächliche Antwort nicht gespeichert wurde
dat_auswertung <-
  dat_auswertung %>% mutate(Abweichung6 = ifelse((TFPred6 == 0 &
                                                    is.na(E3)), NA, (abs(Prediction6 - E3))))

#Falsche Vorhersagen ohne tatsächlichen Wert werden als zu große Abweichung werten
dat_auswertung$Abweichung6[is.na(dat_auswertung$Abweichung6)] <- 6


dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (Abweichung_Extraversion = mean(c(Abweichung1, Abweichung6), na.rm =
                                                                            TRUE))
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (Abweichung_Agreeableness = mean(c(Abweichung3, Abweichung4)))

dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (Abweichung_Openness = Abweichung2)

dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate (Abweichung_Conciousness = Abweichung5)

#Testen, ob trotz Angabe falscher Vorhersage, tatsächliche Antwort und Vorhersage doch übereinstimmen --------------------------

sum(dat_auswertung$TFPred1==0&dat_auswertung$Abweichung1==0)
sum(dat_auswertung$TFPred2==0&dat_auswertung$Abweichung2==0)
sum(dat_auswertung$TFPred3==0&dat_auswertung$Abweichung3==0)
sum(dat_auswertung$TFPred4==0&dat_auswertung$Abweichung4==0)
sum(dat_auswertung$TFPred5==0&dat_auswertung$Abweichung5==0)

dat_auswertung[dat_auswertung$TFPred1==0&dat_auswertung$Abweichung1==0,]
dat_auswertung[dat_auswertung$TFPred2==0&dat_auswertung$Abweichung2==0,]
dat_auswertung[dat_auswertung$TFPred3==0&dat_auswertung$Abweichung3==0,]
dat_auswertung[dat_auswertung$TFPred4==0&dat_auswertung$Abweichung4==0,]
dat_auswertung[dat_auswertung$TFPred5==0&dat_auswertung$Abweichung5==0,]
dat_auswertung[dat_auswertung$TFPred6==0&dat_auswertung$Abweichung6==0,]

hist(dat_auswertung$Prediction5)
kurtosis(dat_auswertung$Prediction2)

# Prozentuale richtige Antworten ----------------------------------
#table(dat_auswertung$TFPred1)
#table(dat_auswertung$TFPred2)

# sum(dat_auswertung$TFPred1 == 1) / nrow(dat_auswertung)
# 
# sum(dat_auswertung$TFPred2 == 1) / nrow(dat_auswertung)
# 
# sum(dat_auswertung$TFPred3 == 1) / nrow(dat_auswertung)
# 
# sum(dat_auswertung$TFPred4 == 1) / nrow(dat_auswertung)
# 
# sum(dat_auswertung$TFPred5 == 1) / nrow(dat_auswertung)
# 
# sum(dat_auswertung$TFPred6 == 1) / nrow(dat_auswertung)


sum(dat_auswertung$Abweichung1 == 0) / nrow(dat_auswertung)

sum(dat_auswertung$Abweichung2 == 0) / nrow(dat_auswertung)

sum(dat_auswertung$Abweichung3 == 0) / nrow(dat_auswertung)

sum(dat_auswertung$Abweichung4 == 0) / nrow(dat_auswertung)

sum(dat_auswertung$Abweichung5 == 0) / nrow(dat_auswertung)

sum(dat_auswertung$Abweichung6 == 0) / nrow(dat_auswertung)

## Anzahl Volltreffer und Abweichungen pro Person berechnen -------------------
dat_auswertung <-
  dat_auswertung %>% mutate(Volltreffer = rowSums(cbind(
    TFPred1, TFPred2, TFPred3, TFPred4, TFPred5, TFPred6
  ) == 1))
dat_auswertung <-
  dat_auswertung %>% mutate(Plusminus1 = rowSums(
    cbind(
      Abweichung1,
      Abweichung2,
      Abweichung3,
      Abweichung4,
      Abweichung5,
      Abweichung6
    ) == 1
  ))
dat_auswertung <-
  dat_auswertung %>% mutate(Plusminus2 = rowSums(
    cbind(
      Abweichung1,
      Abweichung2,
      Abweichung3,
      Abweichung4,
      Abweichung5,
      Abweichung6
    ) == 2
  ))

dat_auswertung$Abweichung6[dat_auswertung$Abweichung6 == 6] <- NA
dat_auswertung <-
  dat_auswertung %>% mutate(Mittlere_Abweichung = rowMeans(
    cbind(
      Abweichung1,
      Abweichung2,
      Abweichung3,
      Abweichung4,
      Abweichung5,
      Abweichung6
    ),
    na.rm = TRUE
  ))


# Voraussetzungen prüfen -------------------------
hist(dat_auswertung$Misstrauen)
hist(dat_auswertung$Vertrauen)
hist(dat_auswertung$Likeability)
hist(dat_auswertung$Kompetenz)
hist(dat_auswertung$Sicherheit)

table(unlist(dat_auswertung[paste0("Abweichung", 1:6)]))
summary(dat_auswertung$Abweichung6)
table(unlist(dat_auswertung[paste0("TFPred", 1:6)]))
summary(dat_auswertung$Abweichung6)
table(dat_auswertung$TFPred1)

shapiro.test(dat_auswertung$Misstrauen)
shapiro.test(dat_auswertung$Vertrauen)
shapiro.test(dat_auswertung$Likeability)
shapiro.test(dat_auswertung$Kompetenz)
shapiro.test(dat_auswertung$Sicherheit)

shapiro.test(dat_auswertung$Abweichung1)
shapiro.test(dat_auswertung$Abweichung2)
shapiro.test(dat_auswertung$Abweichung3)
shapiro.test(dat_auswertung$Abweichung4)
shapiro.test(dat_auswertung$Abweichung5)
shapiro.test(dat_auswertung$Abweichung6)

# Korrelationen berechnen --------------
## Volltreffer -------------------------

cor.test(dat_auswertung$Volltreffer, dat_auswertung$Misstrauen)
cor.test(dat_auswertung$Volltreffer, dat_auswertung$Vertrauen)
cor.test(dat_auswertung$Volltreffer, dat_auswertung$Likeability)
cor.test(dat_auswertung$Volltreffer, dat_auswertung$Kompetenz)
cor.test(dat_auswertung$Volltreffer, dat_auswertung$Sicherheit)

# plot(dat_auswertung$Volltreffer, dat_auswertung$Misstrauen)
# plot(dat_auswertung$Volltreffer, dat_auswertung$Vertrauen)
# plot(dat_auswertung$Volltreffer, dat_auswertung$Likeability)
# plot(dat_auswertung$Volltreffer, dat_auswertung$Kompetenz)
# plot(dat_auswertung$Volltreffer, dat_auswertung$Sicherheit)

ggscatter(
  dat_auswertung,
  x = "Volltreffer",
  y = "Misstrauen",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Volltreffer",
  ylab = "Misstrauen"
)

ggscatter(
  dat_auswertung,
  x = "Volltreffer",
  y = "Vertrauen",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Volltreffer",
  ylab = "Vertrauen"
)

ggscatter(
  dat_auswertung,
  x = "Volltreffer",
  y = "Likeability",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Volltreffer",
  ylab = "Likeability"
)

ggscatter(
  dat_auswertung,
  x = "Volltreffer",
  y = "Kompetenz",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Volltreffer",
  ylab = "Kompetenz"
)

ggscatter(
  dat_auswertung,
  x = "Volltreffer",
  y = "Sicherheit",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Volltreffer",
  ylab = "Sicherheit"
)

## Plusminus1 --------------------------

# cor.test(dat_auswertung$Plusminus1, dat_auswertung$Misstrauen)
# cor.test(dat_auswertung$Plusminus1, dat_auswertung$Vertrauen)
# cor.test(dat_auswertung$Plusminus1, dat_auswertung$Likeability)
# cor.test(dat_auswertung$Plusminus1, dat_auswertung$Kompetenz)
# cor.test(dat_auswertung$Plusminus1, dat_auswertung$Sicherheit)

cor.test(dat_auswertung$Plusminus1, dat_auswertung$Misstrauen)
cor.test(dat_auswertung$Plusminus1, dat_auswertung$Vertrauen)
cor.test(dat_auswertung$Plusminus1, dat_auswertung$Likeability)
cor.test(dat_auswertung$Plusminus1, dat_auswertung$Kompetenz)
cor.test(dat_auswertung$Plusminus1, dat_auswertung$Sicherheit)

ggscatter(
  dat_auswertung,
  x = "Plusminus1",
  y = "Misstrauen",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Plusminus1",
  ylab = "Misstrauen"
)

ggscatter(
  dat_auswertung,
  x = "Plusminus1",
  y = "Vertrauen",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Plusminus1",
  ylab = "Vertrauen"
)

ggscatter(
  dat_auswertung,
  x = "Plusminus1",
  y = "Likeability",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Plusminus1",
  ylab = "Likeability"
)

ggscatter(
  dat_auswertung,
  x = "Plusminus1",
  y = "Kompetenz",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Plusminus1",
  ylab = "Kompetenz"
)

ggscatter(
  dat_auswertung,
  x = "Plusminus1",
  y = "Sicherheit",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Plusminus1",
  ylab = "Sicherheit"
)

## Plusminus2 --------------------------

cor.test(dat_auswertung$Plusminus2, dat_auswertung$Misstrauen)
cor.test(dat_auswertung$Plusminus2, dat_auswertung$Vertrauen)
cor.test(dat_auswertung$Plusminus2, dat_auswertung$Likeability)
cor.test(dat_auswertung$Plusminus2, dat_auswertung$Kompetenz)
cor.test(dat_auswertung$Plusminus2, dat_auswertung$Sicherheit)

ggscatter(
  dat_auswertung,
  x = "Plusminus2",
  y = "Misstrauen",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Plusminus2",
  ylab = "Misstrauen"
)

ggscatter(
  dat_auswertung,
  x = "Plusminus2",
  y = "Vertrauen",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Plusminus2",
  ylab = "Vertrauen"
)

ggscatter(
  dat_auswertung,
  x = "Plusminus2",
  y = "Likeability",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Plusminus2",
  ylab = "Likeability"
)

ggscatter(
  dat_auswertung,
  x = "Plusminus2",
  y = "Kompetenz",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Plusminus2",
  ylab = "Kompetenz"
)

ggscatter(
  dat_auswertung,
  x = "Plusminus2",
  y = "Sicherheit",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Plusminus2",
  ylab = "Sicherheit"
)

# Mittlere Abweichung -------------------------------
cor.test(dat_auswertung$Mittlere_Abweichung, dat_auswertung$Misstrauen)
cor.test(dat_auswertung$Mittlere_Abweichung, dat_auswertung$Vertrauen)
cor.test(dat_auswertung$Mittlere_Abweichung, dat_auswertung$Likeability)
cor.test(dat_auswertung$Mittlere_Abweichung, dat_auswertung$Kompetenz)
cor.test(dat_auswertung$Mittlere_Abweichung, dat_auswertung$Sicherheit)

# Qualität ------------------------------------------
cor.test(dat_auswertung$Pragmatische_Qualität, dat_auswertung$Misstrauen)
cor.test(dat_auswertung$Pragmatische_Qualität, dat_auswertung$Vertrauen)
cor.test(dat_auswertung$Pragmatische_Qualität, dat_auswertung$Likeability)
cor.test(dat_auswertung$Pragmatische_Qualität, dat_auswertung$Kompetenz)
cor.test(dat_auswertung$Pragmatische_Qualität, dat_auswertung$Sicherheit)
cor.test(dat_auswertung$Pragmatische_Qualität, dat_auswertung$Volltreffer)
cor.test(dat_auswertung$Pragmatische_Qualität, dat_auswertung$Plusminus1)
cor.test(dat_auswertung$Pragmatische_Qualität, dat_auswertung$Plusminus2)
cor.test(dat_auswertung$Pragmatische_Qualität, dat_auswertung$Mittlere_Abweichung)

cor.test(dat_auswertung$Hedonische_Qualität, dat_auswertung$Misstrauen)
cor.test(dat_auswertung$Hedonische_Qualität, dat_auswertung$Vertrauen)
cor.test(dat_auswertung$Hedonische_Qualität, dat_auswertung$Likeability)
cor.test(dat_auswertung$Hedonische_Qualität, dat_auswertung$Kompetenz)
cor.test(dat_auswertung$Hedonische_Qualität, dat_auswertung$Sicherheit)
cor.test(dat_auswertung$Hedonische_Qualität, dat_auswertung$Volltreffer)
cor.test(dat_auswertung$Hedonische_Qualität, dat_auswertung$Plusminus1)
cor.test(dat_auswertung$Hedonische_Qualität, dat_auswertung$Plusminus2)
cor.test(dat_auswertung$Hedonische_Qualität, dat_auswertung$Mittlere_Abweichung)

cor.test(dat_auswertung$Allg_Qualität, dat_auswertung$Misstrauen)
cor.test(dat_auswertung$Allg_Qualität, dat_auswertung$Vertrauen)
cor.test(dat_auswertung$Allg_Qualität, dat_auswertung$Likeability)
cor.test(dat_auswertung$Allg_Qualität, dat_auswertung$Kompetenz)
cor.test(dat_auswertung$Allg_Qualität, dat_auswertung$Sicherheit)
cor.test(dat_auswertung$Allg_Qualität, dat_auswertung$Volltreffer)
cor.test(dat_auswertung$Allg_Qualität, dat_auswertung$Plusminus1)
cor.test(dat_auswertung$Allg_Qualität, dat_auswertung$Plusminus2)
cor.test(dat_auswertung$Allg_Qualität, dat_auswertung$Mittlere_Abweichung)

cor.test(dat_auswertung$Abweichung_Extraversion, dat_auswertung$Misstrauen)
cor.test(dat_auswertung$Abweichung_Extraversion, dat_auswertung$Vertrauen)
cor.test(dat_auswertung$Abweichung_Extraversion, dat_auswertung$Likeability)
cor.test(dat_auswertung$Abweichung_Extraversion, dat_auswertung$Kompetenz)
cor.test(dat_auswertung$Abweichung_Extraversion, dat_auswertung$Sicherheit)
cor.test(dat_auswertung$Abweichung_Extraversion, dat_auswertung$Volltreffer)
cor.test(dat_auswertung$Abweichung_Extraversion, dat_auswertung$Plusminus1)
cor.test(dat_auswertung$Abweichung_Extraversion, dat_auswertung$Plusminus2)
cor.test(dat_auswertung$Abweichung_Extraversion, dat_auswertung$Mittlere_Abweichung)

cor.test(dat_auswertung$Abweichung_Conciousness, dat_auswertung$Misstrauen)
cor.test(dat_auswertung$Abweichung_Conciousness, dat_auswertung$Vertrauen)
cor.test(dat_auswertung$Abweichung_Conciousness, dat_auswertung$Likeability)
cor.test(dat_auswertung$Abweichung_Conciousness, dat_auswertung$Kompetenz)
cor.test(dat_auswertung$Abweichung_Conciousness, dat_auswertung$Sicherheit)
cor.test(dat_auswertung$Abweichung_Conciousness, dat_auswertung$Volltreffer)
cor.test(dat_auswertung$Abweichung_Conciousness, dat_auswertung$Plusminus1)
cor.test(dat_auswertung$Abweichung_Conciousness, dat_auswertung$Plusminus2)
cor.test(dat_auswertung$Abweichung_Conciousness, dat_auswertung$Mittlere_Abweichung)

cor.test(dat_auswertung$Abweichung_Agreeableness, dat_auswertung$Misstrauen)
cor.test(dat_auswertung$Abweichung_Agreeableness, dat_auswertung$Vertrauen)
cor.test(dat_auswertung$Abweichung_Agreeableness, dat_auswertung$Likeability)
cor.test(dat_auswertung$Abweichung_Agreeableness, dat_auswertung$Kompetenz)
cor.test(dat_auswertung$Abweichung_Agreeableness, dat_auswertung$Sicherheit)
cor.test(dat_auswertung$Abweichung_Agreeableness, dat_auswertung$Volltreffer)
cor.test(dat_auswertung$Abweichung_Agreeableness, dat_auswertung$Plusminus1)
cor.test(dat_auswertung$Abweichung_Agreeableness, dat_auswertung$Plusminus2)
cor.test(dat_auswertung$Abweichung_Agreeableness, dat_auswertung$Mittlere_Abweichung)

cor.test(dat_auswertung$Abweichung_Openness, dat_auswertung$Misstrauen)
cor.test(dat_auswertung$Abweichung_Openness, dat_auswertung$Vertrauen)
cor.test(dat_auswertung$Abweichung_Openness, dat_auswertung$Likeability)
cor.test(dat_auswertung$Abweichung_Openness, dat_auswertung$Kompetenz)
cor.test(dat_auswertung$Abweichung_Openness, dat_auswertung$Sicherheit)
cor.test(dat_auswertung$Abweichung_Openness, dat_auswertung$Volltreffer)
cor.test(dat_auswertung$Abweichung_Openness, dat_auswertung$Plusminus1)
cor.test(dat_auswertung$Abweichung_Openness, dat_auswertung$Plusminus2)
cor.test(dat_auswertung$Abweichung_Openness, dat_auswertung$Mittlere_Abweichung)


cor.test(dat_auswertung$Abweichung_Extraversion,
         dat_auswertung$Misstrauen)
cor.test(dat_auswertung$Abweichung_Extraversion,
         dat_auswertung$Vertrauen)
cor.test(dat_auswertung$Abweichung_Extraversion,
         dat_auswertung$Likeability)
cor.test(dat_auswertung$Abweichung_Extraversion,
         dat_auswertung$Kompetenz)
cor.test(dat_auswertung$Abweichung_Extraversion,
         dat_auswertung$Sicherheit)

ggscatter(
  dat_auswertung,
  x = "Abweichung_Extraversion",
  y = "Misstrauen",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Abweichung_Extraversion",
  ylab = "Misstrauen"
)

ggscatter(
  dat_auswertung,
  x = "Abweichung_Extraversion",
  y = "Vertrauen",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Abweichung_Extraversion",
  ylab = "Vertrauen"
)

ggscatter(
  dat_auswertung,
  x = "Abweichung_Extraversion",
  y = "Likeability",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Abweichung_Extraversion",
  ylab = "Likeability"
)

ggscatter(
  dat_auswertung,
  x = "Abweichung_Extraversion",
  y = "Kompetenz",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Abweichung_Extraversion",
  ylab = "Kompetenz"
)

ggscatter(
  dat_auswertung,
  x = "Abweichung_Extraversion",
  y = "Sicherheit",
  add = "reg.line",
  conf.int = TRUE,
  cor.coef = TRUE,
  cor.method = "pearson",
  xlab = "Abweichung_Extraversion",
  ylab = "Sicherheit"
)


cor(dat_auswertung[c(
  "Misstrauen",
  "Vertrauen",
  "Likeability",
  "Kompetenz",
  "Sicherheit",
  "Volltreffer",
  "Plusminus1",
  "Plusminus2",
  "Mittlere_Abweichung"
)]) %>% round(2)

cor(dat_auswertung[c(
  "Misstrauen",
  "Vertrauen",
  "Likeability",
  "Kompetenz",
  "Sicherheit",
  "Mittlere_Abweichung",
  "Abweichung_Extraversion",
  "Abweichung_Agreeableness",
  "Abweichung_Openness",
  "Abweichung_Conciousness"
)]) %>% round(2)

cor(dat_auswertung[c(
  "Pragmatische_Qualität",
  "Hedonische_Qualität",
  "Volltreffer",
  "Plusminus1",
  "Plusminus2",
  "Mittlere_Abweichung"
)]) %>% round(2)

cor(dat_auswertung[c(
  "Pragmatische_Qualität",
  "Hedonische_Qualität",
  "Mittlere_Abweichung",
  "Abweichung_Extraversion",
  "Abweichung_Agreeableness",
  "Abweichung_Openness",
  "Abweichung_Conciousness"
)]) %>% round(2)

ggpairs(
  dat_auswertung[c(
    "Pragmatische_Qualität",
    "Hedonische_Qualität",
    "Allg_Qualität",
    "Volltreffer",
    "Plusminus1",
    "Plusminus2",
    "Mittlere_Abweichung"
  )],
  columnLabels = c( "Pragmatische Qualität",
                    "Hedonische Qualität",
                    "Qualität insgesamt",
                    "Volltreffer",
                    "Abweichung ±1",
                    "Abweichung ±2",
                    "Mittlere Abweichung"),
  upper = list(continuous = wrap("cor", size = 5)),
  lower = list(continuous = wrap("smooth", colour="grey")),
)

ggpairs(
  dat_auswertung[c(
    "Misstrauen",
    "Vertrauen",
    "Likeability",
    "Kompetenz",
    "Sicherheit",
    "Volltreffer",
    "Plusminus1",
    "Plusminus2",
    "Mittlere_Abweichung"
  )],
  columnLabels = c("Misstrauen",
                   "Vertrauen",
                   "Likeability",
                   "Kompetenz",
                   "Sicherheit",
                   "Volltreffer",
                   "Abweichung ±1",
                   "Abweichung ±2",
                   "Mittlere Abweichung"),
  upper = list(continuous = wrap("cor", size = 5)),
  lower = list(continuous = wrap("smooth", colour="grey")),
)

ggpairs(
  dat_auswertung[c(
    "Pragmatische_Qualität",
    "Hedonische_Qualität",
    "Allg_Qualität",
    "Mittlere_Abweichung",
    "Abweichung_Extraversion",
    "Abweichung_Agreeableness",
    "Abweichung_Openness",
    "Abweichung_Conciousness"
  )],
  columnLabels = c( "Pragmatische Qualität",
                    "Hedonische Qualität",
                    "Qualität insgesamt",
                    "Mittlere Abweichung",
                    "Extraversion",
                    "Verträglichkeit",
                    "Offenheit",
                    "Gewissenhaftigkeit"),
  upper = list(continuous = wrap("cor", size = 5)),
  lower = list(continuous = wrap("smooth", colour="grey")),
)

ggpairs(
  dat_auswertung[c(
    "Misstrauen",
    "Vertrauen",
    "Likeability",
    "Kompetenz",
    "Sicherheit",
    #  "Mittlere_Abweichung",
    "Abweichung_Extraversion",
    "Abweichung_Agreeableness",
    "Abweichung_Openness",
    "Abweichung_Conciousness"
  )],
  columnLabels = c("Misstrauen",
                   "Vertrauen",
                   "Likeability",
                   "Kompetenz",
                   "Sicherheit",
                   #     "Mittlere Abweichung",
                   "Extraversion",
                   "Verträglichkeit",
                   "Offenheit",
                   "Gewissenhaftigkeit"),
  upper = list(continuous = wrap("cor", size = 5)),
  lower = list(continuous = wrap("smooth", colour="grey"))
)

summary(dat_auswertung$Fun)
summary(dat_auswertung$Likeability)
summary(dat_auswertung$Kompetenz)
summary(dat_auswertung$Sicherheit)
summary(dat_auswertung$Vertrauen)
summary(dat_auswertung$Misstrauen)
summary(dat_auswertung$Plusminus1)
summary(dat_auswertung$Plusminus2)
summary(dat_auswertung$Abweichung1)
summary(dat_auswertung$Abweichung2)
summary(dat_auswertung$Abweichung3)
summary(dat_auswertung$Abweichung4)
summary(dat_auswertung$Abweichung5)
summary(dat_auswertung$Abweichung6)


table(dat_auswertung$Fun)
table(dat_auswertung$Likeability)
table(dat_auswertung$Kompetenz)
table(dat_auswertung$Sicherheit)
table(dat_auswertung$Vertrauen)
table(dat_auswertung$Misstrauen)
table(dat_auswertung$Plusminus1)
table(dat_auswertung$Plusminus2)
table(dat_auswertung$Abweichung1)
table(dat_auswertung$Abweichung2)
table(dat_auswertung$Abweichung3)
table(dat_auswertung$Abweichung4)
table(dat_auswertung$Abweichung5)
table(dat_auswertung$Abweichung6)

summary(dat_auswertung$SD_Gender)
table(dat_auswertung$SD_Gender)
sd(dat_auswertung$SD_Gender, na.rm=TRUE)
summary(dat_auswertung$SD_Age)
table(dat_auswertung$SD_Age)
sd(dat_auswertung$SD_Age, na.rm=TRUE)
table(dat_auswertung$Fun)
sd(dat_auswertung$Fun, na.rm=TRUE)
summary(dat_auswertung$Fun)



write.csv(
  dat_auswertung,
  "/Users/tessalottermann/Documents/Dokumente/Thesis/dat_auswertung_0205_av.csv"
)
