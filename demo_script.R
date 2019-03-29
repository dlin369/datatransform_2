# make it work

# print working directory (You should be in ~/Datatransform2)
cat(paste("Your current working directory is: ",
          getwd(), 
          sep = "\n"))

# bring in the Austronesian Comparative Dictionary (Proto Language Data)
acd_data <- read.csv("acdwebscrape.csv")

# testing function to split up strings and count them
sapply(
  strsplit(
    toString(
      acd_data$token_data[3333]),
    " "),
  length)

sapply(
  strsplit(
    toString(
      acd_data$gloss_data[3333]),
    " "),
  length)

