# load libraries
library(tidyverse)
library(lubridate)
library(skimr)

# import data

indo_larvae <- read.csv("data/indo_larvae.csv")

# mutate variables
pl.centre <- indo_larvae %>%
  mutate(date = dmy(date),
         tank = gsub("(^|[^0-9])0+", "\\1", tank, perl = TRUE),
         tank = gsub("(?<!A)-[0-9]*", "", tank, perl = TRUE),
         tank = gsub("-", "", tank),
         feed = str_replace(feed,
                            c("ARtemia bio|artemia Bio|Artemia Bio energy|Artemia Bio|artemia bio"),
                            "Artemia bio"),
         feed = str_replace(feed, c("Fangli|fengli"), "Fengli"),
         feed = str_replace(feed, "Frippak CAR 1", "Frippak CAR1"),
         feed = str_replace(feed, "encap mysis", "Encap Mysis"),
         feed = str_replace(feed, "ENCAP EPL", "Encap EPL"),
         across(where(is.character), str_trim)) %>%
  mutate_if(is.character, list(~na_if(.,""))) %>%
  filter(!tank == "B1")
  
  
  
  