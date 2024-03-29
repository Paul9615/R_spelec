library(installr)
library(readxl)
library(tidyverse)
library(dplyr)
library(foreign)
library(ggplot2)

View(dd)
by_c <- group_by(dd,cid)
class_stats <- summarize(by_c, meamath=mean(math), memath=median(math))
head(class_stats,5)
dd_merge <- merge(dd, class_stats)
dd_merge
dd_inner <- inner_join(dd, class_stats)
dd_inner
dd_cbind <- cbind(dd, class_stats)
dd_cbind
#merge와 inner_join의 경우 기존열이 있으면 포함을 시키고 합치지만, cbind는 기존열이 이미 있어도 상관없이 추가한다 
dim(dd_cbind)
View(dd_cbind)
View(dd_merge)
dim(dd)
dim(dd_inner)
dim(dd_merge)

direc <- tibble(names=c("Leo smith", "Karen smith",
                       "Andrey jones", "Dylan jones"),
               phone=c("(323)555-5432", "(323)555-5421",
                       "(213)555-2154", "(213)555-2155"))
direc$area_code <- substr(direc$phone,2,4)
direc
ser_num <- grep("13",direc$phone)
ser_num
View(ser_num)
