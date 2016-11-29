#PROJECT 4 FALL 2016
##Jing Mu (jm4269)

##Project Description
In this project, we are provided a dataset of 2350 songs (in hdf5 format) and a data frame showing the frequency of words in each song's lyrics. The dictionary contains 5000 words, hence the lyrics dataframe is of dimension 2350 * 5000. Our goal is to predict the existence of the words in the lyrics (by ranking the possbility) when giving 100 new songs.

##1. Define the Problem
I treat this problem as a supervised learning according to the word 'PREDICT'.Therefore, I need to define my X (variables) and Y (responses) here.

For each song, there are 15 features availble. 13 of them are vectors of various lengths. The rest 2 features (segments_pitches and segments_timbre) are matrices of 12 rows and same number of columns. Moreover, the dimensions of the features between different songs are also different. The problem of computing X is to convert the features into the same dimension.

Y seems a little bit easier. We can treat every word as a response and using supervised methods to fit 5000 models. However, the computation training time could be long.

##2. Feature Extraction
Names of the 15 features are listed below:
+ bars_confidence, bars_start
+ beats_confidence, beats_start
+ sections_confidence, sections_start
+ segments_confidence, segments_loudness_max, segments_loudness_max_time, segments_loudness_start, segments_pitches, segments_start, segments_timbre
+ tatums_confidence, tatums_start

According to [lpt](http://www.nature.com/articles/srep00521), loudness, pitches and timbre are the three primary musical facets in contemporary western popular music. Therefore it is necessary to include them in the extracted features.

The rest raw features are all related with 'confidence' which represents the confidence level (between 0 and 1) when transmitting the music into numerical data. There are five of these type: bars, beats, sections, segments and tatums.

After examing some samples, the 1st song can be a good representative for browsing the features:
![image](https://github.com/TZstatsADS/Fall2016-proj4-jingmu2014/blob/master/figs/barsbeatssections.png)
![image](https://github.com/TZstatsADS/Fall2016-proj4-jingmu2014/blob/master/figs/segmentstatums.png)

From the graphs we can see that beats and segments have the highest confidence values, sections and tatums have middle level confidence values, while bars have least confidence values. However, in order to make better prediction, I choose to keep all of them.

In order to convert these features to a single vector for each song, I computed the quantiles for each features if it is a vector and the quantiles for each row if is a matrix. After that, I joined the quantiles together to make a vector.

13 of the features are of vectors while 2 others are of matrix with 12 rows. Therefore, the result vector will be of length ((13+2\*12)\*5 = 185) for each song. Since there are 2350 songs in the training set, the resulting feature matrix will be of dimension 2350 \* 185.

This part takes about 5 minutes with 2350 training data.

##3. Response Manipulation
Since we are predicting the existence of the words in a particular song, not its frequency, it is acceptable to transfer the lyrics dataset to binary responses (0 = The word is not in this song and 1 = The word is in this song). Hence I discard the information of numeber of appearance of a word in a particular song. The response matrix of lyrics is now of dimension 2350 \* 5001 (the first column is song ID) with 0 and 1 entries.

##4. Model Fitting
The project now becomes a classification problem which we need to fit 5000 models, one for each word. The training time takes about 3hours.  
I used Extreme Gradient Boosting (xgboost) in this project, the reasons are as below:  
1. Xgboost produces the probability which means we are able to rank them for the final result.  
2. Xgboost tends not to overfittng.  
3. Xgboost can handle NA data in the features.  
4. Xgboost is computational fast.  

##5. Prediction
Since the number columns are not required for the submission, after I computed the probablities, I set these columns to be the least number in the matrix minus 1. This computation will ensure these columns ranked as 4987.

##6. Summary
One problem in this project is that the response is sparse. There are a lot 0's in the matrix. Most common classifiers do not perform well in this situation.  
To conquer the problem, cascading classifer could be applied here. We could also use a larger sample if possible.
