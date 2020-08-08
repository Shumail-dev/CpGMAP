if (!require('neuralnet')) install.packages('neuralnet'); library('neuralnet')
if (!require('tidyverse')) install.packages('tidyverse');
if (!require('readxl')) install.packages('readxl'); library('readxl')
if (!require('dplyr')) install.packages('dplyr'); library('dplyr')

spleen <- read_excel("/home/mtalhas/Documents/Shumail/Projects/R/spleen.xlsx")
View(spleen)
score<- spleen %>% select(score)
methRatio<-spleen %>% select(methRatio)
lbl<-spleen %>% select(Label)
lbl<- unlist(lbl)
cytosineCount<-spleen %>% select(cytosineCount)
df=data.frame(score,methRatio,lbl,cytosineCount)
df_t= data.frame(score, methRatio, cytosineCount)
trainset <- df[1:5000, ]
nn <- neuralnet(lbl ~ methRatio+score+cytosineCount, data = trainset, hidden = 3, act.fct = "logistic", linear.output = FALSE, stepmax=1e15)
plot(nn)
testset <- df_t[54001:54585, ]
Predict <- neuralnet :: compute(nn,testset)
Predict$net.result
prob <- Predict$net.result
pred <- ifelse(prob>0.5, 1, 0)
pred
