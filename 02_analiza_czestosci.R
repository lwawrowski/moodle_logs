library(tidyverse)

load("data/logs_anonim.RData")

# skladnik

logs_anonim %>% 
  count(skladnik) %>% 
  arrange(n) %>% 
  filter(n > 1000) %>% 
  mutate(skladnik=fct_reorder(skladnik,n)) %>% 
  ggplot(aes(x=skladnik, y=n)) + 
  geom_col() + 
  coord_flip()

# adres_ip

top10_ip <- logs_anonim %>% 
  count(adres_ip) %>% 
  arrange(desc(n)) %>% 
  top_n(10,n)

logs_ip <- logs_anonim %>% 
  filter(adres_ip %in% top10_ip$adres_ip)

logs_ip %>% 
  count(nazwa_anonim)

# nazwa

logs_nazwa <- logs_anonim %>% 
  count(nazwa_anonim) %>% 
  arrange(desc(n))

# nazwa ip

logs_nazwa_ip <- logs_anonim %>% 
  count(nazwa_anonim, adres_ip) %>% 
  count(nazwa_anonim)

# zasób

logs_kontekst <- logs_anonim %>% 
  count(kontekst_zdarzenia) %>% 
  arrange(desc(n))