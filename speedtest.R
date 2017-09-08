csv <- 'speedtest-cable-to-2017-09-07.csv'
df <- read.csv(csv, header=FALSE)
names(df) = c("datetime_str", "bytes_per_second")

library(dplyr)
speed <- mutate(df, mbits_per_second = bytes_per_second * 8 / 1000000, system="desktop cable")
speed <- transform(speed, datetime=strptime(datetime_str, "%b %d %H:%M:%S "))

#speed <- rbind(speed_laptop, speed_desktop)

library(ggplot2)
png("speedtest.png", width=1000, height=700)
g <- ggplot(speed, aes(x=datetime, y=mbits_per_second, group=system, color=system))
g + geom_line()
dev.off()

#png("speedtest-side-by-side.png", width=1000, height=700)
#grid <- ggplot(speed, aes(x=datetime, y=mbits_per_second))
#grid + facet_grid(. ~ system) + geom_line()
#dev.off()

png("speedtest-boxplot.png", width=1000, height=700)
box <- ggplot(speed, aes(factor(system), mbits_per_second))
box + geom_boxplot()
dev.off()

