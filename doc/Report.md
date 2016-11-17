#PROJECT 4 FALL 2016
##Jing Mu (jm4269)

##Project Description
In this project, we are provided a dataset of 2350 songs (in hdf5 format) and a data frame showing the frequency of words in each song's lyrics. The dictionary contains 5000 words, hence the lyrics dataframe is of dimension 2350 * 5000. Our goal is to predict the existence of the words in the lyrics (by ranking the possbility) when giving 100 new songs.

##1. Define the Problem
I treat this problem as a supervised learning according to the word 'PREDICT'.Therefore, I need to define my X (variables) and Y (responses) here.

For each song, there are 15 features availble. 13 of them are vectors of various lengths. The rest 2 features (segments_pitches and segments_timbre) are matrices of 12 rows and same number of columns. Moreover, the dimensions of the features between different songs are also different. The problem of computing X is to convert the features into the same dimension.

Y seems a little bit easier. We can treat every word as a response and using supervised methods to fit 5000 models. However, the computation training time could be long.

##2. Feature Extraction


##3. Response Manipulation


##4. Model Fitting


##5. Prediction


##6. Summary
