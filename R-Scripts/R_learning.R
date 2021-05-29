#install.packages("plyr")
#install.packages("e1071")
#install.packages("styler")
#install.packages("R.oo")
#install.packages("foreach")
#install.packages("doParallel")
#install.packages("caret")
#install.packages("mlbench")
#install.packages("h2o")
#install.packages("labelled")
#install.packages("randomForest")
#install.packages('doSNOW')
#install.packages("rminer")
#install.packages("RMySQL")
#install.packages("shiny")
#install.packages("~/Downloads/crayon_1.4.0.tar", repos = NULL, type="source")
#install.packages("iterpc")

#library(foreach)
#library(doParallel)
#library(parallel)
#library(plyr)
library(dplyr)
library(tidyverse)
#library(caret)
#library(mlbench)
library(e1071)
#library(h2o)
#library(labelled)
#library(randomForest)
#library(doSNOW)
#library(rminer)
#library(dbplyr)
#library(pool)
#library(DBI)
#library(RMySQL)
library(iterpc)


# Datensatz laden ---------------------------------

dat <-
  haven::read_sav("/Your/Path/Goes/here/data.sav") %>%
  select(cp20l020:cp20l069) %>%
  rename(
    E1 = "cp20l020",
    A1 = "cp20l021",
    C1 = "cp20l022",
    N1 = "cp20l023",
    O1 = "cp20l024",
    E2 = "cp20l025",
    A2 = "cp20l026",
    C2 = "cp20l027",
    N2 = "cp20l028",
    O2 = "cp20l029",
    E3 = "cp20l030",
    A3 = "cp20l031",
    C3 = "cp20l032",
    N3 = "cp20l033",
    O3 = "cp20l034",
    E4 = "cp20l035",
    A4 = "cp20l036",
    C4 = "cp20l037",
    N4 = "cp20l038",
    O4 = "cp20l039",
    E5 = "cp20l040",
    A5 = "cp20l041",
    C5 = "cp20l042",
    N5 = "cp20l043",
    O5 = "cp20l044",
    E6 = "cp20l045",
    A6 = "cp20l046",
    C6 = "cp20l047",
    N6 = "cp20l048",
    O6 = "cp20l049",
    E7 = "cp20l050",
    A7 = "cp20l051",
    C7 = "cp20l052",
    N7 = "cp20l053",
    O7 = "cp20l054",
    E8 = "cp20l055",
    A8 = "cp20l056",
    C8 = "cp20l057",
    N8 = "cp20l058",
    O8 = "cp20l059",
    E9 = "cp20l060",
    A9 = "cp20l061",
    C9 = "cp20l062",
    N9 = "cp20l063",
    O9 = "cp20l064",
    E10 = "cp20l065",
    A10 = "cp20l066",
    C10 = "cp20l067",
    N10 = "cp20l068",
    O10 = "cp20l069"
  ) %>% drop_na()

#%>% # Items den Skalen zuordnen
# mutate_all(scale) %>%  # mittelwert auf 0, sd auf 1
 # zeilen mit fehlenden werten entfernen

getOption("max.print")
options(max.print = 99999999)

# Histogramme über die Verteilungen der Items im Datensatz generieren -----------------------------
vardists <- dat %>%
  map(table)

plot(vardists[[1]],)

hist(vardists[1][2])

cols <- colnames(dat)
cols[[1]]



for (i in 1:length(vardists)) {
  png(paste0(
    "/Your/Path/Goes/here/plot_",
    i,
    ".png"
  ))
  
  plot(vardists[[i]], ylab = cols[[i]], ylim = c(0, 3500))
  
  dev.off()
}


# Alte Modelltabellen bei Bedarf laden -------------------

#resdf_sav <-
#  read_csv("/Users/tessalottermann/Documents/Thesis/results_right_percent.csv")


# Generate Model ----------------------------------------------------
# Generates one Formula depending on the Target-Variable
# specific_target (String) -> Target-variable
# target_incl (Bool) -> Is target-scale part of prediction set
# item_per_scale (int) -> How many items per scale in prediction set
# target_overweight (int) -> If target_incl true - factor of target_scale overweight in prediction set
#

generate_model <-
  function(specific_target,
           target_overweight,
           target_incl,
           item_per_scale) {
    target_facet <- substring(specific_target, 1, 1)
    
    if (target_overweight * item_per_scale > 9 &&
        target_incl == TRUE) {
      stop(
        "Es dürfen maximal 9 Items aus der Target-Skala verwendet werden! (Overweight oder Item_per_Scale zu hoch)"
      )
    }
    
    if (item_per_scale >= 10) {
      stop("Maximal 9 Items als Prädiktoren!")
    }
    
    all_f <- c("O", "C", "E", "A", "N")
    if (!target_incl) {
      notall_f <- all_f[all_f != target_facet]
      
      predictors <- str_sort(rep(notall_f, times = item_per_scale))
    } else {
      all_f
      predictors_plain <-
        rep(all_f, times = item_per_scale) # Predictors ohne Overweight
      overweight <-
        c(rep(target_facet, times = ((target_overweight * item_per_scale) - item_per_scale
        ))) # Array mit dem Overweight als Faktor
      predictors <-
        str_sort(c(predictors_plain, overweight)) # Finales Array inkl Overweight
    }
    
    final_predictors <- c()
    
    for (i in predictors) {
      rand <- sample(1:10, 1)
      new_val <- paste(i, rand, sep = "")
      while (new_val %in% final_predictors) {
        rand <- sample(1:10, 1)
        new_val <- paste(i, rand, sep = "")
      }
      # if (new_val %in% final_predictors) {
      #
      # }
      while (new_val == specific_target) {
        rand <- sample(1:10, 1)
        new_val <- paste(i, rand, sep = "")
      }
      # if (new_val == specific_target) {
      #
      # }
      final_predictors <- append(final_predictors, new_val)
    }
    
    form <-
      paste0(specific_target,
             " ~ ",
             paste0(final_predictors, collapse = " + "))
    
    return(form)
  }

# Permutationen generieren --------------------------------
# Generates set of different prediction-set-combinations
# specific_target (String) -> Target-variable
# target_incl (Bool) -> Is target-scale part of prediction set
# item_per_scale (int) -> How many items per scale in prediction set
# target_overweight (int) -> If target_incl true - factor of target_scale overweight in prediction set
#

generate_perms <- function(st, to, ti, ips) {
  perms <- list()
  while (length(perms) < 5) {
    g <- generate_model(st, to, ti, ips)
    if (!(g %in% perms)) {
      perms <- append(perms, g)
    }
  }
  return(perms)
}

# Generierung der Modelle ---------------------------------
# Schalter Target_inkl.
# 1. For-Schleife: specific variable
#   2. For-Schleife: item_per_scale
#       3. For-Schleife: target_overweight

target_overweight <- 0
targets <- c()
all_comb <- list()
allperms <- list()
all_scales <- c("O", "C", "E", "A", "N")

for (i in all_scales) {
  nums <- seq(1, 10)
  target <- paste(i, nums, sep = "")
  targets <- append(targets, target)
}

# for (i in targets) {
#   specific_target <- i
#   for (j in 1:9) {
#     item_p_s <- j
#     while (item_p_s * target_overweight < 10) {
#       target_overweight <- target_overweight + 1
#       if ((item_p_s * target_overweight) > 9) {
#         target_overweight <- 1
#       }
#       break
#     }
#     
#     st <- toString(specific_target)
#     perms_wo <-
#       generate_perms(specific_target, target_overweight, T, item_p_s)
#     
#     for (k in perms_wo) {
#       comb <- list(specific_target, target_overweight, T, item_p_s, k)
#       all_comb <- append(all_comb, list(comb))
#     }
#     
#     perms_no <-
#       generate_perms(specific_target, target_overweight, F, item_p_s)
#     
#     for (l in perms_no) {
#       comb <- list(specific_target, target_overweight, F, item_p_s, l)
#       all_comb <- append(all_comb, list(comb))
#     }
#   }
# }

for (i in targets) {
  specific_target <- i
  for (j in 1:9) {
    item_p_s <- j
    for (z in 1:9) {
      target_overweight <- z
      st <- toString(specific_target)
      if ((item_p_s * target_overweight) < 10) {
        perms_wo <-
          generate_perms(specific_target, target_overweight, T, item_p_s)
        
        for (k in perms_wo) {
          comb <- list(specific_target, target_overweight, T, item_p_s, k)
          print(comb)
          all_comb <- append(all_comb, list(comb))
        }
      }
    }
    perms_no <- generate_perms(specific_target, 1, F, item_p_s)
    
    for (l in perms_no) {
      comb <- list(specific_target, 1, F, item_p_s, l)
      print(comb)
      all_comb <- append(all_comb, list(comb))
    }
  }
}

newdf <- do.call(rbind.data.frame, all_comb)

names(newdf)[1] <- "Target_Variable"
names(newdf)[2] <- "Target_Overweight"
names(newdf)[3] <- "Target_Included"
names(newdf)[4] <- "Items_Per_Scale"
names(newdf)[5] <- "Predictions"

setdf <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

# Generierung von Trainings- und Validierungsdatensatz ------------------------------
df <- dat

df$id <- 1:nrow(df)
training <- df %>% dplyr::sample_frac(.75)
validation  <- dplyr::anti_join(df, training, by = 'id')

# test_model <- e1071::svm(as.formula(E2 ~ E1 + A1 + N1 + O1 + C1), data = training, cross = 5)
# saveRDS(test_model, file= "/Users/tessa/Documents/Uni/Master/Thesis/Experience-AI-in-Lab/R/SVM_Models/testmodel.rds")
#
# mdl <- "E2 ~ E1 + A1 + N1 + O1 + C1"
# model_svm <- e1071::svm(as.formula(mdl), data = training, cross = 5)
# summary(model_svm)
#
# mdlsave <- gsub(" ","",mdl)
# print(mdlsave)
# saveRDS(model_svm, file= paste("/Users/tessa/Documents/Uni/Master/Thesis/Experience-AI-in-Lab/R/RDSmodels/svmmodel_",mdlsave,".rds",sep=""))


# Berechnung SVM ----------------------------------------

get_model_results <- function(mdl) {
  # mdl <- "E2 ~ E1 + A1 + N1 + O1 + C1"
  tictoc::tic()
  target <- str_split(mdl, "~")[[1]][1] %>% str_trim()
  
  model_svm <-
    e1071::svm(as.formula(mdl), data = training, cross = 5)
  summary(model_svm)
  
  mdlsave <- gsub(" ", "", mdl)
  
  #write.svm(model_svm, svm.file = paste("/Users/tessa/Documents/Uni/Master/Thesis/Experience-AI-in-Lab/R/SVM_Models/Rdata",mdlsave,".svm"),
  #          scale.file = paste("/Users/tessa/Documents/Uni/Master/Thesis/Experience-AI-in-Lab/R/SVM_Models/Rdata",mdlsave,".scale"), yscale.file = paste("/Users/tessa/Documents/Uni/Master/Thesis/Experience-AI-in-Lab/R/SVM_Models/Rdata",mdlsave,".yscale"))
  
  saveRDS(
    model_svm,
    file = paste(
      "/Your/Path/Goes/here/svmmodel_",
      mdlsave,
      ".rds",
      sep = ""
    )
  )
  
  res_df_trained <- data.frame(truth_trained = validation[[target]],
                               pred_trained = round(predict(model_svm, validation))) %>%
    mutate(diff_trained = truth_trained - pred_trained)
  
  res_df_untrained <- data.frame(truth_untrained = dat[[target]],
                                 pred_untrained = round(predict(model_svm, dat))) %>%
    mutate(diff_untrained = truth_untrained - pred_untrained)
  
  tictoc::toc()
  
  results <- list(
    mse = mean(model_svm$MSE),
    hit_0_trained = sum(res_df_trained$diff_trained == 0) / nrow(validation),
    hit_1_trained = sum(abs(res_df_trained$diff_trained) <= 1) / nrow(validation),
    hit_0_untrained = sum(res_df_untrained$diff_untrained == 0) / nrow(dat),
    hit_1_untrained = sum(abs(res_df_untrained$diff_untrained) <= 1) / nrow(dat)
  )
  
  #print(results)
  
  setdf <- add_row(setdf, mse = results$mse, hit_0_trained = results$hit_0_trained, hit_1_trained = results$hit_1_trained, hit_0_untrained = results$hit_0_untrained, hit_1_untrained = results$hit_1_untrained, Predictions = mdl)
  
  return(results)
}

#get_model_results("O7 ~ A10 + C8 + E6 + E7 + N6 + O8")


#Berechnung Random Forest -------------------------------------


# get_model_results_randomForest <- function(mdl) {
#   # mdl <- "E2 ~ E1 + A1 + N1 + O1 + C1"
#   tictoc::tic()
#   target <- str_split(mdl, "~")[[1]][1] %>% str_trim()
#   
#   model_rf <- randomForest(as.formula(mdl), data = training)
#   summary(model_rf)
#   
#   mdlsave <- trimws(mdl)
#   
#   # write.svm(model_svm, svm.file = paste("/Users/tessa/Documents/Uni/Master/Thesis/Experience-AI-in-Lab/R/SVM_Models/Rdata",mdlsave,".svm"),
#   #          scale.file = paste("/Users/tessa/Documents/Uni/Master/Thesis/Experience-AI-in-Lab/R/SVM_Models/Rdata",mdlsave,".scale"), yscale.file = paste("/Users/tessa/Documents/Uni/Master/Thesis/Experience-AI-in-Lab/R/SVM_Models/Rdata",mdlsave,".yscale"))
#   
#   res_df_trained <- data.frame(truth_trained = validation[[target]],
#                                pred_trained = round(predict(model_rf, validation))) %>%
#     mutate(diff_trained = truth_trained - pred_trained)
#   
#   res_df_untrained <- data.frame(truth_untrained = dat[[target]],
#                                  pred_untrained = round(predict(model_rf, dat))) %>%
#     mutate(diff_untrained = truth_untrained - pred_untrained)
#   
#   tictoc::toc()
#   
#   results <- list(
#     mse = mean(model_rf$MSE),
#     hit_0_trained = sum(res_df_trained$diff_trained == 0) / nrow(validation),
#     hit_1_trained = sum(abs(res_df_trained$diff_trained) <= 1) / nrow(validation),
#     hit_0_untrained = sum(res_df_untrained$diff_untrained == 0) / nrow(dat),
#     hit_1_untrained = sum(abs(res_df_untrained$diff_untrained) <= 1) / nrow(dat)
#   )
#   
#   #print(results)
#   
#   # setdf <- add_row(setdf, mse = results$mse, hit_0_trained = results$hit_0_trained, hit_1_trained = results$hit_1_trained, hit_0_untrained = results$hit_0_untrained, hit_1_untrained = results$hit_1_untrained, Predictions = i)
#   
#   return(results)
# }

# Parallelisierung (NOT WORKING) -------------------------------
#dat2 <- unlabelled(dat)

# h2o.init()
# dat2.hex <- as.h2o(dat2, destination_frame = "dat2.hex")
# dat2.split <- h2o.splitFrame(data = dat2.hex, ratios = 0.75)
# dat2.train <- dat2.split[[1]]
# dat2.val <- dat2.split[[2]]
# #
# h2o.automl(x = c("E1", "A1", "N1", "O1", "C1"),
#            y = "E2",
#            dat2.train,
#            dat2.val)
#
# colnames(dat.hex)


# get_model_results("A10 ~ C7 + E5 + N6 + O7")
#
# cores=detectCores()
# cl <- makeCluster(cores[1]-1) #not to overload your computer
# registerDoParallel(cl)
#
# foreach (newdf$Predictions, .combine=rbind) %dopar% {
#   library(plyr)
#   library(dplyr)
#   library(tidyverse)
#   library(e1071)
#   results <- get_model_results(newdf$Predictions)
#   setdf <- add_row(setdf, mse = results$mse, hit_0_trained = results$hit_0_trained, hit_1_trained = results$hit_1_trained, hit_0_untrained = results$hit_0_untrained, hit_1_untrained = results$hit_1_untrained, Predictions = i)
# }
#
# stopCluster(cl)
# paralleldf <- data.frame()
# finals <- list()
#
# cores <- detectCores()
# cl <- parallel::makeCluster(2, outfile = "")
# doParallel::registerDoParallel(cl)
# registerDoSNOW(cl)
# #finals <- mclapply(olddf, get_model_results(olddf$Predictions), mc.cores = 2)
#
# foreach(olddf$Predictions, .combine = rbind, .inorder = FALSE) %dopar% {
#   library(e1071)
#   library(tidyverse)
#   library(dplyr)
#   paralleldf <-  get_model_results(olddf$Predictions)
#   print(paralleldf)
# }
# stopCluster(cl)

# Modelle SVM Berechnen & speichern -----------------------------------------------

for (i in newdf$Predictions) {
  results <- get_model_results(i)
  setdf <-
    add_row(
      setdf,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

# for (i in newdf$Predictions) {
#   results <- get_model_results_randomForest(i)
#   setdf <-
#     add_row(
#       setdf,
#       mse = results$mse,
#       hit_0_trained = results$hit_0_trained,
#       hit_1_trained = results$hit_1_trained,
#       hit_0_untrained = results$hit_0_untrained,
#       hit_1_untrained = results$hit_1_untrained,
#       Predictions = i
#     )
# }


resdf <- left_join(newdf, setdf, by = "Predictions")

# resdf_rf <- resdf_rf %>% mutate(
#   hit_0_trained = hit_0_trained * 100,
#   hit_0_untrained = hit_0_untrained * 100,
#   hit_1_trained = hit_1_trained * 100,
#   hit_1_untrained = hit_1_untrained * 100,
#   hit_0_diff = (hit_0_untrained - hit_0_trained),
#   hit_1_diff = (hit_1_untrained - hit_1_trained)
# )

#summary(resdf_rf)

# drop.cols <-
#   c(
#     "hit_0_trained * 100",
#     "hit_0_untrained * 100",
#     "hit_1_trained * 100",
#     "hit_1_untrained * 100"
#   )
# resdf <- resdf %>% select(-one_of(drop.cols))

write.csv(
  resdf,
  "/Your/Path/Goes/here/results.csv"
)

descriptives <- summary(resdf_rf)

write.csv(
  descriptives,
  "/Your/Path/Goes/here/descriptives_results.csv"
)


# VERSUCHE ------------------------------------------------
# Ab hier sind nur verschiedene Ansätze zur Lösung diverser Probleme zu finden 

## Best Models ---------------------------------------------
# Der Versuch neue Modelle zu generieren indem man bei den Modellen mit der höchsten Vorhersagegenauigkeit, 
# die Target Variablen austauscht und neue Variablen hinzufügt

resdf_sav <- resdf

best_models <- resdf_sav %>%
  group_by(Target_Variable,
           Items_Per_Scale,
           Target_Overweight,
           Target_Included) %>%
  top_n(1, hit_0_trained)

best_models_preds <-
  best_models %>% mutate(Predictors = str_split(Predictions, "~")[[1]][2] %>% str_trim())

target_variables <- unique(best_models$Target_Variable)
preds_df <- data.frame(Predictions = character())

for (i in best_models_preds$Predictors) {
  new_pred <- sample(target_variables, 2, replace = FALSE)
  while (grepl(new_pred[1], best_models_preds$Target_Variable[i], fixed =
               TRUE) ||
         grepl(new_pred[1], i, fixed = TRUE) ||
         grepl(new_pred[2], i, fixed = TRUE) ||
         grepl(new_pred[1], new_pred[2], fixed = TRUE)) {
    new_pred <- sample(target_variables, 2, replace = TRUE)
  }
  chain_preds <- paste0(new_pred[1], " ~ ", i, " + ", new_pred[2])
  preds_df <- add_row(preds_df, Predictions = chain_preds)
}

setn_df <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in preds_df$Predictions) {
  results <- get_model_results(i)
  setn_df <-
    add_row(
      setn_df,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#while (new_pred[1] %in% best_models_preds$Target_Variable[i] && sapply(new_pred[1], grepl, i) && sapply(new_pred[2], grepl, i)) {

print(preds_df$Predictions[31])

(sapply("E9", grepl, "A6 + A7 + C8 + C7 + E10 + E3 + N3 + N2"))

"E9" %in% "A6 + A7 + C8 + C7 + + E9 + E10 + E3 + N3 + N2"

A4 ~ A7 + A9 + A6 + A8 + A2 + C10 + E4 + N2 + O2

a <- c("A4", "A7", "A9", "A6", "A8", "A2", "C10", "E4", "N2", "O2")

chain3 <- apply(sapply(a, grepl, olddf$Predictions), 1, all)

chain4 <-
  do.call(mapply, c(all, lapply(a, grepl, olddf$Predictions)))

which(unlist(chain3))
which(unlist(chain4))

for (i in olddf$Predictions) {
  b <- all(sapply(a, grepl, i))
  chain <- append(chain, b)
}

print(chain)

chain <- all(sapply(a, grepl, olddf$Predictions))
chain2 <- which(unlist(chain))

print(chain2)

for (i in chain3) {
  d <- append(c, olddf$Predictions[i])
}

print(d)

## Versuch des SVM Tunings ----------------------------------------

tune_out <-
  tune.svm(
    as.formula(olddf$Predictions[25]),
    data = training,
    cross = 5,
    gamma = 10 ^ (-5:-1),
    cost = 10 ^ (-3:1)
  )
summary(tune_out)


rfe_test <-
  rfe(
    training,
    training$O1,
    sizes = c(2, 5, 10, 20),
    rfeControl = rfeControl(functions = caretFuncs, number = 200),
    method = "svmRadial"
  )

fit_test <-
  fit(
    as.formula(O1 ~ .),
    training,
    model = "svm",
    feature = "sabs",
    tast = "default",
    search = "heuristic",
    scale = "none",
    transform = "none"
  )

fit_test <-
  fit(as.formula(O1 ~ .),
      training,
      model = "svm",
      feature = "sbs")
print(fit_test@mpar)
print(fit_test)

sapply(training, class)

corMatrix <- cor(dat)
highlyCorrelated <- findCorrelation(corMatrix, cutoff = 0.5)
print(highlyCorrelated)

ga_ctrl <- gafsControl(functions = rfGA, # Assess fitness with RF
                       method = "cv")

gafs_test <-
  gafs(training,
       training$O1,
       iters = 1,
       gafsControl = ga_ctrl)

testperson <- dat[567,]
as.matrix(testperson)

premodel <-
  readRDS(file = "Your/Path/SVM_Models/Rdata_N10~A2+A1+C9+C3+E5+E9+O7+O3.svm")
as.matrix(premodel)
premodel <-
  readRDS(file = "Your/Path/RDSmodels/svmmodel_E2~E1+A1+N1+O1+C1.rds")
pred_testperson <- predict(premodel, testperson)

testp <- data.frame(c(1, 2, 3, 4, 5, 6))

predict(premodel, testp)

print(pred_testperson)

colnames <- names(dat)
print(colnames)
view(colnames)

## Neue Modelle auf Grundlage alter Modelle generieren ----------------------------------------

nextstep <- c(
  "A1~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "A3~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "A5~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "A10~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "C1~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "C2~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "C3~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "C4~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "C5~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "C6~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "C7~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "C8~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "C9~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "E1~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "E2~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "E3~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "E5~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "E6~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "E7~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "E8~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "E9~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "E10~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "N1~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "N3~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "N4~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "N5~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "N6~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "N7~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "N8~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "N9~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "N10~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "O1~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "O3~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "O4~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "O5~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "O6~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "O7~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "O8~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "O9~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4",
  "O10~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4"
)

grepl("N5", nextstep[1])

nextstepfurtherA10 <- list()

for (i in targets) {
  specific_target <- i
  if (!grepl(specific_target, 'A10~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4')) {
    n <- paste0('A10~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4+', specific_target)
    nextstepfurtherA10 <- append(nextstepfurtherA10, n)
  }
}


#A10~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4+E5

nextstepfurther_A102 <- list()

for (i in targets) {
  specific_target <- i
  if (!grepl(specific_target, '~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4+E5+A10')) {
    n <-
      paste0(specific_target,
             '~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4+E5+A10')
    nextstepfurther_A102 <- append(nextstepfurther_A102, n)
  }
}

#Alternativ: O7~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4

nextstepfurther_O7 <- list()

for (i in targets) {
  specific_target <- i
  if (!grepl(specific_target, '~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4+A10+O7')) {
    n <-
      paste0(specific_target,
             '~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4+A10+O7')
    nextstepfurther_O7 <- append(nextstepfurther_O7, n)
  }
}

#~E6+A3+C10+N1+O9+E2+A8+C6+N3+O2
bfi2bestmodel <- list()

for (i in targets) {
  specific_target <- i
  if (!grepl(specific_target, '~E6+A3+C10+N1+O9+E2+A8+C6+N3+O2')) {
    n <- paste0(specific_target, '~E6+A3+C10+N1+O9+E2+A8+C6+N3+O2')
    bfi2bestmodel <- append(bfi2bestmodel, n)
  }
}


#O7~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4+A10

nextstepfurtherA10 <- list()

for (i in targets) {
  specific_target <- i
  if (!grepl(specific_target, 'A10~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4')) {
    n <- paste0('A10~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4+', specific_target)
    nextstepfurtherA10 <- append(nextstepfurtherA10, n)
  }
}

print(nextstepfurther)

nextdfbfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in bfi2bestmodel) {
  results <- get_model_results(i)
  nextdfbfi2 <-
    add_row(
      nextdfbfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

saveRDS(nextdfbfi2,
        file = "Your/Path/bfi2results_mitC6.rds")

write.csv(
  nextdfbfi2,
  "Your/Path/bfi2results_mitC6.csv"
)

premodel2 <-
  readRDS(file = "Your/Path/RDSmodels/svmmodel_A10~A7+A9+A6+A8+A2+C10+E4+N2+O2+A4+E5.rds")

## BFI10 ---------------------------------------------------------------
### BFI10 Items Kombinationen generieren --------------------------------

bfi2 <- c("E6", "E2", "A3", "A8", "C10", "C6", "N1", "N3", "O9", "O2")

iter1 <- list()
iter2 <- list()
iter3 <- list()
iter4 <- list()
iter5 <- list()
iter6 <- list()
iter7 <- list()
iter8 <- list()
iter9 <- list()

iter <- iterpc(10, 2, labels = bfi2, ordered = FALSE)
iter1 <- getall(iter)
iter <- iterpc(10, 3, labels = bfi2, ordered = FALSE)
iter2 <- getall(iter)
iter <- iterpc(10, 4, labels = bfi2, ordered = FALSE)
iter3 <- getall(iter)
iter <- iterpc(10, 5, labels = bfi2, ordered = FALSE)
iter4 <- getall(iter)
iter <- iterpc(10, 6, labels = bfi2, ordered = FALSE)
iter5 <- getall(iter)
iter <- iterpc(10, 10, labels = bfi2, ordered = FALSE)
iter6 <- getall(iter)
iter <- iterpc(10, 8, labels = bfi2, ordered = FALSE)
iter7 <- getall(iter)
iter <- iterpc(10, 9, labels = bfi2, ordered = FALSE)
iter8 <- getall(iter)
iter <- iterpc(10, 10, labels = bfi2, ordered = FALSE)
iter9 <- getall(iter)

iter1 <- as_tibble(iter1)
cols <- c('V1', 'V2')
iter1$models <- apply(iter1[, cols] , 1 , paste, collapse = "+")
#iter1$models <- sub("\\+",'~',iter1$models)

iter2 <- as_tibble(iter2)
cols <- c('V1', 'V2', 'V3')
iter2$models <- apply(iter2[, cols] , 1 , paste, collapse = "+")
#iter2$models <- sub("\\+",'~',iter2$models)

iter3 <- as_tibble(iter3)
cols <- c('V1', 'V2', 'V3', 'V4')
iter3$models <- apply(iter3[, cols] , 1 , paste, collapse = "+")
#iter3$models <- sub("\\+",'~',iter3$models)

iter4 <- as_tibble(iter4)
cols <- c('V1', 'V2', 'V3', 'V4', 'V5')
iter4$models <- apply(iter4[, cols] , 1 , paste, collapse = "+")
#iter4$models <- sub("\\+","~",iter4$models)

iter5 <- as_tibble(iter5)
cols <- c('V1', 'V2', 'V3', 'V4', 'V5', 'V6')
iter5$models <- apply(iter5[, cols] , 1 , paste, collapse = "+")
#iter5$models <- sub("\\+",'~',iter5$models)

iter6 <- as_tibble(iter6)
cols <- c('V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7')
iter6$models <- apply(iter6[, cols] , 1 , paste, collapse = "+")
#iter6$models <- sub("\\+",'~',iter6$models)

iter7 <- as_tibble(iter7)
cols <- c('V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8')
iter7$models <- apply(iter7[, cols] , 1 , paste, collapse = "+")
#iter7$models <- sub("\\+",'~',iter7$models)

iter8 <- as_tibble(iter8)
cols <- c('V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9')
iter8$models <- apply(iter8[, cols] , 1 , paste, collapse = "+")
#iter8$models <- sub("\\+",'~',iter8$models)

iter9 <- as_tibble(iter9)
cols <- c('V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9', 'V10')
iter9$models <- apply(iter9[, cols] , 1 , paste, collapse = "+")
#iter9$models <- sub("\\+",'~',iter9$models)


### BFI10 Modelle mit anderen Targets generieren  -------------------------------

iter1bfi10 <- list()

for (i in targets) {
  specific_target <- i
  for (j in iter1$models)
    if (!grepl(specific_target, j)) {
      n <- paste0(specific_target, "~", j)
      iter1bfi10 <- append(iter1bfi10, n)
    }
}

iter2bfi10 <- list()

for (i in targets) {
  specific_target <- i
  for (j in iter2$models)
    if (!grepl(specific_target, j)) {
      n <- paste0(specific_target, "~", j)
      iter2bfi10 <- append(iter2bfi10, n)
    }
}

iter3bfi10 <- list()

for (i in targets) {
  specific_target <- i
  for (j in iter3$models)
    if (!grepl(specific_target, j)) {
      n <- paste0(specific_target, "~", j)
      iter3bfi10 <- append(iter3bfi10, n)
    }
}

iter4bfi10 <- list()

for (i in targets) {
  specific_target <- i
  for (j in iter4$models)
    if (!grepl(specific_target, j)) {
      n <- paste0(specific_target, "~", j)
      iter4bfi10 <- append(iter4bfi10, n)
    }
}

iter5bfi10 <- list()

for (i in targets) {
  specific_target <- i
  for (j in iter5$models)
    if (!grepl(specific_target, j)) {
      n <- paste0(specific_target, "~", j)
      iter5bfi10 <- append(iter5bfi10, n)
    }
}

#_____________________________________________________
iter1othertargets <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter1bfi10) {
  results <- get_model_results(i)
  iter1othertargets <-
    add_row(
      iter1othertargets,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_________________________________________________________
iter2othertargets <-
  list()

iter2othertargets <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter2bfi10) {
  results <- get_model_results(i)
  iter2othertargets <-
    add_row(
      iter2othertargets,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_________________________________________________________
iter3othertargets <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter3bfi10) {
  results <- get_model_results(i)
  iter3othertargets <-
    add_row(
      iter3othertargets,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_________________________________________________________
iter4othertargets <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter4bfi10) {
  results <- get_model_results(i)
  iter4othertargets <-
    add_row(
      iter4othertargets,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_____________________________________________________
iter5othertargets <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter5bfi10) {
  results <- get_model_results(i)
  iter5othertargets <-
    add_row(
      iter5othertargets,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_____________________________________________________
iter3bfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter3$models) {
  results <- get_model_results(i)
  iter3bfi2 <-
    add_row(
      iter3bfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_____________________________________________________
iter4bfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter4$models) {
  results <- get_model_results(i)
  iter4bfi2 <-
    add_row(
      iter4bfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_____________________________________________________
iter5bfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter5$models) {
  results <- get_model_results(i)
  iter5bfi2 <-
    add_row(
      iter5bfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}


#_____________________________________________________
iter6bfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter6$models) {
  results <- get_model_results(i)
  iter6bfi2 <-
    add_row(
      iter6bfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_____________________________________________________
iter7bfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter7$models) {
  results <- get_model_results(i)
  iter7bfi2 <-
    add_row(
      iter7bfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_____________________________________________________
iter8bfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter8$models) {
  results <- get_model_results(i)
  iter8bfi2 <-
    add_row(
      iter8bfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_____________________________________________________
iter9bfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter9$models) {
  results <- get_model_results(i)
  iter9bfi2 <-
    add_row(
      iter9bfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_____________________________________________________
iter4bfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter4$models) {
  results <- get_model_results(i)
  iter4bfi2 <-
    add_row(
      iter4bfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_____________________________________________________
iter5bfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter5$models) {
  results <- get_model_results(i)
  iter5bfi2 <-
    add_row(
      iter5bfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}


#_____________________________________________________
iter6bfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter6$models) {
  results <- get_model_results(i)
  iter6bfi2 <-
    add_row(
      iter6bfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_____________________________________________________
iter7bfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter7$models) {
  results <- get_model_results(i)
  iter7bfi2 <-
    add_row(
      iter7bfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_____________________________________________________
iter8bfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter8$models) {
  results <- get_model_results(i)
  iter8bfi2 <-
    add_row(
      iter8bfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

#_____________________________________________________
iter9bfi2 <-
  data.frame(
    mse = double(),
    hit_0_trained = double(),
    hit_1_trained = double(),
    hit_0_untrained = double(),
    hit_1_untrained = double(),
    Predictions = character()
  )

for (i in iter9$models) {
  results <- get_model_results(i)
  iter9bfi2 <-
    add_row(
      iter9bfi2,
      mse = results$mse,
      hit_0_trained = results$hit_0_trained,
      hit_1_trained = results$hit_1_trained,
      hit_0_untrained = results$hit_0_untrained,
      hit_1_untrained = results$hit_1_untrained,
      Predictions = i
    )
}

iterresultsbfi2 <-
  rbind(iter1bfi2,
        iter2bfi2,
        iter3bfi2,
        iter4bfi2,
        iter5bfi2,
        iter6bfi2)

iter_all_othertargets <-
  rbind(
    iter1othertargets,
    iter2othertargets,
    iter3othertargets,
    iter4othertargets,
    iter5othertargets
  )


write.csv(
  iterresultsbfi2,
  "Your/Path/iter_1-5_othertargets.csv"
)


### Der Versuch Modelle mit den Items entsprechend den Items des BFI10 zu laden ----------------

bfi10true <- list()
resdf_bfi10 <- list()

bfi10true <-
  grepl("E6", resdf_sav$Predictions) &
  grepl("E2", resdf_sav$Predictions) &
  grepl("A3", resdf_sav$Predictions) &
  grepl("C6", resdf_sav$Predictions) &
  grepl("N1", resdf_sav$Predictions) &
  grepl("N3", resdf_sav$Predictions) &
  grepl("O9", resdf_sav$Predictions)


bfi10_r2 <-
  grepl("E2", iterresultsbfi2$Predictions) &
  grepl("C10", iterresultsbfi2$Predictions) &
  grepl("C6", iterresultsbfi2$Predictions) &
  grepl("O9", iterresultsbfi2$Predictions) &
  grepl("N1", iterresultsbfi2$Predictions) &
  grepl("N3", iterresultsbfi2$Predictions) &
  grepl("O9", iterresultsbfi2$Predictions) &
  grepl("O2", iterresultsbfi2$Predictions)
bfi10_r2othertargets <-
  grepl("E2", iter_all_othertargets$Predictions) &
  grepl("C10", iter_all_othertargets$Predictions) &
  grepl("C6", iter_all_othertargets$Predictions) &
  grepl("O9", iter_all_othertargets$Predictions) &
  grepl("N1", iter_all_othertargets$Predictions) &
  grepl("N3", iter_all_othertargets$Predictions) &
  grepl("O9", iter_all_othertargets$Predictions) &
  grepl("O2", iter_all_othertargets$Predictions)

which(bfi10true)

bfi10_r2 <- iterresultsbfi2[which(bfi10_r2), ]
bfi10_r2othertargets <-
  iter_all_othertargets[which(bfi10_r2othertargets), ]


oldtargets1 <- grepl("A4", resdf_bfi10$Predictions)
oldtargets2 <- grepl("A7", resdf_bfi10$Predictions)
oldtargets3 <- grepl("A9", resdf_bfi10$Predictions)
oldtargets4 <- grepl("A6", resdf_bfi10$Predictions)
oldtargets5 <- grepl("A8", resdf_bfi10$Predictions)
oldtargets6 <- grepl("A2", resdf_bfi10$Predictions)
oldtargets7 <- grepl("C10", resdf_bfi10$Predictions)
oldtargets8 <- grepl("E4", resdf_bfi10$Predictions)
oldtargets9 <- grepl("N2", resdf_bfi10$Predictions)
oldtargets10 <- grepl("O2", resdf_bfi10$Predictions)

oldtargets12 <- which(oldtargets1 & oldtargets2)

resdf_bfi10 <- resdf_bfi10[which(oldtargets), ]


shortiter <-
  grepl("N1", resdf_sav$Predictions) &
  grepl("A3", resdf_sav$Predictions) &
  grepl("E2", resdf_sav$Predictions)
shortiter2 <-
  grepl("N1", iterresultsbfi2$Predictions) &
  grepl("A3", iterresultsbfi2$Predictions) &
  grepl("E2", iterresultsbfi2$Predictions)

short1 <- resdf_sav[which(shortiter), ]
short2 <- iterresultsbfi2[which(shortiter2), ]


### Testen der BFI10 Auswertung + Plot ------------------------------------------------

e1 <<- 1
e6 <<- 2
a2 <<- 3
a7 <<- 4
c3 <<- 5
c8 <<- 1
n4 <<- 2
n9 <<- 3
o5 <<- 4
o10 <<- 5

# E6 <- 2
# E2 <- 3
# A3 <- 4
# A8 <- 5
# C10 <- 1
# C6 <- 2
# N1 <- 3
# N3 <- 4
# O9 <- 5
# O2<-1


e1 <<- 6 - e1
c3 <<- 6 - c3
n4 <<- 6 - n4
o5 <<- 6 - o5
a7 <<- 7 - a7

extraversion <<- mean(e1, e6)
agreeableness <<- mean(a2, a7)
conciousness <<- mean(c3, c8)
neuroticism <<- mean(n4, n9)
openness <<- mean(o5, o10)

bfi10 <- data.frame()

bfi10 <<- data.frame(
  "Extraversion" = extraversion,
  "Verträglichkeit" = agreeableness,
  "Gewissenhaftigkeit" = conciousness,
  "Neurotizismus" = neuroticism,
  "Offenheit" = openness
)


bfi10 <- data.frame(
  Scale = c(
    'Offenheit',
    'Gewissenhaftigkeit',
    'Extraversion',
    'Verträglichkeit',
    'Neurotizismus'
  ),
  Value = c(
    openness,
    conciousness,
    extraversion,
    agreeableness,
    neuroticism
  )
)

plot(bfi10)

ggplot(bfi10, aes(x = Scale, y = Value)) +
  geom_bar(stat = "identity", fill = rgb(0.258, 0.545, 0.792, 0.8)) + ylim(0, 5) + labs(x = "Faktoren", y =
                                                                                          "Ausprägung")

output$bfi <- renderPlot({
  d <- bfi10()
  plot(
    d$Extraversion,
    d$Verträglichkeit,
    d$Gewissenhaftigkeit,
    d$Neurotizismus,
    d$Offenheit
  )
})

## Testen der Modell Prediction --------------------------------------

premodel <-
  readRDS(file = "Your/Path/svmmodel_A4~E6+A3+A8+N1+N3.rds")

TESTdf <- data.frame(
  E6 = 5,
  A3 = 1,
  A8 = 1,
  N1 = 5,
  N3 = 5
)

testA4 <- predict(premodel, dat)

var(testA4)

hist(testA4, breaks = 20)

r <<- round(predict(premodel, TESTdf)[[1]])


premodel2 <-
  readRDS(file = "Your/Path/svmmodel_O9~E2+C10+C6+N1+N3+O2.rds")

TESTdf2 <- data.frame(
  E2 = 1,
  C10 = 1,
  C6 = 1,
  N1 = 1,
  N3 = 1,
  O2 = 1
)

predict(premodel2, TESTdf2)

r <<- round(predict(premodel2, TESTdf2)[[1]])


