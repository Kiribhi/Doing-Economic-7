install.packages(c("readxl", "tidyverse", "ggplot2"))

library("readxl") #Package for reading .xlsx
library("tidyverse")
library("ggplot2")

setwd("WORKING_DIRECTORY")
wm_data <- read_excel(path=".\\datafile.xlsx", sheet="Sheet1", na="NA")
str(wm_data)

names(wm_data) <- c("Year", "log.q", "log.h", "log.p", "log.pc", 
                    "log.pv", "log.w", "log.n", "log.yn", "log.pf")
wm_data$p <- exp(wm_data$log.p)  # Price
wm_data$h <- exp(wm_data$log.h)  # Crop
wm_data$q <- exp(wm_data$log.q)  # harvested


#Calculate elasticity
#wm_data$e_h <- NA # 수확량의 탄력성
#wm_data$e_q <- NA # 재배량의 탄력성
#for(i in c(2:length(wm_data$Year))) {
#  delta_q <- wm_data$q[i] - wm_data$q[i-1]
#  q <- (wm_data$q[i] + wm_data$q[i-1])/2
#  
#  delta_h <- wm_data$h[i] - wm_data$h[i-1]
#  h <- (wm_data$h[i] + wm_data$h[i-1])/2
#  
#  delta_p <- (wm_data$p[i] - wm_data$p[i-1])
#  p <- (wm_data$p[i] + wm_data$p[i-1])/2
#
#  wm_data$e_q[i] <- (delta_q/q) / (delta_p/p)
#  wm_data$e_h[i] <- (delta_h/h) / (delta_p/p)
#}

ggplot(wm_data, aes(x=Year)) + #Plotting price
  geom_line(aes(y=p, colour="Price"), size=1.5, alpha=0.5) + 
  geom_point(aes(y=p, colour="Price"), size=3, alpha=0.5) + 
  scale_colour_manual("",
                      breaks = "Price",
                      values = c("Price"="red")) + 
  xlab('Year') + ylab('Price')
  

ggplot(wm_data, aes(x=Year)) + #Plotting quantity
  geom_point(aes(y=q, colour="Crop"), size=3, alpha=0.5) +
  geom_line(aes(y=q, colour="Crop"), size=1.5, alpha=0.5) +
  geom_point(aes(y=h, colour="Harvested"), size=3, alpha=0.5) +
  geom_line(aes(y=h, colour="Harvested"), size=1.5, alpha=0.5) + 
  scale_colour_manual("",
                      breaks = c("Crop", "Harvested"),
                      values = c("Crop"="green", "Harvested"="blue")) + 
  xlab('Year') + ylab('Quantity')

#ggplot(wm_data,aes(x=Year)) + #Plotting elasticity
#  geom_line(aes(y=e_q, colour="Ec"), size=1.5, alpha=0.5) + 
#  geom_point(aes(y=e_q, colour="Ec"), size=3, alpha=0.5) + 
#  geom_line(aes(y=e_h, colour="Eh"), size=1.5, alpha=0.5) + 
#  geom_point(aes(y=e_h, colour="Eh"), size=3, alpha=0.5) +
#  scale_colour_manual("",
#                      breaks = c("Ec", "Eh"),
#                      values = c("Ec"="orange", "Eh"="dark green")) +
# xlab('Year') + ylab('Elasticity')

# mean_q = mean(wm_data$q)
# #diff_q = max(wm_data$q) - min(wm_data$q)
# sd_q = sd(wm_data$q)
# wm_data$norm_q = mean_q / sd_q
# ggplot(wm_data,aes(x=norm_q)) +
#   geom_line(aes(y=e_q, colour="Ec"), size=1.5, alpha=0.5) + 
#   geom_point(aes(y=e_q, colour="Ec"), size=3, alpha=0.5) + +
#   scale_colour_manual("",
#                       breaks = c("Ec"),
#                       values = c("Ec"="orange")) +
#   xlab('Year') + ylab('Elasticity')

#ggplot(wm_data, aes(x=log.q)) + #Plotting price
#  geom_line(aes(y=log.p, colour="log P"), size=1.5, alpha=0.5) + 
#  geom_point(aes(y=log.p, colour="log P"), size=3, alpha=0.5) + 
#  scale_colour_manual("",
#                      breaks = "log P",
#                      values = c("log P"="red")) + 
#  xlab('Year') + ylab('Price')
