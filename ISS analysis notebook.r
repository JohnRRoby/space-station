library(tidyverse)
library(lubridate)


df_master <- read.csv("iss_pass_data_all.csv", stringsAsFactors = FALSE)

df_master <- filter(df_master, spacecraft == "ISS")
str(df_master)
head(df_master)

#pre-filter on p.m.
df_master <- filter(df_master, day_night == "p.m.")
str(df_master)

#check the countries and define a function to summarize numbers in coming days 

unique(df_master$country_code.x)

passes_sum <- function(country_code){
    output <- df_master %>%
    filter(country_code.x == country_code) %>%
    group_by(month, day) %>%
    summarize(
    passes = n()
        ) %>%
    arrange(desc(passes))
    return(output)
    
}

#define the country to browse
country_code <- "GB"

#fire the function
upcoming_passes <- passes_sum(country_code)
upcoming_passes 

#define the browse function

station_browse <- function(month_choice, day_choice, minimum_minutes_choice, minimum_elevation_choice, country_choice, day_night_choice){
    
    candidates <- filter(df_master, month == month_choice &
              day == day_choice &
              duration_minutes >= minimum_minutes_choice &
              max_elevation >= minimum_elevation_choice & country_code.x == country_choice 
                         & day_night == day_night_choice)
    return(candidates)
}

#define the throttle function

set_throttle <- function(no_of_days){
    throt <- read.csv("comment_photo_video_count.csv", stringsAsFactors = FALSE)
    throt$creation_date <- ymd_hms(throt$creation_date)
    throt$today_date <- ymd_hms(Sys.time())
    throt$time_from_last_post <- throt$today_date - throt$creation_date
    throt_filtered <- throt %>%
    filter(time_from_last_post < no_of_days)

`%notin%` <- Negate(`%in%`)

throt_filtered <- subset(browsing, city %notin% throt_filtered$city)

return(throt_filtered)
    
}

# set the query parameters and then fire it

my_month <- "July"
my_day <-  25
my_minutes <- 4
my_elevation <- 40
my_country <- "GB"
my_day_night <- "p.m."

browsing <- station_browse(my_month, my_day, my_minutes, my_elevation, my_country, my_day_night)
print(paste0("This df has ", nrow(browsing), " rows."), quote = FALSE)
print(paste0("Minutes range from ", min(browsing$duration_minutes), " to ", max(browsing$duration_minutes), "."), quote = FALSE)
print(paste0("Elevation ranges from ", min(browsing$max_elevation), " degrees to ", max(browsing$max_elevation), " degrees."), quote = FALSE)
print(paste0("Date ranges from ", min(browsing$month), " ",  min(browsing$day), " to ", max(browsing$month), " ", max(browsing$day), "."), quote = FALSE)
print(paste0("The start times are: "), quote = FALSE)
unique(browsing$time)
print(paste0("The cities are in the following states: "), quote = FALSE)
unique(browsing$state_code)
print(paste0("The writes could reach ", format(sum(browsing$verified_members), big.mark = ","), " members."), quote = FALSE)
browsing <- browsing %>% arrange(desc(verified_members))


final <- set_throttle(31)
print(paste0("This df has ", nrow(final), " rows."), quote = FALSE)
print(paste0("Minutes range from ", min(final$duration_minutes), " to ", max(final$duration_minutes), "."), quote = FALSE)
print(paste0("Elevation ranges from ", min(final$max_elevation), " degrees to ", max(final$max_elevation), " degrees."), quote = FALSE)
print(paste0("Date ranges from ", min(final$month), " ",  min(final$day), " to ", max(final$month), " ", max(final$day), "."), quote = FALSE)
print(paste0("The start times are: "), quote = FALSE)
unique(final$time)
print(paste0("The cities are in the following states: "), quote = FALSE)
unique(final$state_code)
print(paste0("The writes could reach ", format(sum(final$verified_members), big.mark = ","), " members."), quote = FALSE)
final <- final %>% arrange(desc(verified_members))
head(final)


"London" %in% final$city

# manipulate the enters and exits. gotta do it three times because the directions 

final$enters_pretty <- str_replace_all(final$enters, 
    c("above" = "degrees above the", 
      "NNE" = "north-northeastern",
      "ENE" = "east-northeastern",
      "ESE" = "east-southeastern",
      "SSE" = "south-southeastern",
      "SSW" = "south-southwestern",
      "WSW" = "west-southwestern", 
     "WNW" = "west-northwestern",
      "NNW" = "north-northwestern"      
     ))

final$enters_pretty <- str_replace_all(final$enters_pretty, 
    c("NE" = "northeastern",
      "SE" = "southeastern",
      "SW" = "southwestern",
      "NW" = "northwestern"
     ))

final$enters_pretty <- str_replace_all(final$enters_pretty, 
    c("N" = "northern",
      "E" = "eastern",
      "S" = "southwestern",
      "W" = "western"
     ))


final$exits_pretty <- str_replace_all(final$exits, 
    c("above" = "degrees above the", 
      "NNE" = "north-northeastern",
      "ENE" = "east-northeastern",
      "ESE" = "east-southeastern",
      "SSE" = "south-southeastern",
      "SSW" = "south-southwestern",
      "WSW" = "west-southwestern", 
     "WNW" = "west-northwestern",
      "NNW" = "north-northwestern"      
     ))

final$exits_pretty <- str_replace_all(final$exits_pretty, 
    c("NE" = "northeastern",
      "SE" = "southeastern",
      "SW" = "southwestern",
      "NW" = "northwestern"
     ))

final$exits_pretty <- str_replace_all(final$exits_pretty, 
    c("N" = "northern",
      "E" = "eastern",
      "S" = "southwestern",
      "W" = "western"
     ))




head(final)
str(final)

#filter out weird too late times — this may vary by country! Currently set to times starting at 6, 7, 8 or 9 pm

final$time_start <- substr(final$time, 1, 1)
final <- filter(final, time_start == "6" | time_start == "7" | time_start == "8" | time_start == "9")
# final <- filter(final, time_start == "6" | time_start == "7" | time_start == "8" | time_start == "9" | time_start == "1" )
str(final)


# filter out cities (in states) with dodgy cloud cover, predicted here: https://maps.darksky.net/@cloud_cover

final_clouds_filtered <- final

#here list the states where clouds are predicted to be bad
cloudy_states <- c("AZ",
                   "NM",
                   "UT",
                   "CO",
                   "KS",
                   "NE",
                   "IA",
                   "MN",
                   "WI",
                   "AL",
                   "FL",
                   "GA",
                   "TN",
                   "OH"
)

`%notin%` <- Negate(`%in%`)


final_clouds_filtered <- subset(final_clouds_filtered, final_clouds_filtered$state_code %notin% cloudy_states)
str(final_clouds_filtered)
unique(final_clouds_filtered$state_code)



# rename the column `state_code` to `state` so this plays nice with VK's notebook

final_clouds_filtered <- rename(final_clouds_filtered, state = state_code)
str(final_clouds_filtered)

# enter the run date
run_date <- "07-14"


#export
write.csv(final_clouds_filtered, paste0("df_for_jinja_ISS_US_", run_date, ".csv"), row.names = FALSE)



