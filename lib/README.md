# Project: Words 4 Music

### Code lib Folder

The lib directory contains various files with function definitions (but only function definitions - no code that actually runs).

Feature.R includes extracting features from raw songs data and manipulate the response variables (i.e the lyrics)

Train.R is a function which takes features and response as input and output a list of 5000 xgboost models.

Test.R computes the result.
