library(rhdf5)
library(wavethresh)
library(xgboost)


filepath <- 'F:/TestSongFile100/testsong/'
test_features <- features(filepath, single_feature)
load('F:/model.RData')
test_lyr <- vector()
for (i in 1:length(model)){
  test_lyr <- cbind(test_lyr, predict(model[[i]], as.matrix(test_features)))
  print(i)
}

test_lyr_nonum <- test_lyr
test_lyr_nonum[,c(1:2,5:29)] <- rep(min(test_lyr_nonum)-1, nrow(test_lyr_nonum))

test_rank <- vector()
for (j in 1:nrow(test_lyr_nonum)){
  test_rank <- rbind(test_rank, rank(-test_lyr_nonum[j,]))
  print(j)
}
songname <- vector()
for (k in 1:nrow(test_rank)){
  songname[k] <- paste('testsong',as.character(k),sep='')
}
submission <- cbind(songname, test_rank)
colnames(submission) <- colnames(lyr)
submission <- as.data.frame(submission)
save(submission, file = 'F:/submission.csv')
write.csv(submission, file = 'F:/submission.csv')