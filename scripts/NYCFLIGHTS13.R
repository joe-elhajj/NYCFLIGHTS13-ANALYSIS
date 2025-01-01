#Carolina Angel

#install
install.packages('nycflights13')
library (nycflights13)
?flights

# load data
data(flights) # load data
data(weather)

#join the tables using left_join
?join
install.packages("dplyr")
library(dplyr)
flights_weather0 <- left_join(flights, weather, by = c("year", "month", "day", "hour", "origin"))
View(flights_weather0)

#remove features not needed for our project  
flights_weather = select(flights_weather0,-"precip",-"time_hour.x", -"time_hour.y")
View(flights_weather)

# (added) remove NA
flights_weather <- na.omit(flights_weather)

#save cleaned dataset
write.csv (flights_weather, file = "flights_weather.csv")

#Summary of dataset.
summary(flights_weather)

#hist of arrival delay
hist(flights_weather$arr_delay, main="Histogram of Arrival Delays", 
     xlab="Arrival Delay (minutes)", col="lightblue", breaks=50)

hist(flights_weather$month, main="Histogram of Months", 
     xlab="Month", col="lightblue", breaks=50)
#----------------------------------------------------------------------------------------------------
#linear modeling --------
trainIdx <- sample(26115, 10000) # pick 10000 indices out of 1-26115
train_set <- flights_weather[trainIdx, ]
test_set <- flights_weather[-trainIdx, ]

#linear model all 
linear_model_all <- lm(arr_delay ~ dep_delay + visib + wind_gust + pressure,
                             train_set)
summary(linear_model_all)
composite_predictor <- train_set$dep_delay + train_set$visib + 
  train_set$wind_gust + train_set$pressure

# Plot composite predictor vs arr_delay
plot(composite_predictor, train_set$arr_delay,
     main = "Composite Predictors vs Arrival Delay",
     xlab = "Composite Predictors",
     ylab = "Arrival Delay (minutes)",
     cex = 0.4, # marker size
     pch = 7)  # marker type

predictions_all <- predict(linear_model_all, test_set) # dataset we want to predict
mse <- mean(( test_set$arr_delay - predictions_all)^2, na.rm = TRUE)
mse 


#dep delay ----------------
# use train set to build linear model for predicting arrival delay using dep delay
linear_model_dep_delay <- lm(arr_delay ~ dep_delay, # formula: output ~ input
                   train_set) # dataset

# check linear model 
summary(linear_model_dep_delay) # arr_delay = -4.376239 + 1.024788 * dep_delay
#r = 0.9132 
# strong positive correlation 
#r^2 = 0.834
#R^2 84% the variation in the arrival delay is explained by the departure delay

# plot
plot(train_set$dep_delay,
     train_set$arr_delay,
     main = "Departure Delay vs Arrival Delay",
     xlab = "dep_delay (minutes)",
     ylab = "arr_delay (minutes)",
     cex = 0.4, # marker size 
     pch = 7) # marker type 

# predict using test set
predictions_dep_delay <- predict(linear_model_dep_delay, test_set) # dataset we want to predict
mse <- mean(( test_set$arr_delay - predictions_dep_delay)^2, na.rm = TRUE)
mse 
#mse = 329.7127

# visib ------------------------
# use train set to build linear model for predicting arrival delay using visibility
linear_model_visb <- lm(arr_delay ~ visib, # formula: output ~ input
                   train_set) # dataset

# check linear model 
summary(linear_model_visb) # arr_delay = 14.8419 - 1.1141 * visib
#r = 0.07523
# weak correlation
#r^2 = 0.005661
#R^2 0.5661% the variation in the arrival delay is explained by the visib

# plot
plot(train_set$visib,
     train_set$arr_delay,
     main = "Visibility vs Arrival Delay",
     xlab = "visib (miles)",
     ylab = "arr_delay (minutes)",
     cex = 0.4, # marker size 
     pch = 7) # marker type 

# predict using test set
predictions_visib <- predict(linear_model_visb, test_set) # dataset we want to predict
mse <- mean(( test_set$arr_delay - predictions_visib)^2, na.rm = TRUE)
mse 
#mse = 1990.967

#wind_gust -------------
# use train set to build linear model for predicting arrival delay using wind gust
linear_model_wind_gust <- lm(arr_delay ~ wind_gust, # formula: output ~ input
                        train_set) # dataset

# check linear model 
summary(linear_model_wind_gust) # arr_delay = -1.5794 + 0.3075 * wind_gust
# r = 0.0444
# week correlation 
#r^2 = 0.001974
#R^2 0.1974% the variation in the arrival delay is explained by the wind_gust

# plot
plot(train_set$wind_gust,
     train_set$arr_delay,
     main = "Wind Gust vs Arrival Delay",
     xlab = "wind_gust (mph)",
     ylab = "arr_delay (minutes)",
     cex = 0.4, # marker size 
     pch = 7) # marker type 

# predict using test set
predictions_wind_gust <- predict(linear_model_wind_gust, test_set) # dataset we want to predict
mse <- mean(( test_set$arr_delay - predictions_wind_gust)^2, na.rm = TRUE)
mse 
#mse = 2009.787



#pressure -------
# use train set to build linear model for predicting arrival delay using pressure
linear_model_pressure <- lm(arr_delay ~ pressure, # formula: output ~ input
                             train_set) # dataset

# check linear model 
summary(linear_model_pressure) # arr_delay = 625.57665 - 0.60907 * pressure
#r = 0.10816
# week correlation 
#r^2 = 0.0117
#R^2 1.17% the variation in the arrival delay is explained by the pressure

# plot
plot(train_set$pressure,
     train_set$arr_delay,
     main = "Pressure vs Arrival Delay",
     xlab = "pressure (mb)",
     ylab = "arr_delay (minutes)",
     cex = 0.4, # marker size 
     pch = 7) # marker type 

# predict using test set
predictions_pressure <- predict(linear_model_pressure, test_set) # dataset we want to predict
mse <- mean(( test_set$arr_delay - predictions_pressure)^2, na.rm = TRUE)
mse 
#mse = 1743.119


#----------------------------------------------------------------------------------------------------
#random forest 
install.packages("randomForest")
library(randomForest)

train_set <- na.omit(train_set)
test_set <- na.omit(test_set)

# Convert arr_delay to a categorical variable: "delayed" or "on time"
?ifelse
train_set$delay_status <- ifelse(train_set$arr_delay > 0, "delayed"
                                 , "on time")
test_set$delay_status <- ifelse(test_set$arr_delay > 0, "delayed"
                                , "on time")

# Convert to factor for classification
train_set$delay_status <- as.factor(train_set$delay_status)
test_set$delay_status <- as.factor(test_set$delay_status)

?randomForest
rf <- randomForest(delay_status ~ dep_delay + visib + wind_gust + pressure, 
                   train_set, 
                   ntree = 500, # Number of trees
                   mtry = 2) # Number of variables randomly sampled as candidates at each split
rf   



#OOB estimate of  error rate: 22.85%
#Confusion matrix:
#         delayed   on time   class.error
#delayed    2562     1599    0.3842826
#on time     686     5153    0.1174859

# compare model performance (use testing data)

# predict
rf_pred <- predict(rf, test_set)

confusion_matrix <- table(Predicted = rf_pred, Actual = test_set$delay_status)
print(confusion_matrix)

#                 Actual
#Predicted  delayed   on time
#delayed     17280    5457
#on time      9143    30854

# Accuracy
?accuracy
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Accuracy:", round(accuracy * 100, 2), "%"))

#"Accuracy: 76.72 %"

?importance
importance <- importance(rf)
varImpPlot(rf,
           main = "Feature Importance for Arrival Delay Classification")
mtext("Importance Score", side = 1, line = 2)


























                          