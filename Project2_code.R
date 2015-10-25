## ------------------------------------------------------------------------
library(datasets)
library(ggplot2)
library(gridExtra)
library(knitr)
# Data derived from ToothGrowth data sets are used. 
# ToothGrowth describes the effect of Vitamin C on Tooth growth in Guinea pigs.

data(ToothGrowth)
TG <- ToothGrowth

# View the data
head(TG)

# Check the variables in supp
str(TG)

## ------------------------------------------------------------------------

# Plot in boxplot format to see effectiveness of OJ vs VC

g1 <- ggplot(data=TG, aes(x=as.factor(dose), y=len, fill=supp)) +
  geom_boxplot() +
  facet_grid(. ~ supp) +
  xlab("Dose in miligrams") +
  ylab("Tooth length") +
  guides(fill=FALSE)

g2 <- ggplot(data=TG, aes(x=as.factor(supp), y=len, fill=supp)) +
  geom_boxplot() +
  facet_grid(. ~ dose) +
  xlab("Dose in miligrams") +
  ylab("Tooth length") +
  guides(fill=FALSE)

grid.arrange(g2,g1,nrow=2)

## ------------------------------------------------------------------------

# Study the correlation between variables , i.e. dose and supp type on len
# Use linear regression model

fit <- lm(len ~ dose + supp, data=TG)
summary(fit)
  