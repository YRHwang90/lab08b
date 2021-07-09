# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(here) 
library(robotstxt)
paths_allowed("https://www.opensecrets.org")

# function: scrape_pac ---------------------------------------------------------

scrape_pac <- function(url) {
  
  # read the page
  page <- read.html(url)
  
  # extract the table
  pac <-  page %>%
    # select node .DataTable (identified using the SelectorGadget)
    html_node(".DataTable") %>%
    # parse table at node td into a data frame
    #   table has a head and empty cells should be filled with NAs
    html_table("td", header = NA, fill = FALSE) %>%
    # convert to a tibble
    as_tibble()
  
  # rename variables
  pac <- pac %>%
    # rename columns
    rename(
      name = PAC Name (Affiliate),
      country_parent = Country of Origin/Parent Company,
      total = Total,
      dems = Dems,
      repubs = Repubs
    )
  
  # fix name
  pac <- pac %>%
    # remove extraneous whitespaces from the name column
    mutate(name = )
  
  # add year
  pac <- pac %>%
    # extract last 4 characters of the URL and save as year
    mutate(year = str_sub(url,-4))
  
  # return data frame
  pac
  
}

# test function ----------------------------------------------------------------

url_2020 <- "___"
pac_2020 <- scrape_pac(___)

url_2018 <- "___"
pac_2018 <- scrape_pac(___)

url_1998 <- "___"
pac_1998 <- scrape_pac(___)

# list of urls -----------------------------------------------------------------

# first part of url
root <- "https://www.opensecrets.org/political-action-committees-pacs/foreign-connected-pacs?cycle="

# second part of url (election years as a sequence)
year <- seq(from = ___, to = ___, by = ___)

# construct urls by pasting first and second parts together
urls <- paste0(___, ___)

# map the scrape_pac function over list of urls --------------------------------

pac_all <- ___(___, ___)

# write data -------------------------------------------------------------------

write_csv(___, file = here::here("data/pac-all.csv"))
