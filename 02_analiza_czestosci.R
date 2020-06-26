library(tidyverse)
library(ggrepel)

load("data/logs_anonim.RData")

# skladnik

logs_anonim %>% 
  filter(nazwa_anonim != "ŁW") %>% 
  count(skladnik) %>% 
  arrange(n) %>% 
  filter(n > 1000) %>% 
  mutate(skladnik=fct_reorder(skladnik,n)) %>% 
  ggplot(aes(x=skladnik, y=n)) + 
  geom_col(fill = "#6daaee") + 
  geom_text(aes(label = n), hjust = 1.1) +
  xlab("Liczba wyświetleń") +
  ylab("Typ składnika kursu") +
  coord_flip() +
  ggtitle("Typ składnika kursu wg liczby wyświetleń - powyżej 1000") +
  labs(caption = "Łukasz Wawrowski - wawrowski.edu.pl") +
  theme_light() +
  theme(plot.caption = element_text(color = "grey80"))

# zasób

logs_anonim %>% 
  filter(kontekst_zdarzenia != "Kurs: Statystyka - stacj. I st. - RiFP - (lab.) - dr Łukasz Wawrowski") %>% 
  count(kontekst_zdarzenia) %>% 
  mutate(kontekst_zdarzenia=gsub(" - quiz", "", kontekst_zdarzenia)) %>% 
  filter(n > 1000) %>% 
  mutate(kontekst_zdarzenia=fct_reorder(kontekst_zdarzenia,n)) %>% 
  ggplot(aes(x=kontekst_zdarzenia, y=n)) + 
  geom_col(fill = "#6daaee") + 
  geom_text(aes(label = n), hjust = 1.1) +
  xlab("Liczba wyświetleń") +
  ylab("Składnik kursu") +
  coord_flip() +
  ggtitle("Składniki kursu wg liczby wyświetleń - powyżej 1000") +
  labs(caption = "Łukasz Wawrowski - wawrowski.edu.pl") +
  theme_light() +
  theme(plot.caption = element_text(color = "grey80"))

# adresy URL

logs_anonim %>% 
  filter(grepl("Adres URL:", kontekst_zdarzenia)) %>% 
  mutate(kontekst_zdarzenia=gsub("Adres URL: ", "", kontekst_zdarzenia)) %>% 
  count(kontekst_zdarzenia) %>% 
  mutate(kontekst_zdarzenia=fct_reorder(kontekst_zdarzenia,n)) %>% 
  ggplot(aes(x=kontekst_zdarzenia, y=n)) + 
  geom_col(fill = "#6daaee") + 
  geom_text(aes(label = n), hjust = 1.1) +
  xlab("Liczba wyświetleń") +
  ylab("Składnik kursu") +
  coord_flip() +
  ggtitle("Adresy URL wg liczby wyświetleń") +
  labs(caption = "Łukasz Wawrowski - wawrowski.edu.pl") +
  theme_light() +
  theme(plot.caption = element_text(color = "grey80"))
  

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
