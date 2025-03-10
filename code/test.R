# use git with r
library(tidyverse)

## wide messy format
gap_wide <- readr::read_csv('https://raw.githubusercontent.com/carpentries-incubator/open-science-with-r/gh-pages/data/gapminder_wide.csv') 

## long tidy format
gapminder <- readr::read_csv('https://raw.githubusercontent.com/carpentries-incubator/open-science-with-r/gh-pages/data/gapminder.csv')

gap_wide_gdp <- gap_wide %>% select("continent", "country", starts_with("gdp"))

gdp_long <- gap_wide_gdp %>% pivot_longer(cols = contains("gdp"),
                                          names_to = "year",
                                          values_to = "gdpCap")

gdp_long <- gap_wide_gdp %>% pivot_longer(cols = -c(continent, country),
                                          names_to = "year",
                                          values_to = "gdpCap",
                                          names_prefix = "gdpPercap_")

gap_long <- 
  gap_wide %>% 
  pivot_longer(cols = - c(continent, country), 
               names_to = "temp_name") %>%                
  separate(col = "temp_name", into = c("variable","year"))

gap_long %>% filter(country=="Pakistan") %>% 
  ggplot(., aes(x = year, y = value, colour = variable)) +
  geom_point()+
  geom_line(group = 1) +
  facet_wrap(~variable) +
  labs(x = "Year", y = "value") 

  
