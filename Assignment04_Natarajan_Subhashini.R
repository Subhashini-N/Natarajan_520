## Assignment 4.2.1 - Test Scores
##Natarajan, Subhashini
##09/22/2021

setwd("/Users/manikantanvenkataraman/Desktop/Data Science -College/Data Science/DSC520/dsc520")

scores <-read.csv("data/scores.csv")
head(scores)

## Variable to hold Sports section

sports_score <- filter(scores,Section=="Sports")
head(sports_score)

## Variable to hold Regular section

regular_score <- filter(scores,Section=="Regular")
head(regular_score)


## Plot functions for regular score and sports score

plot(sports_score$Score,sports_score$Count, xlab="Score", ylab="Number of Students", main="Sports Score Distribution" )
plot(regular_score$Score,regular_score$Count, xlab="Score", ylab="Number of Students", main= "Regular Score Distribution")


##Mean of number of students in both the sections

regscr_ls300 <- filter(regular_score,(Score)<"300")
mean(regscr_ls300$Count)
regscr_gr300 <- filter(regular_score,(Score)>="300")
mean(regscr_gr300$Count)
sprtscr_ls300 <- filter(sports_score,(Score)<"300")
mean(sprtscr_ls300$Count)
sprtscr_gr300 <- filter(sports_score,(Score)>="300")
mean(sprtscr_gr300$Count)


## Load housing dataset

library("readxl")

housing_data <-read_excel("data/week-7-housing.xlsx")
str(housing_data)

#apply function on a variable

apply_min<- apply(housing_data,2,min)
print(apply_min)

bldg_grd_sum <-lapply(housing_data$building_grade,sum)
print(bldg_grd_sum)

bldg_grd_sum2 <-sapply(housing_data$building_grade,sum)
print(bldg_grd_sum2)

##aggregate function
grp_agg <-aggregate(housing_data$building_grade~housing_data$year_built,data=housing_data,mean )
print(grp_agg)


##Plyr function on a variable, Split  & Merge
install.packages("plyr", dependencies = TRUE)
library(plyr)
ddply(housing_data,.(year_built),transform, mean_price=mean(housing_data$"Sale Price"))

library(dplyr)

##Select a specific column from data

housing_gr<-select(housing_data,year_built, building_grade )
head(housing_gr)
new_housing_gr <-transmute(housing_gr,year_built,mean_grade<-mean(housing_gr$building_grade) )
head(new_housing_gr)

##Combine Data
new_housing_data <-inner_join(housing_data, new_housing_gr, by = "year_built")
str(new_housing_data)

##Create new variables
new_housing_data <-transmute(housing_data, mean_price<-mean((housing_data$"Sale Price")), mean_grade<-mean(housing_data$building_grade))
str(new_housing_data)

##Distribution of housing data
plot(housing_data$year_built ,housing_data$"Sale Price", xlab="year built", ylab="Sale Price", main="House Sale Price" )
points(housing_data$square_feet_total_living,housing_data$"Sale Price", col="green")
