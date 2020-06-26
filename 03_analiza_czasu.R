library(tidyverse)
library(lubridate)

load("data/logs_anonim.RData")

# tydzień przed pandemią

logs_anonim %>% 
  filter(czas >= "2020-03-09 00:00:00", czas <= "2020-03-15 23:59:00", nazwa_anonim != "ŁW") %>% 
  count(czas) %>% 
  ggplot(aes(x=czas, y=n)) + 
  geom_point(color = "#6daaee") +
  ylab("Liczba akcji") +
  ylim(0,50) +
  ggtitle("Składniki kursu wg liczby wyświetleń - powyżej 1000") +
  labs(caption = "Łukasz Wawrowski - wawrowski.edu.pl") +
  theme_light() +
  theme(plot.caption = element_text(color = "grey80"))
  
# tydzień w pandemi

logs_anonim %>% 
  filter(godz >= "2020-04-20 01:00:00", godz <= "2020-04-26 23:00:00", nazwa_anonim != "ŁW") %>% 
  count(czas) %>% 
  ggplot(aes(x=czas, y=n)) +
  geom_point(color = "#6daaee") +
  ylab("Liczba akcji") +
  ylim(0,20) +
  ggtitle("Składniki kursu wg liczby wyświetleń - powyżej 1000") +
  labs(caption = "Łukasz Wawrowski - wawrowski.edu.pl") +
  theme_light() +
  theme(plot.caption = element_text(color = "grey80"))

# cały semestr

logs_anonim %>% 
  filter(godz >= "2020-03-09 01:00:00", godz <= "2020-06-14 23:00:00", nazwa_anonim != "ŁW") %>% 
  count(czas) %>% 
  ggplot(aes(x=czas, y=n)) + geom_point()

# wybrany student 23JA9vQNpe

logs_anonim %>% 
  filter(godz >= "2020-03-09 01:00:00", godz <= "2020-06-23 23:00:00", nazwa_anonim == "23JA9vQNpe") %>% 
  count(czas) %>% 
  ggplot(aes(x=czas, y=n)) + geom_point()

# moje aktywności

akt_dzien <- logs_anonim %>% 
  filter(nazwa_anonim == "ŁW", godz >= "2020-03-09 01:00:00") %>% 
  mutate(dzien=ymd(format(round(czas, units="days"), format="%Y-%m-%d"))) %>% 
  count(dzien)

ggTimeSeries::ggplot_calendar_heatmap(dtDateValue = akt_dzien, cDateColumnName = "dzien", cValueColumnName = "n") +
  scale_fill_continuous(low = "#ffffbf", high = "#d73027") 
  
# studenci

akt_dzien <- logs_anonim %>% 
  filter(nazwa_anonim != "ŁW", czas >= "2020-03-09 00:00:00") %>% 
  mutate(dzien=ymd(format(round(czas, units="days"), format="%Y-%m-%d"))) %>% 
  count(dzien)

ggTimeSeries::ggplot_calendar_heatmap(dtDateValue = akt_dzien, cDateColumnName = "dzien", cValueColumnName = "n") +
  scale_fill_continuous(low = "#ffffbf", high = "#d73027") 

