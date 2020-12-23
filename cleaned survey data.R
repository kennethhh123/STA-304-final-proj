# Workspace set-up

install.packages("devtools")
devtools::install_github("hodgettsp/cesR")
library("tidyverse")

# Import the survey data

suppressWarnings(suppressMessages(library("cesR")))
get_ces("ces2019_web")

# Data manipulation

survey_data <- ces2019_web %>% mutate(sex = case_when(cps19_gender == 1 ~ "Male",
                                                         cps19_gender == 2 ~ "Female",
                                                         cps19_gender == 3 ~ "Other"),
                                      age = cps19_age,
                                      health = case_when(pes19_health == 1 ~ "Excellent",
                                                         pes19_health == 2 ~ "Very good",
                                                         pes19_health == 3 ~ "Fair",
                                                         pes19_health == 4 ~ "Poor",
                                                         pes19_health == 5 ~ "Other"),
                                      province = case_when(pes19_province == 1 ~ "AB",
                                                           pes19_province == 2 ~ "BC",
                                                           pes19_province == 3 ~ "MB",
                                                           pes19_province == 4 ~ "NB",
                                                           pes19_province == 5 ~ "NL",
                                                           pes19_province == 6 ~ "NT",
                                                           pes19_province == 7 ~ "NS",
                                                           pes19_province == 8 ~ "NU",
                                                           pes19_province == 9 ~ "ON",
                                                           pes19_province == 10 ~ "PE",
                                                           pes19_province == 11 ~ "QC",
                                                           pes19_province == 12 ~ "SK",
                                                           pes19_province == 13 ~ "YT"),
                                      vote_party = ifelse(cps19_votechoice == 1,1,0))


survey_data <- survey_data %>% filter(province != "NT" &
                                        province != "NU" &
                                        province != "YT")



# Output cleaned survey data
write_csv(survey_data, "survey_data.csv")

