
<!-- README.md is generated from README.Rmd. Please edit that file -->
GSODR: Global Summary Daily Weather Data in R
=============================================

[![Travis-CI Build
Status](https://travis-ci.org/ropensci/GSODR.svg?branch=master)](https://travis-ci.org/ropensci/GSODR)
[![Build
status](https://ci.appveyor.com/api/projects/status/s09kh2nj59o35ob1/branch/master?svg=true)](https://ci.appveyor.com/project/ropensci/gsodr/branch/master)
[![codecov](https://codecov.io/gh/ropensci/GSODR/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/GSODR)
[![rstudio mirror
downloads](http://cranlogs.r-pkg.org/badges/GSODR?color=blue)](https://github.com/metacran/cranlogs.app)
[![rstudio mirror
downloads](http://cranlogs.r-pkg.org/badges/grand-total/GSODR?color=blue)](https://github.com/metacran/cranlogs.app)
[![cran
version](http://www.r-pkg.org/badges/version/GSODR)](https://cran.r-project.org/package=GSODR)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.252817.svg)](https://doi.org/10.5281/zenodo.252817)
[![Research software
impact](http://depsy.org/api/package/cran/GSODR/badge.svg)](http://depsy.org/package/r/GSODR)

Introduction to GSODR
=====================

The GSOD or [Global Surface Summary of the Day
(GSOD)](https://data.noaa.gov/dataset/global-surface-summary-of-the-day-gsod)
data provided by the US National Climatic Data Center (NCDC) are a
valuable source of weather data with global coverage. However, the data
files are cumbersome and difficult to work with. The GSODR package aims
to make it easy to find, transfer and format the data you need for use
in analysis. The GSODR package provides four main functions for
facilitating this:

-   `get_GSOD()` - queries and transfers files from the FTP server,
    reformats them and returns a `data.frame()` object in R session or
    saves a file to disk with options for a GeoPackage spatially enabled
    file or comma separated values (CSV) file,  
-   `reformat_GSOD()` - the workhorse, takes individual station files on
    the local disk and reformats them, returns a `data.frame()` object
    in R session or saves a file to disk with options for a GeoPackage
    spatially enabled file or comma separated values (CSV) file,  
-   `nearest_stations()` - returns a `vector()` object containing a list
    of stations and their metadata that fall within the given radius of
    a point specified by the user,  
-   `get_station_list()` - downloads the latest station list from the
    NCDC FTP server and returns a `data.table()` object in R session.

When reformatting data either with `get_GSOD()` or `reformat_GSOD()`,
all units are converted to International System of Units (SI), e.g.,
inches to millimetres and Fahrenheit to Celsius. File output can be
saved as a Comma Separated Value (CSV) file or in a spatial GeoPackage
(GPKG) file, implemented by most major GIS software, summarising each
year by station, which also includes vapour pressure and relative
humidity variables calculated from existing data in GSOD.

Additional data are calculated by this R package using the original data
and included in the final data. These include vapour pressure (ea and
es) and relative humidity.

It is recommended that you have a good Internet connection to download
the data files as they can be quite large and slow to download.

For more information see the description of the data provided by NCDC,
<http://www7.ncdc.noaa.gov/CDO/GSOD_DESC.txt>.

Other Sources of Weather Data
-----------------------------

There are several other sources of weather data and ways of retrieving
them through R. In particular, the excellent
[rnoaa](https://CRAN.R-project.org/package=rnoaa) package from
[ROpenSci](https://ropensci.org) offers tools for interacting with and
downloading weather data from the United States National Oceanic and
Atmospheric Administration but lacks support GSOD data.

Quick Start
===========

Install
-------

### Stable version

A stable version of GSODR is available from
[CRAN](https://cran.r-project.org/package=GSODR).

``` r
install.packages("GSODR")
```

### Development version

A development version is available from from GitHub. If you wish to
install the development version that may have new features (but also may
not work properly), install the [devtools
package](https://CRAN.R-project.org/package=devtools), available from
CRAN. We strive to keep the master branch on GitHub functional and
working properly, although this may not always happen.

If you find bugs, please file a [report as an
issue](https://github.com/ropensci/GSODR/issues).

``` r
#install.packages("devtools")
devtools::install_github("ropensci/GSODR", build_vignettes = TRUE)
```

------------------------------------------------------------------------

Final data format and contents
------------------------------

The `GSODR` package returns data with the following fields/units.

-   **STNID** - Station number (WMO/DATSAV3 number) for the location;

-   **WBAN** - number where applicable--this is the historical "Weather
    Bureau Air Force Navy" number - with WBAN being the acronym;

-   **STN\_NAME** - Unique text identifier;

-   **CTRY** - Country in which the station is located;

-   **LAT** - Latitude. *Station dropped in cases where values are &lt;
    -90 or &gt; 90 degrees or Lat = 0 and Lon = 0*;

-   **LON** - Longitude. *Station dropped in cases where values are &lt;
    -180 or &gt; 180 degrees or Lat = 0 and Lon = 0*;

-   **ELEV\_M** - Elevation in metres;

-   **ELEV\_M\_SRTM\_90m** - Elevation in metres corrected for possible
    errors, derived from the CGIAR-CSI SRTM 90m database (Jarvis et al.
    2008);

-   **YEARMODA** - Date in YYYY-mm-dd format;

-   **YEAR** - The year (YYYY);

-   **MONTH** - The month (mm);

-   **DAY** - The day (dd);

-   **YDAY** - Sequential day of year (not in original GSOD);

-   **TEMP** - Mean daily temperature converted to degrees C to tenths.
    Missing = NA;

-   **TEMP\_CNT** - Number of observations used in calculating mean
    daily temperature;

-   **DEWP** - Mean daily dew point converted to degrees C to tenths.
    Missing = NA;

-   **DEWP\_CNT** - Number of observations used in calculating mean
    daily dew point;

-   **SLP** - Mean sea level pressure in millibars to tenths. Missing =
    NA;

-   **SLP\_CNT** - Number of observations used in calculating mean sea
    level pressure;

-   **STP** - Mean station pressure for the day in millibars to tenths.
    Missing = NA;

-   **STP\_CNT** - Number of observations used in calculating mean
    station pressure;

-   **VISIB** - Mean visibility for the day converted to kilometres to
    tenths Missing = NA;

-   **VISIB\_CNT** - Number of observations used in calculating mean
    daily visibility;

-   **WDSP** - Mean daily wind speed value converted to metres/second to
    tenths Missing = NA;

-   **WDSP\_CNT** - Number of observations used in calculating mean
    daily wind speed;

-   **MXSPD** - Maximum sustained wind speed reported for the day
    converted to metres/second to tenths. Missing = NA;

-   **GUST** - Maximum wind gust reported for the day converted to
    metres/second to tenths. Missing = NA;

-   **MAX** - Maximum temperature reported during the day converted to
    Celsius to tenths--time of max temp report varies by country and
    region, so this will sometimes not be the max for the calendar day.
    Missing = NA;

-   **MAX\_FLAG** - Blank indicates max temp was taken from the explicit
    max temp report and not from the 'hourly' data. An "\*" indicates
    max temp was derived from the hourly data (i.e., highest hourly or
    synoptic-reported temperature);

-   **MIN** - Minimum temperature reported during the day converted to
    Celsius to tenths--time of min temp report varies by country and
    region, so this will sometimes not be the max for the calendar day.
    Missing = NA;

-   **MIN\_FLAG** - Blank indicates max temp was taken from the explicit
    min temp report and not from the 'hourly' data. An "\*" indicates
    min temp was derived from the hourly data (i.e., highest hourly or
    synoptic-reported temperature);

-   **PRCP** - Total precipitation (rain and/or melted snow) reported
    during the day converted to millimetres to hundredths; will usually
    not end with the midnight observation, i.e., may include latter part
    of previous day. A value of ".00" indicates no measurable
    precipitation (includes a trace). Missing = NA; *Note: Many stations
    do not report '0' on days with no precipitation-- therefore, 'NA'
    will often appear on these days. For example, a station may only
    report a 6-hour amount for the period during which rain fell.* See
    FLAGS\_PRCP column for source of data;

-   **PRCP\_FLAG** -

    -   A = 1 report of 6-hour precipitation amount;

    -   B = Summation of 2 reports of 6-hour precipitation amount;

    -   C = Summation of 3 reports of 6-hour precipitation amount;

    -   D = Summation of 4 reports of 6-hour precipitation amount;

    -   E = 1 report of 12-hour precipitation amount;

    -   F = Summation of 2 reports of 12-hour precipitation amount;

    -   G = 1 report of 24-hour precipitation amount;

    -   H = Station reported '0' as the amount for the day (e.g., from
        6-hour reports), but also reported at least one occurrence of
        precipitation in hourly observations--this could indicate a
        rrace occurred, but should be considered as incomplete data for
        the day;

    -   I = Station did not report any precipitation data for the day
        and did not report any occurrences of precipitation in its
        hourly observations--it's still possible that precipitation
        occurred but was not reported;

-   **SNDP** - Snow depth in millimetres to tenths. Missing = NA;

-   **I\_FOG** - Indicator for fog, (1 = yes, 0 = no/not reported) for
    the occurrence during the day;

-   **I\_RAIN\_DRIZZLE** - Indicator for rain or drizzle, (1 = yes, 0 =
    no/not reported) for the occurrence during the day;

-   **I\_SNOW\_ICE** - Indicator for snow or ice pellets, (1 = yes, 0 =
    no/not reported) for the occurrence during the day;

-   **I\_HAIL** - Indicator for hail, (1 = yes, 0 = no/not reported) for
    the occurrence during the day;

-   **I\_THUNDER** - Indicator for thunder, (1 = yes, 0 = no/not
    reported) for the occurrence during the day;

-   **I\_TORNADO\_FUNNEL** - Indicator for tornado or funnel cloud, (1 =
    yes, 0 = no/not reported) for the occurrence during the day;

-   **ea** - Mean daily actual vapour pressure;

-   **es** - Mean daily saturation vapour pressure;

-   **RH** - Mean daily relative humidity.

Using GSODR
-----------

### Query the NCDC FTP server for GSOD data

GSODR's main function, `get_GSOD()`, downloads and cleans GSOD data from
the NCDC server. Following are a few examples of its capabilities.

#### Example 1 - Download weather station data for Toowoomba, Queensland for 2010

``` r
library(GSODR)

Tbar <- get_GSOD(years = 2010, station = "955510-99999")
#> 
#> Checking requested station file for availability on server.
#> Starting data file processing
#> 
  |                                                                       
  |                                                                 |   0%
  |                                                                       
  |=================================================================| 100%

head(Tbar)
#>    WBAN        STNID          STN_NAME CTRY STATE CALL    LAT     LON
#> 1 99999 955510-99999 TOOWOOMBA AIRPORT   AS  <NA> <NA> -27.55 151.917
#> 2 99999 955510-99999 TOOWOOMBA AIRPORT   AS  <NA> <NA> -27.55 151.917
#> 3 99999 955510-99999 TOOWOOMBA AIRPORT   AS  <NA> <NA> -27.55 151.917
#> 4 99999 955510-99999 TOOWOOMBA AIRPORT   AS  <NA> <NA> -27.55 151.917
#> 5 99999 955510-99999 TOOWOOMBA AIRPORT   AS  <NA> <NA> -27.55 151.917
#> 6 99999 955510-99999 TOOWOOMBA AIRPORT   AS  <NA> <NA> -27.55 151.917
#>   ELEV_M ELEV_M_SRTM_90m    BEGIN      END YEARMODA YEAR MONTH DAY YDAY
#> 1    642             635 19980301 20161122 20100101 2010    01  01    1
#> 2    642             635 19980301 20161122 20100102 2010    01  02    2
#> 3    642             635 19980301 20161122 20100103 2010    01  03    3
#> 4    642             635 19980301 20161122 20100104 2010    01  04    4
#> 5    642             635 19980301 20161122 20100105 2010    01  05    5
#> 6    642             635 19980301 20161122 20100106 2010    01  06    6
#>   TEMP TEMP_CNT DEWP DEWP_CNT    SLP SLP_CNT   STP STP_CNT VISIB VISIB_CNT
#> 1 21.2        8 17.9        8 1013.4       8 942.0       8    NA         0
#> 2 23.2        8 19.4        8 1010.5       8 939.3       8    NA         0
#> 3 21.4        8 18.9        8 1012.3       8 940.9       8  14.3         6
#> 4 18.9        8 16.4        8 1015.7       8 944.1       8  23.3         4
#> 5 20.5        8 16.4        8 1015.5       8 944.0       8    NA         0
#> 6 21.9        8 18.7        8 1013.7       8 942.3       8    NA         0
#>   WDSP WDSP_CNT MXSPD GUST   MAX MAX_FLAG   MIN MIN_FLAG PRCP PRCP_FLAG
#> 1  2.2        8   6.7   NA 25.78          17.78           1.5         G
#> 2  1.9        8   5.1   NA 26.50          19.11           0.3         G
#> 3  3.9        8  10.3   NA 28.72          19.28        * 19.8         G
#> 4  4.5        8  10.3   NA 24.11          16.89        *  1.0         G
#> 5  3.9        8  10.8   NA 24.61          16.72           0.3         G
#> 6  3.2        8   7.7   NA 26.78          17.50           0.0         G
#>   SNDP I_FOG I_RAIN_DRIZZLE I_SNOW_ICE I_HAIL I_THUNDER I_TORNADO_FUNNEL
#> 1   NA     0              0          0      0         0                0
#> 2   NA     0              0          0      0         0                0
#> 3   NA     1              1          0      0         0                0
#> 4   NA     0              0          0      0         0                0
#> 5   NA     0              0          0      0         0                0
#> 6   NA     1              0          0      0         0                0
#>    EA  ES   RH
#> 1 2.1 2.5 84.0
#> 2 2.3 2.8 82.1
#> 3 2.2 2.5 88.0
#> 4 1.9 2.2 86.4
#> 5 1.9 2.4 79.2
#> 6 2.2 2.6 84.6
```

#### Example 2 - Download GSOD data and generate agroclimatology files

For years 2010 and 2011, download data and create the files,
GSOD-agroclimatology-2010.csv and GSOD-agroclimatology-2011.csv, in the
user's home directory with a maximum of five missing days per weather
station allowed.

``` r
get_GSOD(years = 2010:2011, dsn = "~/", filename = "GSOD-agroclimatology",
         agroclimatology = TRUE, CSV = TRUE, max_missing = 5)
```

#### Example 3 - Download and plot data for a single country

Download data for Philippines for year 2010 and generate a spatial, year
summary file, PHL-2010.gpkg, in the user's home directory.

``` r
get_GSOD(years = 2010, country = "Philippines", dsn = "~/",
         filename = "PHL-2010", GPKG = TRUE, max_missing = 5)
```

``` r
#install.packages("spacetime")
#install.packages("plotKML")

library(rgdal)
#> Loading required package: sp
#> rgdal: version: 1.2-4, (SVN revision 643)
#>  Geospatial Data Abstraction Library extensions to R successfully loaded
#>  Loaded GDAL runtime: GDAL 1.11.5, released 2016/07/01
#>  Path to GDAL shared files: /usr/local/Cellar/gdal/1.11.5_1/share/gdal
#>  Loaded PROJ.4 runtime: Rel. 4.9.3, 15 August 2016, [PJ_VERSION: 493]
#>  Path to PROJ.4 shared files: (autodetected)
#>  Linking to sp version: 1.2-3
library(spacetime)
library(plotKML)
#> plotKML version 0.5-6 (2016-05-02)
#> URL: http://plotkml.r-forge.r-project.org/

layers <- ogrListLayers(dsn = path.expand("~/PHL-2010.gpkg"))
pnts <- readOGR(dsn = path.expand("~/PHL-2010.gpkg"), layers[1])
#> OGR data source with driver: GPKG 
#> Source: "/Users/U8004755/PHL-2010.gpkg", layer: "GSOD"
#> with 4703 features
#> It has 46 fields

# Plot results in Google Earth as a spacetime object:
pnts$DATE = as.Date(paste(pnts$YEAR, pnts$MONTH, pnts$DAY, sep = "-"))
row.names(pnts) <- paste("point", 1:nrow(pnts), sep = "")

tmp_ST <- STIDF(sp = as(pnts, "SpatialPoints"),
                time = pnts$DATE - 0.5,
                data = pnts@data[, c("TEMP", "STNID")],
                endTime = pnts$DATE + 0.5)

shape = "http://maps.google.com/mapfiles/kml/pal2/icon18.png"

kml(tmp_ST, dtime = 24 * 3600, colour = TEMP, shape = shape, labels = TEMP,
    file.name = "Temperatures_PHL_2010-2010.kml", folder.name = "TEMP")
#> KML file opened for writing...
#> Writing to KML...
#> Closing  Temperatures_PHL_2010-2010.kml

system("zip -m Temperatures_PHL_2010-2010.kmz Temperatures_PHL_2010-2010.kml")
```

#### Example 4 - Working with climate data from GSODRdata

This example will demonstrate how to download data for Philippines for
year 2010 and generate a spatial, year summary file, PHL-2010.gpkg, in
the user's home directory and link it with climate data from the
`GSODRdata` package.

##### Install `GSODRdata` package

This package is only available from GitHub; due to its large size (5.5Mb
installed) it is not allowed on CRAN. It provides optional data for use
with the `GSODR` package. See <https://github.com/adamhsparks/GSODRdata>
for more.

``` r
# install.packages("devtools")
devtools::install_github("adamhsparks/GSODdata")
```

##### Working with climate data from `GSODRdata`

Now that the extra data have been installed, take a look at the CHELSA
data that are one of the data sets included in the `GSODRdata` package.

CHELSA (Climatologies at high resolution for the earth’s land surface
areas) are climate data at (30 arc sec) for the earth land surface
areas.

**Description of CHELSA data from CHELSA website**

> CHELSA is a high resolution (30 arc sec) climate data set for the
> earth land surface areas currently under development in coorporation
> with the Department of Geography of the University of Hamburg (Prof.
> Dr. Jürgen Böhner, Dr. Olaf Conrad, Tobias Kawohl), the Swiss Federal
> Institute for Forest, Snow and Landscape Research WSL (Prof. Dr.
> Niklaus Zimmermann), the University of Zurich (Dr. Dirk N. Karger, Dr.
> Michael Kessler), and the University of Göttingen (Prof. Dr. Holger
> Kreft). It includes monthly mean temperature and precipitation
> patterns for the time period 1979-2013. CHELSA is based on a
> quasi-mechanistical statistical downscaling of the ERA interim global
> circulation model
> (<http://www.ecmwf.int/en/research/climate-reanalysis/era-interim>)
> with a GPCC bias correction
> (<https://www.dwd.de/EN/ourservices/gpcc/gpcc.html>) and is freely
> available in the download section.

See <http://chelsa-climate.org> for more information on these data.

Compare the GSOD weather data from the Philippines with climatic data
provided by the GSODR package in the `CHELSA` data set.

``` r
library(GSODRdata)

head(CHELSA)
```

``` r
##          STNID    LON    LAT CHELSA_bio10_1979-2013_V1_1 CHELSA_bio11_1979-2013_V1_1 CHELSA_bio1_1979-2013_V1_1
## 1 008268-99999 65.567 32.950                        30.0                         5.8                       18.3
## 2 010014-99999  5.341 59.792                        14.3                         1.0                        7.1
## 3 010015-99999  5.867 61.383                        12.5                        -3.2                        4.2
## 4 010882-99999 11.342 62.578                        12.6                        -7.0                        2.3
## 5 010883-99999  6.117 61.833                        15.2                        -0.2                        7.0
## 6 010884-99999  9.567 59.185                        16.3                        -2.2                        6.6
##   CHELSA_bio12_1979-2013_V1_1 CHELSA_bio13_1979-2013_V1_1 CHELSA_bio14_1979-2013_V1_1 CHELSA_bio15_1979-2013_V1_1
## 1                       214.0                        54.6                         0.1                       104.9
## 2                      1889.3                       223.7                        87.7                        30.3
## 3                      2209.1                       254.7                       108.9                        30.1
## 4                       563.0                        73.0                        26.7                        30.7
## 5                      1710.3                       200.6                        78.5                        32.1
## 6                       987.0                       120.9                        52.3                        24.4
##   CHELSA_bio16_1979-2013_V1_1 CHELSA_bio17_1979-2013_V1_1 CHELSA_bio18_1979-2013_V1_1 CHELSA_bio19_1979-2013_V1_1
## 1                       155.4                         0.6                         1.7                        96.9
## 2                       650.7                       273.5                       433.3                       490.4
## 3                       752.8                       332.6                       448.3                       621.1
## 4                       216.2                        85.5                       198.7                       122.0
## 5                       590.0                       244.7                       330.9                       494.4
## 6                       338.0                       175.3                       242.3                       182.7
##   CHELSA_bio2_1979-2013_V1_1 CHELSA_bio3_1979-2013_V1_1 CHELSA_bio4_1979-2013_V1_1 CHELSA_bio5_1979-2013_V1_1
## 1                       23.0                       48.3                      884.1                       40.5
## 2                       12.5                       44.8                      486.3                       21.5
## 3                       16.7                       45.3                      591.5                       22.2
## 4                       20.1                       45.5                      734.1                       23.6
## 5                       15.6                       45.0                      573.4                       23.9
## 6                       17.1                       44.3                      693.1                       25.4
##   CHELSA_bio6_1979-2013_V1_1 CHELSA_bio7_1979-2013_V1_1 CHELSA_bio8_1979-2013_V1_1 CHELSA_bio9_1979-2013_V1_1 CHELSA_prec_10_1979-2013
## 1                       -7.2                       47.7                       10.5                       26.7                      3.6
## 2                       -6.5                       28.0                        5.7                        7.8                    230.6
## 3                      -14.5                       36.8                       -1.7                        8.4                    237.5
## 4                      -20.7                       44.3                       12.5                       -0.1                     48.9
## 5                      -10.7                       34.7                        1.3                       12.2                    192.8
## 6                      -13.3                       38.7                        8.5                        3.8                    122.1
##   CHELSA_prec_11_1979-2013 CHELSA_prec_1_1979-2013 CHELSA_prec_12_1979-2013 CHELSA_prec_1979-2013_land CHELSA_prec_2_1979-2013
## 1                     10.5                    35.8                     25.4                      214.5                    46.5
## 2                    219.9                   198.4                    215.5                     1912.0                   153.3
## 3                    237.8                   227.7                    248.3                     2170.2                   188.4
## 4                     41.3                    40.3                     40.5                      559.3                    32.5
## 5                    189.6                   189.5                    201.5                     1719.6                   153.7
## 6                    106.2                    79.0                     82.4                      998.1                    53.0
##  CHELSA_prec_3_1979-2013 CHELSA_prec_4_1979-2013 CHELSA_prec_5_1979-2013 CHELSA_prec_6_1979-2013 CHELSA_prec_7_1979-2013
## 1                    54.8                    28.3                     7.0                     1.2                     1.0
## 2                   151.9                   101.1                    90.6                   100.5                   116.7
## 3                   176.4                   114.4                   107.0                   110.1                   119.2
## 4                    31.8                    26.6                    38.9                    58.0                    69.7
## 5                   145.0                    91.6                    79.0                    84.0                    90.1
## 6                    63.7                    57.0                    72.1                    76.1                    84.3
##   CHELSA_prec_8_1979-2013 CHELSA_prec_9_1979-2013 CHELSA_temp_10_1979-2013 CHELSA_temp_11_1979-2013 CHELSA_temp_1_1979-2013
## 1                     0.3                     0.1                     19.2                     13.2                     4.9
## 2                   165.6                   204.0                      8.0                      4.5                     1.2
## 3                   159.6                   229.6                      4.3                      0.2                    -3.4
## 4                    72.7                    57.9                      2.3                     -3.0                    -7.2
## 5                   121.6                   181.4                      7.2                      3.0                    -0.4
## 6                   105.0                    97.2                      6.7                      2.2                    -2.4
##   CHELSA_temp_12_1979-2013 CHELSA_temp_1979-2013_land CHELSA_temp_2_1979-2013 CHELSA_temp_3_1979-2013 CHELSA_temp_4_1979-2013
## 1                      7.7                       18.3                     7.0                    12.2                    18.3
## 2                      2.1                        7.1                     0.8                     2.3                     5.1
## 3                     -2.7                        4.1                    -3.2                    -0.8                     3.0
## 4                     -6.5                        2.3                    -6.6                    -3.3                     1.5
## 5                      0.3                        6.9                    -0.2                     2.2                     5.8
## 6                     -1.4                        6.5                    -2.2                     0.8                     5.1
##   CHELSA_temp_5_1979-2013 CHELSA_temp_6_1979-2013 CHELSA_temp_7_1979-2013 CHELSA_temp_8_1979-2013 ## CHELSA_temp_9_1979-2013
## 1                    23.5                    28.2                    28.2                    29.7                    25.1
## 2                     9.0                    12.0                    12.0                    14.2                    11.5
## 3                     7.6                    10.9                    10.9                    12.2                     8.6
## 4                     6.4                    10.9                    10.9                    12.1                     7.7
## 5                    10.1                    13.2                    13.2                    14.9                    11.5
## 6                    10.7                    14.7                    14.7                    15.8                    11.6
```

##### Using `dplyr` functions, join the CHELSA and GSODR data for plotting.

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(ggplot2)
library(reshape2)

cnames <- paste0("CHELSA_temp_", 1:12, "_1979-2013")
clim_temp <- CHELSA[CHELSA$STNID %in% pnts$STNID,
                       paste(c("STNID", cnames))]
clim_temp_df <- data.frame(STNID = rep(clim_temp$STNID, 12),
                           MONTHC = as.vector(sapply(1:12, rep,
                                                    times = nrow(clim_temp))), 
                           CHELSA_TEMP = as.vector(unlist(clim_temp[, cnames])))

pnts$MONTHC <- as.numeric(paste(pnts$MONTH))
temp <- left_join(pnts@data, clim_temp_df, by = c("STNID", "MONTHC"))
#> Warning in left_join_impl(x, y, by$x, by$y, suffix$x, suffix$y): joining
#> factors with different levels, coercing to character vector

temp <- temp %>% 
  group_by(MONTH) %>% 
  mutate(AVG_DAILY_TEMP = round(mean(TEMP), 1))

df_melt <- na.omit(melt(temp[, c("STNID", "DATE", "CHELSA_TEMP", "TEMP", "AVG_DAILY_TEMP")],
                        id = c("DATE", "STNID")))

ggplot(df_melt, aes(x = DATE, y = value)) +
  geom_point(aes(color = variable), alpha = 0.2) +
  scale_x_date(date_labels = "%b") +
  ylab("Temperature (C)") +
  xlab("Month") +
  labs(colour = "") +
  scale_color_brewer(palette = "Dark2") +
  facet_wrap( ~ STNID)
```

![Comparison of GSOD daily values and average monthly values with CHELSA
climate monthly values](README-example_3.2-1.png)

#### Example 5 - Finding stations within a given radius of a point

Using the `nearest_station()` function will return a list of stations in
the GSOD data set that are within a specified radius (kilometres) of a
given point expressed as latitude and longitude in decimal degrees
\[WGS84\].

``` r
# Find stations within 50km of Toowoomba, QLD.

n <- nearest_stations(LAT = -27.5598, LON = 151.9507, distance = 50)

n
[1] "945510-99999" "945520-99999" "945620-99999" "949999-00170" "949999-00183" "955510-99999"

toowoomba <- get_GSOD(years = 2015, station = n)

#> This station, 945510-99999, only provides data for years 1956 to 2012.

#> This station, 949999-00170, only provides data for years 1971 to 1984.

#> This station, 949999-00183, only provides data for years 1983 to 1984.

#> Checking requested station file for availability on server.

#> Downloading individual station files.

|=============================================================================================================================|100% ~0 s remaining     
Starting data file processing
  |=============================================================================================================================================| 100%

str(toowoomba)

#> 'data.frame':    1094 obs. of  47 variables:
#> $ WBAN            : chr  "99999" "99999" "99999" "99999" ...
#> $ STNID           : chr  "945520-99999" "945520-99999" "945520-99999" "945520-99999" ...
#> $ STN_NAME        : chr  "OAKEY" "OAKEY" "OAKEY" "OAKEY" ...
#> $ CTRY            : chr  "AS" "AS" "AS" "AS" ...
#> $ STATE           : chr  NA NA NA NA ...
#> $ CALL            : chr  "YBOK" "YBOK" "YBOK" "YBOK" ...
#> $ LAT             : num  -27.4 -27.4 -27.4 -27.4 -27.4 ...
#> $ LON             : num  152 152 152 152 152 ...
#> $ ELEV_M          : num  407 407 407 407 407 ...
#> $ ELEV_M_SRTM_90m : num  404 404 404 404 404 404 404 404 404 404 ...
#> $ BEGIN           : num  19730430 19730430 19730430 19730430 19730430 ...
#> $ END             : num  20170111 20170111 20170111 20170111 20170111 ...
#> $ YEARMODA        : chr  "20150101" "20150102" "20150103" "20150104" ...
#> $ YEAR            : chr  "2015" "2015" "2015" "2015" ...
#> $ MONTH           : chr  "01" "01" "01" "01" ...
#> $ DAY             : chr  "01" "02" "03" "04" ...
#> $ YDAY            : num  1 2 3 4 5 6 7 8 9 10 ...
#> $ TEMP            : num  24.9 24.3 22.3 23 22.5 22.6 21.8 22.6 24.6 24.9 ...
#> $ TEMP_CNT        : int  24 24 24 24 24 24 24 24 24 24 ...
#> $ DEWP            : num  18.4 18.2 17.4 16.3 17.7 14.3 15.7 16.4 16.4 16.4 ...
#> $ DEWP_CNT        : int  24 24 24 24 24 24 24 24 24 24 ...
#> $ SLP             : num  1014 1017 1017 1014 1015 ...
#> $ SLP_CNT         : int  16 16 16 16 16 16 16 16 16 16 ...
#> $ STP             : num  968 971 971 969 969 ...
#> $ STP_CNT         : int  16 16 16 16 16 16 16 16 16 16 ...
#> $ VISIB           : num  10 10 10 10 10 10 NA NA 10 NA ...
#> $ VISIB_CNT       : int  8 8 4 5 7 4 0 0 4 0 ...
#> $ WDSP            : num  2.3 2.8 2.8 2.3 3 3.5 3.1 2.5 2.9 2.7 ...
#> $ WDSP_CNT        : int  24 24 24 24 24 24 24 24 24 24 ...
#> $ MXSPD           : num  8.2 9.8 10.3 7.2 9.8 9.8 9.8 8.8 8.2 8.2 ...
#> $ GUST            : num  NA NA NA NA NA NA NA NA NA 12.4 ...
#> $ MAX             : num  31.8 31 27.3 29.3 27.6 ...
#> $ MAX_FLAG        : chr  "" "" "" "" ...
#> $ MIN             : num  18.9 18.2 17.7 16.8 16.4 ...
#> $ MIN_FLAG        : chr  "*" "" "*" "*" ...
#> $ PRCP            : num  0 0 0 0 0 0 0 0 0 0 ...
#> $ PRCP_FLAG       : chr  "G" "G" "G" "G" ...
#> $ SNDP            : num  NA NA NA NA NA NA NA NA NA NA ...
#> $ I_FOG           : int  0 0 0 0 0 0 0 0 0 0 ...
#> $ I_RAIN_DRIZZLE  : int  0 0 0 0 0 0 0 0 0 0 ...
#> $ I_SNOW_ICE      : int  0 0 0 0 0 0 0 0 0 0 ...
#> $ I_HAIL          : int  0 0 0 0 0 0 0 0 0 0 ...
#> $ I_THUNDER       : int  0 0 0 0 0 0 0 0 0 0 ...
#> $ I_TORNADO_FUNNEL: int  0 0 0 0 0 0 0 0 0 0 ...
#> $ EA              : num  2.1 2.1 2 1.9 2 1.6 1.8 1.9 1.9 1.9 ...
#> $ ES              : num  3.1 3 2.7 2.8 2.7 2.7 2.6 2.7 3.1 3.1 ...
#> $ RH              : num  67.7 70 74.1 67.9 74.1 59.3 69.2 70.4 61.3 61.3 ...
```

Notes
=====

Data Sources
------------

#### CHELSA climate layers

CHELSA (climatic surfaces at 1 km resolution) is based on a
quasi-mechanistical statistical downscaling of the ERA interim global
circulation model (Karger et al. 2016). ESA's CCI-LC cloud probability
monthly averages are based on the MODIS snow products (MOD10A2).
<http://chelsa-climate.org/>

#### EarthEnv MODIS cloud fraction

<http://www.earthenv.org/cloud>

#### ESA's CCI-LC cloud probability

<http://maps.elie.ucl.ac.be/CCI/viewer/index.php>

#### Elevation Values

90m hole-filled SRTM digital elevation (Jarvis *et al.* 2008) was used
to identify and correct/remove elevation errors in data for station
locations between -60˚ and 60˚ latitude. This applies to cases here
where elevation was missing in the reported values as well. In case the
station reported an elevation and the DEM does not, the station reported
is taken. For stations beyond -60˚ and 60˚ latitude, the values are
station reported values in every instance. See
<https://github.com/ropensci/GSODR/blob/devel/data-raw/fetch_isd-history.md>
for more detail on the correction methods.

WMO Resolution 40. NOAA Policy
------------------------------

*Users of these data should take into account the following (from the
[NCDC
website](http://www7.ncdc.noaa.gov/CDO/cdoselect.cmd?datasetabbv=GSOD&countryabbv=&georegionabbv=)):*

> "The following data and products may have conditions placed on their
> international commercial use. They can be used within the U.S. or for
> non-commercial international activities without restriction. The
> non-U.S. data cannot be redistributed for commercial purposes.
> Re-distribution of these data by others must provide this same
> notification." [WMO Resolution 40. NOAA
> Policy](https://public.wmo.int/en/our-mandate/what-we-do/data-exchange-and-technology-transfer)

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.

References
==========

Jarvis, A., Reuter, H. I., Nelson, A., Guevara, E. (2008) Hole-filled
SRTM for the globe Version 4, available from the CGIAR-CSI SRTM 90m
Database (<http://srtm.csi.cgiar.org>)

Karger, D. N., Conrad, O., Bohner, J., Kawohl, T., Kreft, H.,
Soria-Auza, R. W., *et al*. (2016) Climatologies at high resolution for
the Earth land surface areas. *arXiv preprint* **arXiv:1607.00217**.
(<http://chelsa-climate.org/>)

[![ropensci\_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
