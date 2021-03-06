
# GSODR 1.0.1

## Major changes

## Minor changes
- Update documentation for `get_GSOD()` when using `station` parameter  
- Edit unit tests to enhance coverage  
- Edit paper.md for submission to JOSS  
- Remove extra packages listed as dependencies that are no longer necessary  

## Bug fixes

# GSODR 1.0.0

## Major changes

- The `get_GSOD()` function returns a `data.frame` object in the current R session with the option to save data to local disk  
- Multiple stations can be specified for download rather than just downloading a single station or all stations  
- A new function, `nearest_stations()` is now included to find stations within a user specified radius (in kilometres) of a point given as latitude and longitude in decimal degrees  
- A general use vignette is now included  
- New vignette with a detailed use-case  
- Output files now include fields for State (US only) and Call (International Civil Aviation Organization (ICAO) Airport Code)  
- Use FIPS codes in place of ISO3c for file name and in output files because some stations do not have an ISO country code  
- Spatial file output is now in GeoPackage format (GPKG). This results in a single file output unlike shapefile and allows for long field names  
- Users can specify file name of output  
- R >= 3.2.0 now required  
- Field names in output files use "\_" in place of "."  
- Long field names now used in file outputs  
- Country is specified using FIPS codes in file name and output file contents due to stations occurring in some locales that lack ISO 3166 3 letter country codes  
- The `get_GSOD()` function will retrieve the latest station data from NCDC and automatically merge it with the CGIAR-CSI SRTM elevation values provided by this package. Previously, the package provided it's own list of station information, which was difficult to keep up-to-date  
- A new `reformat_GSOD()` function reformats station files in "WMO-WBAN-YYYY.op.gz" format that have been downloaded from the United States
  National Climatic Data Center's (NCDC) FTP server.  
- A new function, `get_station_list()` allows for fetching latest station list from the FTP server and querying by the user for a specified station or location.  
- New data layers are provided through a separate package, [`GSODRdata`](https://github.com/adamhsparks/GSODRdata), which provide climate data formatted for use with GSODR. 
    - CHELSA (climatic surfaces at 1 km resolution), http://chelsa-climate.org/,
    - MODCF - Remotely sensed high-resolution global cloud dynamics for predicting ecosystem and biodiversity distributions (http://www.earthenv.org/cloud), 
    - ESACCI - ESA's CCI-LC snow cover probability (http://maps.elie.ucl.ac.be/CCI/viewer/index.php) and 
    - CRU CL2.0 (climatic surfaces at 10 minute resolution) (https://crudata.uea.ac.uk/%7Etimm/grid/CRU_CL_2_0.html)  
- Improved file handling for individual station downloads  
- Missing values are handled as `NA` not -9999  
- Change from GPL >= 3 to MIT licence to bring into line with ropensci packages  
- Now included in ropensci, [ropensci/GSODR](https://github.com/ropensci/GSODR)  
  
## Minor changes

- `get_GSOD()` function optimised for speed as best possible after FTPing files from NCDC server  
- All files are downloaded from server and then locally processed, previously these were sequentially downloaded by year and then processed  
- A progress bar is now shown when processing files locally after downloading  
- Reduced package dependencies  
- The `get_GSOD()` function now checks stations to see if the years being queried are provided and returns a message alerting user if the station and years requested are not available  
- When stations are specified for retrieval using the `station = ""` parameter, the `get_GSOD()` function now checks to see if the file exists on the server, if it does not, a message is returned and all other stations that have files are processed and returned in output  
- Documentation has been improved throughout package  
- Better testing of internal functions  
  
## Bug Fixes

- Fixed: Remove redundant code in `get_GSOD()` function  
- Fixed: The stations data frame distributed with the package now include stations that are located above 60 latitude and below -60 latitude  
  
## Deprecated and defunct

- Missing values are reported as NA for use in R, not -9999 as previously  
- The `path` parameter is now instead called `dsn` to be more inline with other tools like `readOGR()` and `writeOGR()`  
- Shapefile file out is no longer supported. Use GeoPackage (GPKG) instead  
- The option to remove stations with too many missing days is now optional, it now defaults to including all stations, the user must specify how many missing stations to check for an exclude.  
- The `max_missing` parameter is now user set, defaults to no check, return all stations regardless of missing days  


# GSODR 0.1.9 (Release Date: 2016-07-15)

## Bug Fixes

- Fix bug in precipitation calculation. Documentation states that PRCP is in mm to hundredths. Issues with conversion and missing values meant that this was not the case. Thanks to Gwenael Giboire for reporting and help with fixing this  

## Minor changes

- Users can now select to merge output for station queries across multiple years. Previously one year = one file per station. Now were set by user,
  `merge_station_years = TRUE` parameter, only one output file is generated  
- Country list is now included in the package to reduce run time necessary when querying for a specific country. However, this means any time that the
  country-list.txt file is updated, this package needs to be updated as well  
- Updated `stations` list with latest version from NCDC published 12-07-2016  

## Major changes

- Country level, agroclimatology and global data query conversions and calculations are processed in parallel now to reduce runtime  
- Improved documentation with spelling fixes, clarification and updates  
- Enable `ByteCompile` option upon installation for small increase in speed  
- Use `write.csv.raw` from `[iotools]("https://cran.r-project.org/web/packages/iotools/index.html")` to greatly improve runtime by decreasing time used to write CSV files to disk  
- Use `writeOGR()` from `rgdal`, in place of `raster's` `shapefile` to improve runtime by decreasing time used to write shapefiles to disk  


# GSODR 0.1.8.1 (Release Date: 2016-07-07)

## Minor changes

- Fix bug where no station is specified, function fails to run


# GSODR 0.1.8 (Release Date: 2016-07-04)

## Bug Fixes

- Fix bug with connection timing out for single station queries commit:  [a126641e00dc7acc21844ff0436e5702f8b6e04a](https://github.com/ropensci/GSODR/commit/a126641e00dc7acc21844ff0436e5702f8b6e04a)  
- Somehow the previously working function that checked country names broke with the `toupper()` function. A new [function from juba](http://stackoverflow.com/questions/16516593/convert-from-lowercase-to-uppercase-all-values-in-all-character-variables-in-dat)
  fixes this issue and users can now select country again  

## Major changes

- User entered values for a single station are now checked against actual station values for validity  
- stations.rda is compressed  
- stations.rda now includes a field for "corrected" elevation using hole-filled SRTM data from Jarvis et al. 2008, see
  [https://github.com/ropensci/GSODR/blob/devel/data-raw/fetch_isd-history.md](https://github.com/ropensci/GSODR/blob/devel/data-raw/fetch_isd-history.md) for a description  
- Set NA or missing values in CSV or shapefile to -9999 from -9999.99 to align with other data sources such as Worldclim


## Minor changes
- Documentation is more complete and easier to use  


# GSODR 0.1.7 (Release Date: 2016-06-02)

## Bug Fixes

- Fix issues with MIN/MAX where MIN referred to MAX [(Issue 5)](https://github.com/ropensci/GSODR/issues/5)  
- Fix bug where the `tf` item was incorrectly set as `tf <- "~/tmp/GSOD-2010.tar`, not `tf <- tempfile`, in `get_GSOD()` [(Issue 6)](https://github.com/ropensci/GSODR/issues/6)  
- CITATION file is updated and corrected  

## Minor changes

- User now has the ability to generate a shapefile as well as CSV file output [(Issue 3)](https://github.com/ropensci/GSODR/issues/3)  
- Documentation is more complete and easier to use  


# GSODR 0.1.6 (Release date: 2016-05-26)

## Bug Fixes

- Fix issue when reading .op files into R where temperature was incorrectly read causing negative values where T >= 100F, this issue caused RH values of >100% and incorrect TEMP values [(Issue 1)](https://github.com/ropensci/GSODR/issues/1)  
- Spelling corrections

## Major changes

- Include MIN/MAX flag column
- Station data is now included in package rather than downloading from NCDC every time get_GSOD() is run, this data has some corrections where stations with missing LAT/LON values or elevation are omitted, this is **not** the original complete station list provided by NCDC


# GSODR 0.1.5 (Release date: 2016-05-16)

## Bug Fixes

- Fixed bug where YDAY not correctly calculated and reported in CSV file
- CSV files for station only queries now are names with the Station Identifier. Previously named same as global data
- Likewise, CSV files for agroclimatology now are names with the Station Identifier. Previously named same as global data

## Minor Changes

- Set values where MIN > MAX to NA
- Set more MIN/MAX/DEWP values to NA. GSOD README indicates that 999 indicates missing values in these columns, this does not appear to always be true. There are instances where 99 is the value recorded for missing data. While 99F is possible, the vast majority of these recorded values are missing data, thus the function now converts them to NA


# GSODR 0.1.4 (Release date: 2016-05-09)

## Bug Fixes

- Fixed bug related to MIN/MAX columns when agroclimatology or all stations are selected where flags were not removed properly from numeric values.

## Minor Changes

- Add more detail to DESCRIPTION regarding flags found in original GSOD data.


# GSODR 0.1.3 (Release date: 2016-05-06)

## Bug fixes
- Bug fix in MIN/MAX with flags. Some columns have differing widths, which caused a flag to be left attached to some values
- Correct URL in README.md for CRAN to point to CRAN not GitHub

## Minor Changes
- Set NA to -9999.99


# GSODR 0.1.2 (Release date: 2016-05-05)

## Bug Fixes
- Bug fix in importing isd-history.csv file. Previous issues caused all lat/lon/elev values to be >0.
- Bug fix where WDSP was mistyped as WDPS causing the creation of a new column, rather than the conversion of the existing
- Bug fix if Agroclimatology selected. Previously this resulted in no records.
- Set the default encoding to UTF8.
- Bug fix for country selection. Some countries did not return proper ISO code.

## Minor changes

* Use write.csv, not readr::write_csv due to issue converting double to string: https://github.com/hadley/readr/issues/387


# GSODR 0.1.1 (Release date: 2016-04-21)

## Major changes

- Now available on CRAN
- Add single quotes around possibly misspelled words and spell out comma-separated values and geographic information system rather than just using "CSV" or "GIS" in DESCRIPTION.
- Add full name of GSOD (Global Surface Summary of the Day) and URL for GSOD, https://data.noaa.gov/dataset/global-surface-summary-of-the-day-gsod to DESCRIPTION as requested by CRAN.
- Require user to specify directory for resulting .csv file output so that any files written to disk are interactive and with user's permission


# GSODR 0.1 (Release date: 2016-04-18)

- Initial submission to CRAN
