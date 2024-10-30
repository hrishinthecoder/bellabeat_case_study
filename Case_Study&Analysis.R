# Loading the Data
daily_activity <- read_csv("dailyActivity_merged.csv")
sleep_data <- read_csv("sleepDay_merged.csv")

# Getting An Overview of the Dataset
head(daily_activity)
colnames(daily_activity)
head(sleep_data)
colnames(sleep_data)

#Understanding some summary statistics
summary(daily_activity)
summary(sleep_data)
n_distinct(daily_activity$Id)
n_distinct(sleep_data$Id)
nrow(daily_activity)
nrow(sleep_data)

# Quick summary statistics of some columns

daily_activity %>%
  select(TotalSteps,
         TotalDistance,
         SedentaryMinutes)%>%
  summary()

sleep_data%>%
  select(TotalSleepRecords,
         TotalMinutesAsleep,
         TotalTimeInBed)%>%
  summary()


# Doing the Analysis

# Visualization 01
ggplot(data = daily_activity,aes(x = TotalSteps, y=SedentaryMinutes)) + 
  geom_point()
#visualization 02
ggplot(data=sleep_data, aes(x = TotalMinutesAsleep, y= TotalTimeInBed)) + 
  geom_point()

# visualization 03
ggplot(daily_activity, aes(x = TotalSteps, y = Calories)) +
  geom_point(alpha = 0.5, color = "blue") +
  labs(title = "Total Steps vs. Calories Burned",
       x = "Total Steps",
       y = "Calories Burned") +
  theme_minimal()

# visualization 04

# Convert SleepDay to Date type
sleep_data$SleepDay <- as.Date(sleep_data$SleepDay, format="%m/%d/%Y %I:%M:%S %p")

# Line chart
ggplot(sleep_data, aes(x = SleepDay)) +
  geom_line(aes(y = TotalTimeInBed, color = "Total Time in Bed")) +
  geom_line(aes(y = TotalMinutesAsleep, color = "Total Minutes Asleep")) +
  labs(title = "Total Time in Bed vs. Total Minutes Asleep",
       x = "Date",
       y = "Minutes") +
  scale_color_manual("", values = c("Total Time in Bed" = "red", "Total Minutes Asleep" = "green")) +
  theme_minimal()

# Visualization 05

# Convert ActivityDate to Date and extract day of the week
daily_activity$ActivityDate <- as.Date(daily_activity$ActivityDate, format="%m/%d/%Y")
daily_activity$DayOfWeek <- weekdays(daily_activity$ActivityDate)

# Calculate average calories per day
avg_calories <- aggregate(Calories ~ DayOfWeek, daily_activity, mean)

# Reorder days for plotting
avg_calories$DayOfWeek <- factor(avg_calories$DayOfWeek, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

# Bar chart
ggplot(avg_calories, aes(x = DayOfWeek, y = Calories)) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(title = "Average Calories Burned by Day of the Week",
       x = "Day of the Week",
       y = "Average Calories Burned") +
  theme_minimal()


# Downloading the combined datasets
combined_dataset <- merge(daily_activity,sleep_day, by ="Id")
nrow(combined_dataset)
