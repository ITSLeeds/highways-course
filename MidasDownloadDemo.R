if (!require("pacman")) install.packages("pacman")
pacman::p_load(R.utils, 
               lubridate, 
               tidyr,
               dplyr, 
               stringr, 
               timeDate, 
               plyr, 
               data.table,
               chron,
               devtools,
               curl,
               usethis)

install_github("RACFoundation/oneminutetrafficdata")
library(oneminutetrafficdata)

# You save your HALOGEN username and password locally (not in the script)
# usethis::edit_r_environ()
# You may need to restart your R session

wd <- getwd()

# Set up download function
MIDASDownloader <- function(x,y) {
  date.df <- as.data.frame(seq(as.Date("1995/1/1"), as.Date(Sys.Date()+5000), "days"))
  colnames(date.df)[1] <- "Date"
  date.df$Date <- as.Date(date.df$Date)
  startdate <- x
  startdate <- as.Date(startdate)
  enddate <- y
  enddate <- as.Date(enddate)
  date.df <- subset(date.df, date.df$Date >= startdate & date.df$Date <= enddate)
  controloffice <- as.data.frame(c("79", "70", "60", "50", "40", "30", "20", "10"))
  colnames(controloffice)[1] <- "CO"
  months <- as.data.frame(c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
  colnames(months)[1] <- "Month"
  months$number <- row(months)
  days <- as.data.frame(c("01", "02", "03", "04", "05", "06", "07", 
                          "08", "09", "10", "11", "12", "13", "14", 
                          "15", "16", "17", "18", "19", "20", "21", 
                          "22", "23", "24", "25", "26", "27", "28", 
                          "29", "30", "31" ))
  colnames(days)[1] <- "Day_lz"
  days$Day <- row(days)
  Username <- Sys.getenv("MIDASUN")
  Password <- Sys.getenv("MIDASPW")
  date.df$number <- month(date.df$Date)
  date.df <- join(date.df, months)
  date.df$Day <- day(date.df$Date)
  date.df <- join(date.df, days)
  colnames(days)[1] <- "Month_lz"
  colnames(days)[2] <- "Month_num"
  date.df$Month_num <- month(date.df$Date)
  date.df <- join(date.df, days)
  date.df$no_dash <- paste0(date.df$Day_lz, date.df$Month_lz, (year(date.df$Date)-2000))
  mfl.list <- basename(list.files(pattern = ".mfl.bz2$", recursive = TRUE))
  mal.list <- basename(list.files(pattern = ".mal.bz2$", recursive = TRUE))
  tcd.list <- basename(list.files(pattern = ".tcd.bz2$", recursive = TRUE))
  mfl.list2 <- basename(list.files(pattern = ".mfl$", recursive = TRUE))
  mal.list2 <- basename(list.files(pattern = ".mal$", recursive = TRUE))
  tcd.list2 <- basename(list.files(pattern = ".tcd$", recursive = TRUE))
  mfl.list <- c(mfl.list, mfl.list2)
  mal.list <- c(mal.list, mfl.list2)
  tcd.list <- c(tcd.list, tcd.list2)
  try(
    for(j in 1:nrow(controloffice)){
      for(i in 1:nrow(date.df)){
        myurl <- paste0("https://www.midas-data.org.uk/midasdata/Trafdata/Co", controloffice$CO[j], "/", year(date.df$Date)[i], "/", date.df$Month[i], "/", controloffice$CO[j], date.df$no_dash[i], ".tcd.bz2")
        myurl <- myurl[1]
        ifelse(paste0(controloffice$CO[j], date.df$no_dash[i], ".tcd.bz2") %in% tcd.list |
                 paste0(controloffice$CO[j], date.df$no_dash[i], ".tcd") %in% tcd.list,
               print("already downloaded"),
               R.utils::bunzip2(downloadFile(myurl, paste0(wd,"/TCDs/", controloffice$CO[j], date.df$no_dash[i], ".tcd.bz2"), username = Username, password = Password)))
        myurl <- paste0("https://www.midas-data.org.uk/midasdata/Oplog/Co", controloffice$CO[j], "/", year(date.df$Date)[i], "/", date.df$Month[i], "/", controloffice$CO[j], date.df$no_dash[i], ".mfl.bz2")
        myurl <- myurl[1]
        ifelse(paste0(controloffice$CO[j], date.df$no_dash[i], ".mfl.bz2") %in% mfl.list |
                 paste0(controloffice$CO[j], date.df$no_dash[i], ".mfl") %in% mfl.list, 
               print("already downloaded"),
               downloadFile(myurl, paste0(wd,"/Logs/", controloffice$CO[j], date.df$no_dash[i], ".mfl.bz2"), username = Username, password = Password))
        myurl <- paste0("https://www.midas-data.org.uk/midasdata/Alertlog/Co", controloffice$CO[j], "/", year(date.df$Date)[i], "/", date.df$Month[i], "/", controloffice$CO[j], date.df$no_dash[i], ".mal.bz2")
        myurl <- myurl[1]
        ifelse(paste0(controloffice$CO[j], date.df$no_dash[i], ".mal.bz2") %in% mal.list |
                 paste0(controloffice$CO[j], date.df$no_dash[i], ".mal") %in% mal.list, 
               print("already downloaded"),
               downloadFile(myurl, paste0(wd,"/Logs/", controloffice$CO[j], date.df$no_dash[i], ".mal.bz2"), username = Username, password = Password))
        percentleft <- (i/nrow(date.df))/nrow(controloffice) + ((j-1)/nrow(controloffice))
        print(percentleft*100)
      }
    }
  )
  
}

startdate <- "2017-12-01"
enddate <- "2017-12-07"

# Download SRN data
MIDASDownloader(startdate, enddate)

# Read MIDAS data
linkofinterest <- c("M621/1133A",
                    "M621/1023B",
                    "M621/1002A",
                    "M621/1132B",
                    "M621/1018B")

allSiteData <- RoadData(as.character(startdate), as.character(enddate), "TCDs", linkofinterest)

# "RoadData" provides a list containing each site's detail.
# To access a particular site's details, select it from the list like so:
allSiteData  <- allSiteData[[1]]
allSites <- plyr::rbind.fill.matrix(allSiteData)
# You can link logs to the speed/flow data:
Linkdata <- LogDetails(allSites, "Logs")
# What state is each lane under at each minute?:
Linkdata <- VMSDetails(Linkdata, "Logs")

write.csv(Linkdata, "test.csv")
