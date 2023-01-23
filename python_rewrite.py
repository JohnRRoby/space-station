
This script grabs data from NASA's ISS passing site. The R script takes over then.

Issue is page has to be checked manually, no API.

top page (search 'ISS'): https://nasa.github.io/data-nasa-gov-frontpage/#:~:text=DATA.NASA.GOV%20is%20NASA%27s,on%20data.nasa.gov

# set the URL base
url_base = "https://nasa-public-data.s3.amazonaws.com/iss-coords/"

# set the date, note the necessary slash for date assembly  -- this has to be checked manually but maybe could fix that?
date = "2022-01-03/"

print(date)
2022-01-03/
# set suffixes for the URLs

int1_suffix = "ISS_sightings/XMLsightingData_citiesINT01.xml"
int2_suffix = "ISS_sightings/XMLsightingData_citiesINT02.xml"
int3_suffix = "ISS_sightings/XMLsightingData_citiesINT03.xml"
int4_suffix = "ISS_sightings/XMLsightingData_citiesINT04.xml"
int5_suffix = "ISS_sightings/XMLsightingData_citiesINT05.xml"

us1_suffix = "ISS_sightings/XMLsightingData_citiesUSA01.xml"
us2_suffix = "ISS_sightings/XMLsightingData_citiesUSA02.xml"
us3_suffix = "ISS_sightings/XMLsightingData_citiesUSA03.xml"
us4_suffix = "ISS_sightings/XMLsightingData_citiesUSA04.xml"
us5_suffix = "ISS_sightings/XMLsightingData_citiesUSA05.xml"
us6_suffix = "ISS_sightings/XMLsightingData_citiesUSA06.xml"
us7_suffix = "ISS_sightings/XMLsightingData_citiesUSA07.xml"
us8_suffix = "ISS_sightings/XMLsightingData_citiesUSA08.xml"
us9_suffix = "ISS_sightings/XMLsightingData_citiesUSA09.xml"
us10_suffix = "ISS_sightings/XMLsightingData_citiesUSA10.xml"
us11_suffix = "ISS_sightings/XMLsightingData_citiesUSA11.xml"
import os
mydir = os.getcwd() # set working dir for use in wget.download()

import wget # for downloading files from web
# download them 

# int cities
wget.download((url_base + date + int1_suffix), mydir) 
wget.download((url_base + date + int2_suffix), mydir) 
wget.download((url_base + date + int3_suffix), mydir) 
wget.download((url_base + date + int4_suffix), mydir) 
wget.download((url_base + date + int5_suffix), mydir) 

# us cities
wget.download((url_base + date + us1_suffix), mydir) 
wget.download((url_base + date + us2_suffix), mydir) 
wget.download((url_base + date + us3_suffix), mydir) 
wget.download((url_base + date + us4_suffix), mydir) 
wget.download((url_base + date + us5_suffix), mydir) 
wget.download((url_base + date + us6_suffix), mydir) 
wget.download((url_base + date + us7_suffix), mydir) 
wget.download((url_base + date + us8_suffix), mydir) 
wget.download((url_base + date + us9_suffix), mydir) 
wget.download((url_base + date + us10_suffix), mydir) 
wget.download((url_base + date + us11_suffix), mydir) 
'/Users/jroby/Documents/editorial/Rprojects/iss xml work/XMLsightingData_citiesUSA11.xml'
 
 
