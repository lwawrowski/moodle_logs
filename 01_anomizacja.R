library(tidyverse)
library(lubridate)

logs <- read_csv("data/logs.csv") %>% 
  janitor::clean_names() %>% 
  select(czas, pelna_nazwa, kontekst_zdarzenia, skladnik, adres_ip) %>% 
  mutate(czas = dmy_hm(czas),
         godz = ymd_hm(format(round(czas, units="hours"), format="%Y-%m-%d %H:%M"))) %>% 
  filter(czas > "2020-02-24 01:00:00") %>% # tylko dane z nowego semestru
  filter(pelna_nazwa != "-") # usunięcie automatu frekwencji

users <- logs %>% 
  distinct(pelna_nazwa) %>% 
  mutate(nazwa_anonim=ifelse(pelna_nazwa == "Łukasz Wawrowski","ŁW",stringi::stri_rand_strings(nrow(.),10)))

logs_anonim <- left_join(logs, users) %>% 
  select(-pelna_nazwa)

save(logs_anonim, file = "data/logs_anonim.RData")