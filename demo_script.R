library(tidyverse)

# print working directory (You should be in ~/Datatransform2)
cat(paste("Your current working directory is: ",
          getwd(), 
          sep = "\n"))

#bring in the Phoible inventories data
inventories <- read.csv("Contributions.csv")

#use mutate to add a column that calculates the ratio of consonants to vowels
ratio <- mutate(inventories, cvratio = count_consonant / count_vowel)

#arrange the rows by the new column values in descending order
ratio_ordered <- arrange(ratio, desc(cvratio))

# bring in the Austronesian Comparative Dictionary (Proto Language Data)
acd_data <- read.csv("acdwebscrape.csv")

# make a test grouping by token and gloss
testgroup <- group_by(acd_data, token_data, gloss_data)
# summarise (remove duplicates) in the grouping
test_sum <- summarise(testgroup)
