library(installr)
library(readxl)
library(tidyverse)
library(dplyr)
library(foreign)
library(ggplot2)

data_csv <- read.csv("http://stats.idre.ucla.edu/stat/data/hsbdemo.csv")
View(data)
#delim은 이상하게 나오니까 쓰지말자(나중에 알고 쓰는걸로)
data_tab <- read_delim("http://stats.idre.ucla.edu/stat/data/hsb2.txt", delim="/t")
View(data_tab)
data_tab
#tible
md <- tibble(height=c(58,33,92), weight=c(198,298,136))
md
class(md)
class(as.data.frame(md))
as.data.frame(md)
#sas,spss파일 부르기
require(haven)
daspaa<-read.spss("http://stats.idre.ucla.edu/stat/data/hsb2.sav")
download.file("http://stats.idre.ucla.edu/stat/data/hsb2.xls","prac_lec.xls",mode = "wb")
daxls <- read_excel("prac_lec.xls")
write.csv(data_csv, file="C://Users//user//Desktop//R특강//11//data_csv.csv")
write.dta(data, file="C://Users//user//Desktop//R특강//11//dacsv.csv")

#data exploration
dd<- read.csv("http://stats.idre.ucla.edu/stat/data/hsbraw.csv")
View(dd)
mean(dd$read)
median(dd$read)
var(dd$read)
ggplot(data=dd, aes(x=write, y=read)) +geom_point()
ggplot(data=dd, aes(x=write)) +geom_histogram(bins=10)
ggplot(dd[dd$math>mean(dd$math),],aes(x=write)) +geom_histogram(bins=10)
ggplot(dd, aes(x=1, y=science)) + geom_boxplot()
table(dd$female)
table(dd$ses)

#요인
str(dd$ses)
dd$ses <- factor(dd$ses, levels=c("low","middle","high"))
str(dd$ses)
levels(dd$ses)
dd$ses[1] == "low"
as.numeric(dd$ses[1]) == 1
dd$female <- factor(dd$female)
dd$prog <- factor(dd$prog)
levels(dd$prog)
table(dd$prog)
dd$prog <- factor(dd$prog, levels =  c("academic", "general", "vocation"))
str(dd$prog)
table(dd$prog)
View(dd)
dd$female <- factor(dd$female, level=c("female", "male"))
str(dd$female)
ggplot(dd, aes(x=ses)) + geom_bar()
ggplot(dd, aes(x=prog)) + geom_bar()

#correlation(상관관계) 
cor(dd$write, dd$read)
ggplot(dd, aes(x=read, y=write)) + 
  geom_point() +
  geom_smooth()
scores <- dd[, c("read", "write")]
scores
cor(scores)

#그룹별 평균산출
by_fe <- group_by(dd, female)
class(by_fe)
summarize(by_fe, mean(math), var(math))
summarize(dd, mean(math), var(math))
ggplot(dd, aes(x=female, y=math)) +
  geom_boxplot()
ggplot(by_fe, aes(x=math)) + 
  geom_density()
ggplot(dd, aes(x=ses, fill=prog)) +
  geom_bar(position = "dodge")
ggplot(dd, aes(x=read, y=write, color=prog)) +
  geom_point()+
  geom_smooth()
ggplot(dd, aes(x=ses, fill=prog)) +
  geom_bar(position = "dodge") + #분리
  facet_wrap(~female) #facet_wrap은 성별
ggplot(dd, aes(x=awards, fill=prog)) +
  geom_density()
table(dd$awards)
summary(dd$awards)
by_se<-group_by(dd, prog)
summarize(by_se, max(math), IQR(math))  
table(by_se$prog)
ggplot(by_se, aes(x=prog,y=math,fill=prog)) +
  geom_boxplot()

#>>data manage 
#sorting
dd <- arrange(dd, science, socst) 
dd
dd$science[dd$science == -99] <- NA
head(dd$science,10)
head(dd,10)
dd2<-read_csv("http://stats.idre.ucla.edu/stat/data/hsbraw.csv")
sum(c(1,2,NA), na.rm=TRUE)
