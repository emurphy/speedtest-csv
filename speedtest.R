laptop_csv <- 'speedtest-laptop-wifi.csv'
desktop_csv <- 'speedtest-desktop-cable.csv'
laptop_df <- read.csv(laptop_csv, header=FALSE)
desktop_df <- read.csv(desktop_csv, header=FALSE)
names(laptop_df) = c("datetime_str", "bytes_per_second")
names(desktop_df) = c("datetime_str", "bytes_per_second")

library(dplyr)
speed_laptop <- mutate(laptop_df, mbits_per_second = bytes_per_second * 8 / 1000000, system="laptop wifi")
speed_laptop <- transform(speed_laptop, datetime=strptime(datetime_str, "%b %d %H:%M:%S "))
speed_desktop <- mutate(desktop_df, mbits_per_second = bytes_per_second * 8 / 1000000, system="desktop cable")
speed_desktop <- transform(speed_desktop, datetime=strptime(datetime_str, "%b %d %H:%M:%S "))

speed <- rbind(speed_laptop, speed_desktop)

library(ggplot2)
png("speedtest.png", width=1000, height=700)
g <- ggplot(speed, aes(x=datetime, y=mbits_per_second, group=system, color=system))
g + geom_line()
dev.off()

png("speedtest-side-by-side.png", width=1000, height=700)
grid <- ggplot(speed, aes(x=datetime, y=mbits_per_second))
grid + facet_grid(. ~ system) + geom_line()
dev.off()

png("speedtest-boxplot.png", width=1000, height=700)
box <- ggplot(speed, aes(factor(system), mbits_per_second))
box + geom_boxplot()
dev.off()

