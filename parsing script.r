library(XML)
library(tidyverse)


#programmatically download the data — but need to check manually to get date

url_base <- "https://nasa-public-data.s3.amazonaws.com/iss-coords/"

#this is what needs to be updated
date <- "2021-09-23/"

#suffixes for all the pages
int1_suffix <- "ISS_sightings/XMLsightingData_citiesINT01.xml"
int2_suffix <- "ISS_sightings/XMLsightingData_citiesINT02.xml"
int3_suffix <- "ISS_sightings/XMLsightingData_citiesINT03.xml"
int4_suffix <- "ISS_sightings/XMLsightingData_citiesINT04.xml"
int5_suffix <- "ISS_sightings/XMLsightingData_citiesINT05.xml"

us1_suffix <- "ISS_sightings/XMLsightingData_citiesUSA01.xml"
us2_suffix <- "ISS_sightings/XMLsightingData_citiesUSA02.xml"
us3_suffix <- "ISS_sightings/XMLsightingData_citiesUSA03.xml"
us4_suffix <- "ISS_sightings/XMLsightingData_citiesUSA04.xml"
us5_suffix <- "ISS_sightings/XMLsightingData_citiesUSA05.xml"
us6_suffix <- "ISS_sightings/XMLsightingData_citiesUSA06.xml"
us7_suffix <- "ISS_sightings/XMLsightingData_citiesUSA07.xml"
us8_suffix <- "ISS_sightings/XMLsightingData_citiesUSA08.xml"
us9_suffix <- "ISS_sightings/XMLsightingData_citiesUSA09.xml"
us10_suffix <- "ISS_sightings/XMLsightingData_citiesUSA10.xml"
us11_suffix <- "ISS_sightings/XMLsightingData_citiesUSA11.xml"




#downloads
download.file(paste0(url_base, date, int1_suffix), "int_iss_data1.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, int2_suffix), "int_iss_data2.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, int3_suffix), "int_iss_data3.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, int4_suffix), "int_iss_data4.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, int5_suffix), "int_iss_data5.xml", method = "auto", quiet=FALSE)

download.file(paste0(url_base, date, us1_suffix), "us_iss_data1.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, us2_suffix), "us_iss_data2.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, us3_suffix), "us_iss_data3.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, us4_suffix), "us_iss_data4.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, us5_suffix), "us_iss_data5.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, us6_suffix), "us_iss_data6.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, us7_suffix), "us_iss_data7.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, us8_suffix), "us_iss_data8.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, us9_suffix), "us_iss_data9.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, us10_suffix), "us_iss_data10.xml", method = "auto", quiet=FALSE)
download.file(paste0(url_base, date, us11_suffix), "us_iss_data11.xml", method = "auto", quiet=FALSE)



# parse the downloaded files, both US and International


data1 <- xmlParse(file = "us_iss_data1.xml") 
data2 <- xmlParse(file = "us_iss_data2.xml") 
data3 <- xmlParse(file = "us_iss_data3.xml") 
data4 <- xmlParse(file = "us_iss_data4.xml") 
data5 <- xmlParse(file = "us_iss_data5.xml") 
data6 <- xmlParse(file = "us_iss_data6.xml") 
data7 <- xmlParse(file = "us_iss_data7.xml") 
data8 <- xmlParse(file = "us_iss_data8.xml") 
data9 <- xmlParse(file = "us_iss_data9.xml") 
data10 <- xmlParse(file = "us_iss_data10.xml") 
data11 <- xmlParse(file = "us_iss_data11.xml") 
int_data1 <- xmlParse(file = "int_iss_data1.xml") 
int_data2 <- xmlParse(file = "int_iss_data2.xml") 
int_data3 <- xmlParse(file = "int_iss_data3.xml") 
int_data4 <- xmlParse(file = "int_iss_data4.xml") 
int_data5 <- xmlParse(file = "int_iss_data5.xml") 



int_df1 <- xmlToDataFrame(int_data1) 
int_df2 <- xmlToDataFrame(int_data2) 
int_df3 <- xmlToDataFrame(int_data3) 
int_df4 <- xmlToDataFrame(int_data4) 
int_df5 <- xmlToDataFrame(int_data5) 

df1 <- xmlToDataFrame(data1) 
df2 <- xmlToDataFrame(data2) 
df3 <- xmlToDataFrame(data3) 
df4 <- xmlToDataFrame(data4) 
df5 <- xmlToDataFrame(data5) 
df6 <- xmlToDataFrame(data6) 
df7 <- xmlToDataFrame(data7) 
df8 <- xmlToDataFrame(data8) 
df9 <- xmlToDataFrame(data9) 
df10 <- xmlToDataFrame(data10) 
df11 <- xmlToDataFrame(data11) 



df <- rbind(df1,
            df2, 
            df3, 
            df4, 
            df5, 
            df6, 
            df7, 
            df8, 
            df9, 
            df10, 
            df11, 
           int_df1,
           int_df2,
           int_df3,
           int_df4,
           int_df5)

# recode a new var
df <- df %>%
    mutate(country_code = ifelse(country == "United_States", "US", 
                                      ifelse(country == "United_Kingdom", "GB",
                                            ifelse(country == "Canada", "CA", 
                                                  ifelse(country == "Australia", "AU", "ZZZ")))))

str(df)
head(df)

#rename some countries
df$country <- gsub("United_States", "United States", df$country)
df$country <- gsub("United_Kingdom", "Great Britain", df$country)
unique(df$country)

unique(df$region)

# unique(df$region)
# t1 <- df %>%
#     filter(country == "United_Kingdom")
# unique(t1$region)

#
# no longer needed because we made a table
#
# make a matching df of state names and abbs. DC is weird.
# states_table <- data.frame("region" = state.name, "state_code" = state.abb)
# states_table[nrow(states_table) + 1,] = c("DC","DC")

# str(states_table) 
# tail(states_table)
# write.csv(states_table, "us_and_int_matching_table.csv", row.names = FALSE)

# read in the matching table for cities and regions
matching_table <- read.csv("us_and_int_matching_table.csv", stringsAsFactors = FALSE)
str(matching_table)
tail(matching_table)
unique(matching_table$region)

#read in the NGC city list and filter to just newspages
ngc_cities_table <- read.csv("NGC_cities.csv", stringsAsFactors = FALSE)

ngc_cities_table_all <- ngc_cities_table %>%
    filter(has_newspage == 1)

#rename the col
ngc_cities_table_all <- rename(ngc_cities_table_all, country_code = country)

# recode a new var
ngc_cities_table_all <- ngc_cities_table_all %>%
    mutate(country = ifelse(country_code == "US", "United States", 
                                      ifelse(country_code == "GB", "Great Britain",
                                            ifelse(country_code == "CA", "Canada", 
                                                  ifelse(country_code == "AU", "Australia", "AAA")))))

str(ngc_cities_table_all)






# #make a US DF
# ngc_cities_table_us <- ngc_cities_table %>%
#     filter(has_newspage == 1 & country == "US")

# #make an INT DF for later
# ngc_cities_table_int <- ngc_cities_table %>%
#     filter(has_newspage == 1 & country != "US")

# str(ngc_cities_table_us)

# join df table with states_table to give df table the state_code
df_plus_state_code <- merge(df, matching_table)
str(df_plus_state_code)


unique(df_plus_state_code$region)


# join df_plus_state_code table with ngc_cities_table_all to get ngc stuff into the former
df_plus_ngc_info <- merge(df_plus_state_code, ngc_cities_table_all, by = c("city", "state_code", "country"))

head(df_plus_ngc_info)
str(df_plus_ngc_info)

#remove the underscores from city names, an artifact of joining the NASA and ND cities

df_plus_ngc_info$city <- str_replace_all(df_plus_ngc_info$city, "[_]", " ")

# "Santa Fe" %in% df_plus_ngc_info$city


# parse out the sighting_date field into weekday, month, day, time, and prettify time, and months

df_final <- df_plus_ngc_info
str(df_final)

df_final$weekday <- str_sub(df_final$sighting_date, 1,3)
df_final$month <- str_sub(df_final$sighting_date, 5,7)
df_final$day <- str_sub(df_final$sighting_date, 9,10)
df_final$time <- str_sub(df_final$sighting_date, 12,19)
df_final$time <- str_replace(df_final$time, "PM", "p.m.")
df_final$time <- str_replace(df_final$time, "AM", "a.m.")
df_final$day_night <- str_sub(df_final$time, 7,10)


# fix months
df_final$month <- str_replace(df_final$month, "Jan", "Jan.")
df_final$month <- str_replace(df_final$month, "Feb", "Feb.")
df_final$month <- str_replace(df_final$month, "Mar", "March")
df_final$month <- str_replace(df_final$month, "Apr", "April")
df_final$month <- str_replace(df_final$month, "Jun", "June")
df_final$month <- str_replace(df_final$month, "Jul", "July")
df_final$month <- str_replace(df_final$month, "Aug", "Aug.")
df_final$month <- str_replace(df_final$month, "Sep", "Sept.")
df_final$month <- str_replace(df_final$month, "Oct", "Oct.")
df_final$month <- str_replace(df_final$month, "Nov", "Nov.")
df_final$month <- str_replace(df_final$month, "Dec", "Dec.")


# strip leading 0's from times
df_final$time <- str_replace(df_final$time, "^0", "")

# strip leading 0's from days
df_final$day <- str_replace(df_final$day, "^0", "")



head(df_final)

# remove any > or < signs from the minutes and then convert the class

df_final$duration_minutes <- gsub('[<]', '', df_final$duration_minutes)

df_final$duration_minutes <- gsub('[>]', '', df_final$duration_minutes)

unique(df_final$duration_minutes)

df_final$duration_minutes <- as.integer(df_final$duration_minutes)


write.csv(df_final, "iss_pass_data_all.csv", row.names = FALSE)


