
# Step 0: Download and unzip the data file.
## 0.1 Check whether working directory has 'exdata-016' folder
## Trivia: 'exdata-016' is the 'Exploratory Data Analysis' course which I have enrolled in =)
if(!file.exists("./exdata-016")){dir.create("./exdata-016")}
if(!file.exists("./exdata-016/Course Project 1")){dir.create("./exdata-016/Course Project 1")}

## 0.2 Check whether the data set exists/was previously downloaded.
if(!file.exists("./exdata-016/Course Project 1/household_power_consumption.zip")){
        fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "./exdata-016/Course Project 1/household_power_consumption.zip")
}

## 0.3 Unzip the downloaded file.
unzip("./exdata-016/Course Project 1/household_power_consumption.zip",
      exdir = "./exdata-016/Course Project 1/temp", setTimes = TRUE)


# Step 1: Importing the data set.
print("Please wait a moment!")

## 1.1
specific_days <- grep(("^[1-2]/2/2007"), readLines("./exdata-016/Course Project 1/temp/household_power_consumption.txt"))

desired_rows <- read.table("./exdata-016/Course Project 1/temp/household_power_consumption.txt",
                           header = FALSE, sep = ";",
                           skip = (specific_days[1] - 1), nrows = length(specific_days),
                           na.strings = "?")

## 1.2  Handling Column names
household_sample <- read.table("./exdata-016/Course Project 1/temp/household_power_consumption.txt",
                               header = TRUE, sep = ";", nrow = 5, na.strings = "?")
colnames(desired_rows) <- paste(colnames(household_sample))



# Step 2: Handling Date and Time
desired_rows$Date <- as.Date(desired_rows$Date, "%d/%m/%Y")

desired_rows$Date.Time <- with(desired_rows, paste(Date, Time, sep=" "))

desired_rows$Date.Time <- strptime(desired_rows$Date.Time, "%Y-%m-%d %H:%M:%S", tz = "UTC")


# Step 3: Plots

# =======
## Plot 2

plot(desired_rows$Date.Time, desired_rows$Global_active_power,
     type="l", xlab ="", ylab = "Global Active Power (kilowatts)", cex = 0.6)


dev.copy(png, file = "./exdata-016/Course Project 1/plot2.png",
         width = 480, height = 480, units = "px")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!



# Extra steps

# Step 4. Extra step: The unziped data set takes up to 126 MB of your disk storage.
## It's time to clean up the mess!
unlink("./exdata-016/Course Project 1/temp", recursive = TRUE, force = TRUE)

# Step 5. Extra step: Notification about the downloaded data set!
print(c("For your future references, the downloaded data set file is in '/exdata-016/Course Project 1' folder of your working directory:", getwd()))
print("You can find the result of this R script (plot2.png) in the above mentioned folder.")

# Step 6. Extra Step: This script has created a number of varibales which are now in your R workspace.
## To keep things running smoothly after you test this script, It's better to remove them =)
## Credit goes to the author of 'SWIRL' package who inspired me for this tweak =)
rm(list=ls())
