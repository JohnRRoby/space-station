# space-station
Scripts to parse xml, and format and output a table for NGC

There are two scripts. The parsing script draws data from this link (search 'ISS'): https://nasa.github.io/data-nasa-gov-frontpage/#:~:text=DATA.NASA.GOV%20is%20NASA's,on%20data.nasa.gov

some inspiration and help from here: https://www.geeksforgeeks.org/working-with-xml-files-in-r-programming/

The parsing script results in object `iss_pass_data_all.csv` that is passed to the analysis script.     

The analysis script reads in object `iss_pass_data_all.csv`.     


