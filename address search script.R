##############################
# To start, pull geocoding data and filter addresses by addtype = 8, and CTNO2000 does not = NULL
# copy the patientid, address and city into the file addresses.csv
# concatenate the address and city into 1 column called 'search'
# run the following code to general a file with the first search result for each address
# conditionally format the search result column, e.g. if text contains 'family' highlight cell in red
# Go through and look at all cells not highlighted and see if a facility came up in the results
# Search for any unclear results to confirm whether residential or not
# update geocoding file with addtypes not = 1
#
# for reference with this code see: https://stackoverflow.com/questions/32889136/how-to-get-google-search-results
##############################


#  install.packages("rvest")
rm(list=ls())

#libraries.
library(rvest)

#confirm correct directory
getwd()

# Set working directory, if not correct
# setwd("K:/ABCs2018/CDC edits/CDC_GEO_CODE_ERRORS/Address Search")




# Function for getting search result.
getWebsite <- function(name)
{
  url = URLencode(paste0("https://www.bing.com/search?q=",name))
  
  page <- read_html(url)
  
  results <- page %>% 
    html_nodes("p") %>% # Get all notes of type cite. You can change this to grab other node types.
    html_text()
  
  result <- results[1]
  
  return(as.character(result)) # Return results if you want to see them all.
}




#load data
d <- read.csv("addresses.csv")
c <- as.character(d$search)
id <- d$patientid


# Apply the function to a list of company names.
desc <- data.frame(id, c, Website = sapply(c,getWebsite))


write.csv(desc, file = "searched.addresses.csv")






