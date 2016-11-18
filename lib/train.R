library(rhdf5)
library(wavethresh)
library(xgboost)

####Model Fitting
##using xgboost
train <- function(X,y){
    model <- list()
    for (i in 1:ncol(y)){
        dtrain <- xgb.DMatrix(as.matrix(songf), label = y[,i], missing = NaN)
        xg_fit <- xgboost(dtrain, nrounds = 20, verbose_eval = FALSE)
        model[[i]] <- xg_fit
    }
    return(model)
}