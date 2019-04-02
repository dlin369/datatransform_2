library(tidyverse)

# print working directory (You should be in ~/Datatransform2)
cat(paste("Your current working directory is: ",
          getwd(), 
          sep = "\n"))

#bring in the Phoible inventories data
inventories <- read.csv("Contributions.csv")

# bring in the Austronesian Comparative Dictionary (Proto Language Data)
acd_data <- read.csv("acdwebscrape.csv")

#use mutate to add a column that calculates the ratio of consonants to vowels
# # # # # # # # # # # # # # # # # # # # # # # # # 
ratio <- mutate(inventories, 
                cvratio = count_consonant / count_vowel)

#arrange the rows by the new column values in descending order
# # # # # # # # # # # # # # # # # # # # # # # # # 
ratio_ordered <- arrange(ratio, 
                         desc(
                           cvratio
                           )
                         )

# make a test grouping by token and gloss
# # # # # # # # # # # # # # # # # # # # # # # # # 
testgroup <- group_by(acd_data, #load the main data
                      token_data, #add a group
                      gloss_data) #add a second group

# summarise (remove duplicates) in the grouping
test_sum <- summarise(testgroup)

# make a test grouping by token and gloss (2)
# # # # # # # # # # # # # # # # # # # # # # # # # 
testgroup_2 <- group_by(ratio, #load the main data
                      count_consonant #add a group
                      ) 

# set up a dataframe that summarizes w/respect to consonant and vowel counts
test_sum2 <- summarise(testgroup_2, # load data
          ratio_mean = mean(cvratio, # create a new column for the mean of cvratio that will process by group
                            na.rm = TRUE # if there is 'blank' data (NA values), just remove them
                            )
          )

# make a plot of the summarise data
ggplot(data = test_sum2, # load plot data
       mapping = aes(x = count_consonant, # assign axis data
                     y = ratio_mean)
       ) + 
  geom_point() + # dot layer
  geom_smooth(se = FALSE) # curve layer

# How to make code simpler? Pipe: %>%

# rewrite of above code
ratio_plot <- mutate(inventories, 
                cvratio = count_consonant / count_vowel
                )%>%
group_by(
          count_consonant #add a group
)%>%
summarise(ratio_mean = mean(cvratio, # create a new column for the mean of cvratio that will process by group
                            na.rm = TRUE # if there is 'blank' data (NA values), just remove them
                            )
)%>%
ggplot(mapping = aes(x = count_consonant, # assign axis data
                     y = ratio_mean)
) + 
  geom_point() + # dot layer
  geom_smooth(se = FALSE) # curve layer

# n() (count)
# check the prevalence of given values of ratio_mean in the data
ratio_plot <- mutate(inventories, 
                     cvratio = count_consonant / count_vowel
)%>%
  group_by(
    count_consonant #add a group
  )%>%
  summarise(ratio_mean = mean(cvratio, # create a new column for the mean of cvratio that will process by group
                              na.rm = TRUE # if there is 'blank' data (NA values), just remove them
                              ),
            n = n()
  )

  ggplot(data = ratio_plot, 
         mapping = aes(x = n, # assign axis data
                       y = ratio_mean)
  ) + 
  geom_point()
  
# so for some reason there appears to be higher variation in ratio_mean when
  # the count for given mean value of c/v is lower?
  
  # try adding a filter with pipe
  ratio_plot <- mutate(inventories, 
                       cvratio = count_consonant / count_vowel
  )%>%
    group_by(
      count_consonant #add a group
    )%>%
    summarise(ratio_mean = mean(cvratio, # create a new column for the mean of cvratio that will process by group
                                na.rm = TRUE # if there is 'blank' data (NA values), just remove them
    ),
    n = n()
    )%>%
  filter(n < 50)
    
  ggplot(data = ratio_plot, 
         mapping = aes(x = n, # assign axis data
                       y = ratio_mean)
  ) + 
    geom_point()



