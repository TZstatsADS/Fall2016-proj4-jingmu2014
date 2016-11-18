library(rhdf5)
library(wavethresh)
library(xgboost)

####Feature Analysis
filepath <- 'F:/Project 4/data'
files <- dir(filepath, recursive = T, full.names = T, pattern = '\\.h5$')
f_analysis <- h5read(files[1],'/analysis')

par(mfrow = c(1,3))
hist(f_analysis$bars_confidence, main = 'bars_confidence', xlab = 'bars_confidence')
hist(f_analysis$beats_confidence, main = 'beats_confidence', xlab = 'beats_confidence')
hist(f_analysis$sections_confidence, main = 'sections_confidence', xlab = 'sections_confidence')
par(mfrow = c(1,2))
hist(f_analysis$segments_confidence, main = 'segments_confidence', xlab = 'segments_confidence')
hist(f_analysis$tatums_confidence, main = 'tatums_confidence', xlab = 'tatums_confidence')
par(mfrow = c(1,1))

####Feature Extraction
single_feature <- function(h5file){#extract features for a single song
    h5file['songs'] <- NULL
    feature <- vector()
    for (i in 1:length(h5file)){
        if (class(h5file[[i]]) != 'matrix'){
            v <- quantile(h5file[[i]], names = F)
        }
        else {
            v <- vector()
            for (j in 1:nrow(h5file[[i]])){
                v <- rbind(v, quantile(h5file[[i]][j],names = F))
            }
        }
        feature <- rbind(feature, v)
    }
    return(as.vector(t(feature)))
}

features <- function(filepath, func){
    files <- dir(filepath, recursive = T, full.names = T, pattern = '\\.h5$')
    features <- vector()
    H5close()
    
    for (i in 1:length(files)){
        f <- h5read(files[i], '/analysis')
        f_feature <- func(f)
        features <- rbind(features, f_feature)
        print(i)
    }
    return(features)
}

songf <- features(filepath, single_feature)

####Response manipulation
load('F:/Project 4/lyr.RData')
y <- lyr[,-1]
y <- (y>0) + 0