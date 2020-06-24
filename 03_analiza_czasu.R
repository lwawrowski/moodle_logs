library(tidyverse)

load("data/logs_anonim.RData")

# tydzień przed pandemią

logs_anonim %>% 
  filter(godz >= "2020-03-09 01:00:00", godz <= "2020-03-15 23:00:00", nazwa_anonim != "ŁW") %>% 
  count(czas) %>% 
  ggplot(aes(x=czas, y=n)) + geom_point()
  
# tydzień w pandemi

logs_anonim %>% 
  filter(godz >= "2020-04-20 01:00:00", godz <= "2020-04-26 23:00:00", nazwa_anonim != "ŁW") %>% 
  count(czas) %>% 
  ggplot(aes(x=czas, y=n)) + geom_point()

# cały semestr

logs_anonim %>% 
  filter(godz >= "2020-03-09 01:00:00", godz <= "2020-06-23 23:00:00", nazwa_anonim != "ŁW") %>% 
  count(czas) %>% 
  ggplot(aes(x=czas, y=n)) + geom_point()

# wybrany student 23JA9vQNpe

logs_anonim %>% 
  filter(godz >= "2020-03-09 01:00:00", godz <= "2020-06-23 23:00:00", nazwa_anonim == "23JA9vQNpe") %>% 
  count(czas) %>% 
  ggplot(aes(x=czas, y=n)) + geom_point()
  

