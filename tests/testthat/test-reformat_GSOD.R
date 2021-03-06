
# Check that reformat_GSOD functions properly ----------------------------------
context("reformat_GSOD")
file.remove(file.path(tempdir(), list.files(tempdir(), pattern = ".op.gz$"))) 
test_that("reformat_GSOD file_list parameter reformats data properly", {
  skip_on_cran()
  
  ftp_base <- "ftp://ftp.ncdc.noaa.gov/pub/data/gsod/1960/"
  test_files <- c("066000-99999-1960.op.gz", "066200-99999-1960.op.gz",
                  "066700-99999-1960.op.gz", "066800-99999-1960.op.gz")
  dest <- tempdir()
  destinations <- paste0(dest, "/", test_files)
  
  Map(function(u, d) download.file(u, d, mode = "wb"),
      paste0(ftp_base, test_files), destinations)
  
  y <- list.files(dest, pattern = ".op.gz$", full.names = TRUE)
  x <- reformat_GSOD(file_list = y)
  expect_equal(nrow(x), 1454)
  expect_equal(ncol(x), 48)
  expect_type(x, "list")
  unlink(destinations)
})

test_that("reformat_GSOD dsn parameter reformats data properly", {
  skip_on_cran()
  
  file.remove(file.path(tempdir(), list.files(tempdir(), pattern = ".op.gz$"))) 
  ftp_base <- "ftp://ftp.ncdc.noaa.gov/pub/data/gsod/1960/"
  test_files <- c("066000-99999-1960.op.gz", "066200-99999-1960.op.gz",
                  "066700-99999-1960.op.gz", "066800-99999-1960.op.gz")
  dest <- tempdir()
  destinations <- paste0(dest, "/", test_files)
  
  Map(function(u, d) download.file(u, d, mode = "wb"),
      paste0(ftp_base, test_files), destinations)

  x <- reformat_GSOD(dsn = dest)
  expect_equal(nrow(x), 1454)
  expect_equal(ncol(x), 48)
  expect_type(x, "list")
  unlink(destinations)
})
