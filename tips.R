?time
current_time2 = Sys.time()
?as.POSIXct
birth_time = as.POSIXct("1985-12-16 12:00")
unclass(birth_time)
current_time - birth_time
difftime(current_time, birth_time, units = "s")

birth_time = lubridate::ymd_h("19851226 12")





