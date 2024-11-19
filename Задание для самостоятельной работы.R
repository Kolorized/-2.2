install.packages("readxl")
library("readxl")

install.packages("rpivotTable")
library("rpivotTable")

R <- read_excel("problems_1.xlsx")
View(R)

F <- data.frame(R[2:828,]$AdmArea, R[2:828,]$Month, as.numeric(R[2:828,]$Year), as.numeric(R[2:828,]$TotalAmount))
View(F)

colnames(F) <- c("AdmArea", "Month", "Year", "TotalAmount")

#1

View(data.frame(F$AdmArea[F$Year == 2016], F$Year[F$Year == 2016], F$TotalAmount[F$Year == 2016]))
View(data.frame(F$AdmArea[(F$Year >= 2016) & (F$Year <= 2019)], 
                F$Year[(F$Year >= 2016) & (F$Year <= 2019)], 
                F$TotalAmount[(F$Year >= 2016) & (F$Year <= 2019)]))

rpivotTable::rpivotTable(F, rows = "AdmArea", cols = "Year", vals = "TotalAmount", aggregatorName = "Average")
rpivotTable::rpivotTable(F, rows="Month", cols=2021, vals="TotalAmount", aggregatorName="Sum")

boxplot(TotalAmount ~ Year * AdmArea, data = F, 
        main = "Средние ежегодные начисления по округам",
        xlab = "Год", ylab = "Средняя сумма начислений",
        names.arg = Year, col = rainbow(length(areas)))
#2
D <- data.frame(F$Month[(F$Year == 2021)], 
                F$TotalAmount[(F$Year == 2021)])
View(D)

#3
H <- subset(F, AdmArea == "Центральный административный округ")
T <- mean(H$TotalAmount) 
M <- subset(H, TotalAmount > T)
View(M)

save(D, file = "Фрейм 2")
save(M, file = "Фрейм 3")

