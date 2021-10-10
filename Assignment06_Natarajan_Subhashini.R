##Exercise 6.2 _ Assignment 04
##Natarajan, Subhashini
##10/09/2021

## Load the ggplot2 package
library(ggplot2)
theme_set(theme_minimal())

## Set the working directory to the root of your DSC 520 directory
setwd("/Users/manikantanvenkataraman/Desktop/Data Science -College/Data Science/DSC520/dsc520")

## Load the `data/r4ds/heights.csv` to
heights_df <- read.csv("data/r4ds/heights.csv")
str(heights_df)

# https://ggplot2.tidyverse.org/reference/geom_boxplot.html
## Create boxplots of sex vs. earn and race vs. earn using `geom_point()` and `geom_boxplot()`
## sex vs. earn

ggplot(heights_df, aes(sex, earn))+geom_boxplot(colour = "blue", size = 4.5)
ggplot(heights_df, aes(race, earn))+geom_point()+geom_boxplot(colour = "blue", size = 4.5)

# https://ggplot2.tidyverse.org/reference/geom_bar.html
## Using `geom_bar()` plot a bar chart of the number of records for each `sex`
ggplot(heights_df, aes(sex)) + geom_bar(colour = "black",fill="blue", width = 0.2)


## Using `geom_bar()` plot a bar chart of the number of records for each race
ggplot(heights_df, aes(race)) + geom_bar(colour = "black",fill="cyan", width = 0.2)

## Create a horizontal bar chart by adding `coord_flip()` to the previous plot
ggplot(heights_df, aes(race)) + geom_bar(colour = "black",fill="cyan", width = 0.2)+ coord_flip()


# https://www.rdocumentation.org/packages/ggplot2/versions/3.3.0/topics/geom_path
## Load the file `"data/nytimes/covid-19-data/us-states.csv"` and
## assign it to the `covid_df` dataframe
covid_df <- read.csv("data/nytimes/covid-19-data/us-states.csv")

str(covid_df)

## Parse the date column using `as.Date()``
covid_df_dt <- as.Date(covid_df$date)

head(covid_df_dt)

## Create three dataframes named `california_df`, `ny_df`, and `florida_df`
## containing the data from California, New York, and Florida
california_df <- covid_df[which(covid_df$state == "California")]

head(covid_df,100)

## Unique values to obtain the values New York and Florida
unique(covid_df[c("state")])

california_df<-filter(covid_df,covid_df$state == "California")
head(california_df)
ny_df <- filter(covid_df,covid_df$state == "New York")
head(ny_df)
florida_df <-filter(covid_df,covid_df$state == "Florida")
head(florida_df)


## Plot the number of cases in Florida using `geom_line()`
ggplot(data=florida_df, aes(x=date, y=cases, group=2)) + geom_line(color='blue')


## Add lines for New York and California to the plot

ggplot(data=florida_df, aes(x=date, group=1)) +
  geom_line(aes(y = cases, col=state)) +
  geom_line(data=ny_df, aes(y = cases, col=state)) +
  geom_line(data=california_df, aes(y =cases,  col=state))

## Use the colors "darkred", "darkgreen", and "steelblue" for Florida, New York, and California
ggplot(data=florida_df, aes(x=date, group=1)) +
  geom_line(aes(y =cases), color = 'darkred') +
  geom_line(data=ny_df, aes(y = cases), color='darkgreen') +
  geom_line(data=california_df, aes(y = cases), color='steelblue')


## Add a legend to the plot using `scale_colour_manual`
## Add a blank (" ") label to the x-axis and the label "Cases" to the y axis
ggplot(data=florida_df, aes(x=date, group=1)) +
  geom_line(aes(y = cases, col="Florida")) +
  geom_line(data=ny_df, aes(y = cases, col="New York")) +
  geom_line(data=california_df, aes(y =cases,col="California")) +
  scale_colour_manual(values= c('Florida'='darkred',
                                'New York'='darkgreen', 
                                'California'='steelblue' ))+
  xlab("Date") + ylab("Cases")


## Scale the y axis using `scale_y_log10()`

ggplot(data=florida_df, aes(x=date, group=1)) +
  geom_line(aes(y = cases, col="Florida")) +
  geom_line(data=ny_df, aes(y = cases, col="New York")) +
  geom_line(data=california_df, aes(y =cases,col="California")) +
  scale_colour_manual(values= c('Florida'='darkred',
                                'New York'='darkgreen', 
                                'California'='steelblue' ))+
  xlab("Date") + ylab("Cases")+scale_y_log10()
