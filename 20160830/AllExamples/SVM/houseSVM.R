library('e1071')
house = read.csv('./SVM/house.csv')

Y = house$price
X = cbind(house$county, house$type, house$year, house$bed, house$living)
n = length(Y)
trainDataID = c(1:(n*0.5))
TrainData = data.frame(Y[trainDataID],X[trainDataID,])
names(TrainData) = c('label', 'county', 'type', 'year', 'bed', 'living')
TestData = data.frame(Y[-trainDataID],X[-trainDataID,])
names(TestData) = c('label', 'county', 'type', 'year', 'bed', 'living')


tune.svm(label ~ ., data = TrainData, degree = 1:3, gamma = c(0.1,0.9,0.01), cost = 1:10)

svm.model = svm( label ~ ., TrainData, kernal='radial', type = 'eps-regression', cost = 1, gamma = 0.9, degree = 1, epsilon = 0.001)
svm.pred = predict(svm.model, TestData)

plot(TestData$label, col="red")
par(new=TRUE)
plot(svm.pred, col="blue")
RMSE = mean( abs(TestData$label - svm.pred) / TestData$label )


