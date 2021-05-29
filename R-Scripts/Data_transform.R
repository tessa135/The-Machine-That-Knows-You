library(dplyr)

dat_auswertung <-
  read_csv("/Your/Path/Goes/here/Answers.csv",
           na = "NULL")

dat_auswertung <- select (dat_auswertung,-c(VPCode,VPCode_2))


#Check if all necessary fields are filled ------------------------------------

dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$TFPred1),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$TFPred2),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$TFPred3),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$TFPred4),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$TFPred5),]
dat_auswertung <- 
  dat_auswertung[!is.na(dat_auswertung$TFPred6),]

dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$GQS_3_1),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$GQS_3_2),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$GQS_3_3),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$GQS_3_4),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$GQS_3_5),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$GQS_4_1),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$GQS_4_2),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$GQS_4_3),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$GQS_4_4),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$GQS_4_5),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$GQS_5_1),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$GQS_5_2),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$GQS_5_3),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$KIT_1),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$KIT_2),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$KIT_3),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$KIT_4),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$KIT_5),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$KIT_6),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$KIT_7),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$KIT_8),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$KIT_9),]
dat_auswertung <-
  dat_auswertung[!is.na(dat_auswertung$KIT_10),]

dat_auswertung$SD_Age[dat_auswertung$SD_Age == 0] <- NA

#write into Matrix to use RowVars and write Variances into data.frame ----------------------------------------------
#to check for fake subjects (BIG-V and final questionnaire)

auswertung_matrix <-
  data.matrix(dat_auswertung, rownames.force = NA)

#var_bfi <- rowVars(auswertung_matrix[, c(4:54)], na.rm = TRUE)
#var_abschlussfragen <-
#  rowVars(auswertung_matrix[, c(70:102)], na.rm = TRUE)
var_all <- rowVars(auswertung_matrix[, c(4:54, 70:102)], na.rm = TRUE)

dat_auswertung <- cbind(dat_auswertung, var_all)

#drop all Subjects with Variance < 0.5

dat_auswertung <- dat_auswertung[dat_auswertung$var_all > 0.5,]


#Write correct Predictions to target variable ---------------------------------------

dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate(E7 = ifelse(TFPred1 == 1, Prediction1, E7))
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate(O2 = ifelse(TFPred2 == 1, Prediction2, O2))
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate(A6 = ifelse(TFPred3 == 1, Prediction3, A6))
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate(A4 = ifelse(TFPred4 == 1, Prediction4, A4))
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate(C8 = ifelse(TFPred5 == 1, Prediction5, C8))
dat_auswertung <-
  dat_auswertung %>% rowwise() %>% mutate(E3 = ifelse(TFPred6 == 1, Prediction6, E3))

#Write data.frame to csv ------------------------------
write.csv(
  dat_auswertung,
  "/Your/Path/Goes/here/clean_data.csv"
)
