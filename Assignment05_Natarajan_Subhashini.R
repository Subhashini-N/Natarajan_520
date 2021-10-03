## Assignment 5.2. - Housing Data - Data Wrangling
##Natarajan, Subhashini
##10/03/2021

library(tidyverse)
library(purrr)

##names(housing_data)[2]<-paste("Sale_Price") ## Change the name of the field
##names(housing_data)[1]<-paste("Sale_Date")
str(housing_data)

## group by
housing_data_grp  <- housing_data %>% group_by(Sale_Date)
head(housing_data_grp)

##summarise

housing_data_grp %>% summarise(
  sum_sales = sum(Sale_Price),
  max_sale = max(Sale_Price)
)

str(housing_data)

##mutate
housing_data_grp %>%
  select(ctyname , zip5,year_built,Sale_Date ) %>%
  mutate(
    Sale_Year<-format(Sale_Date,format="%Y")
  )

##filter  Obtain the list of houses sold in the past 10 years
housing_data_grp %>% filter(format(Sale_Date,format="%Y") > 2010)

## Select 
housing_data %>%
  select(ctyname , zip5,year_built,Sale_Date )


##Sort descending
housing_data %>% arrange(desc(year_built))

## Purr Package functions

map_chr(housing_data, typeof) ## Class function

housing_data_city <- split(housing_data, housing_data$ctyname) ## split based on city name
head(housing_data_city)

saleprice_vector <- housing_data$Sale_Price  ## Keep
head(saleprice_vector)
keep(saleprice_vector, ~ .x >500000) ## Keep prices greater than 500k
discard(saleprice_vector, ~.x <500000) ## Discard prices lesser than 500k


div_thousands <- function(n) {
  n /1000
}  ## Map function

map(saleprice_vector, div_thousands) ## All Sale prices are divided by 1000

##Cbind - Binds columns together

salecity_vector<-housing_data$ctyname
new_housing_gr <-cbind(saleprice_vector, salecity_vector)
head(new_housing_gr)

##Rbind - Binds rows together

salecity_vector_more500k <-keep(saleprice_vector, ~ .x >500000)
salecity_vector_less500k <-keep(saleprice_vector, ~.x<500000)
rbind(salecity_vector_more500k, salecity_vector_less500k) ## Binds the data together

##Split & merge the string


split_addr <-strsplit("R for stats", split = " ")
head(split_addr)


concat_addr<-paste("R","for","stats")
head(concat_addr)