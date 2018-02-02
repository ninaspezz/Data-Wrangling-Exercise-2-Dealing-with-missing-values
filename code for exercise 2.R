library(readr)
library(dplyr)
library(tidyr)

df <- read_csv('titanic_original.csv')
summary(df)

na_if(df, '')

#1: Port of embarkation: Find the missing values and replace them with S.#

df <- mutate(df, embarked = replace(embarked, is.na(embarked), 'S'))
df[169,11]
df[10,5]

#2: Age: Calculate the mean of the Age column and use that value#
#to populate the missing values#

df <- mutate(df, age = replace(age, is.na(age), mean(df$age, na.rm=TRUE)))
df[16,5]
df[15,5]

#Think about other ways you could have populated the missing values# 
#in the age column. Why would you pick any of those over the mean# 
#(or not)?#

#Could have calculated mean of sub-sets of passengers, such as surived
#or class and filled in missing values of each within respective class.#

#3: Lifeboat: there are a lot of missing values in the boat column. Fill# 
#these empty slots with a dummy value e.g. the string 'None' or 'NA'#

#This was done in above command: na_if(df, '')#

df[3,12]

#4: many passengers don’t have a cabin number associated with them.#
#Does it make sense to fill missing cabin numbers with a value?#
#I think it makes sense to replace blank values with "NA", which was#
#done in above step.#

#What does a missing value here mean?#
#Possible it means just that, a missing cabin number. Upon manually#
#inspecting data, it does not appear that the presense or absense of#
#a cabin number in this data set correlates to survival.#

#Create a new column has_cabin_number which has 1 if there is# 
#a cabin number, and 0 otherwise.#

df <- mutate(df, has_cabin_number = if_else(!is.na(cabin), '1', '0'))
df[10,15]
df[11,15]

write_csv(df, 'titanic_clean.csv')
