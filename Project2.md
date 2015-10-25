---
title: "Statistical Inference Project 2"
author: "Niraj Patel"
date: "October 26, 2015"
output: word_document
---

# Loading Initial Libraries and Dataset

```{r}
# Load necessary libraries
library(datasets)
library(ggplot2)
library(gridExtra)

```

Data derived from ToothGrowth data sets are used. ToothGrowth describes the effect of Vitamin C on Tooth growth in Guinea pigs. The dosage of Vitamin C is administered using two different kinds of liquids, i.e. Ornage Juice (OJ) and Ascorbic Acid (VC).

```{r}
data(ToothGrowth)
TG <- ToothGrowth

# Check the variables in supp in different columns
str(TG)
```

From the above, it can be seen that supp and dos are categorical variables.

# Visualise the data

```{r, echo=FALSE}

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

```

To better understand the effect of each variable in isolation, a regression model needs to be constructed. For the purpose of this exercise, the method used will be the Linear Regression model.

# Linear Regression Model

```{r}
# Study the correlation between variables , i.e. dose and supp type on len

fit <- lm(len ~ dose + supp, data=TG)
summary(fit)

```

From the $R^2$ value, we can see that 70% of the variance in the data is captured by the model. The intercept is `r fit$coefficients[[1]]`, meaning that without any Vitamin C supplied to the Guinea pigs, the average tooth length is `r fit$coefficients[[1]]` units. The coefficient of dose is `r fit$coefficients[[2]]`, meaning that regardless of type of Vitamin C, the length of teeth will increase by 9.76 units above the intercept value for every 1mg increase in dose of the  Vitamin C. 

The last coefficient is for the supplement type. Since the supplement type is a categorical variable, a dummy variable, suppVC, is created. The variable looks at the effect of administering Vitamin C via Ascorbic Acid while dosages are kept constant. The coefficient shows that the length of the tooth decreases by `r fit$coefficients[[3]]` when Ascorbic Acid is used as Vitamin C. This is clear in the graphs plotted above (row 1) as well for lower dosage values, however for the dosage of 2 mg and above, the trend is the opposite. To properly validate this data, a larger sample size would be required.

Keeping in mind that Vitamin C source is a categorical variable, we can also preliminarily deduce that length of the tooth will increase by `r fit$coefficients[[3]]` when Orange Juice is used as Vitamin C while keeping dosage constant.

# Confidence Interval and Conclusion

95% confidence intervals for two variables and the intercept are as follows.

```{r}
confint(fit)
```

The confidence intervals mean that if we collect a different set of data and estimate parameters of the linear model many times, 95% of the time, the coefficient estimations will be in these ranges. 

In conclusion, from the data above, it can be observed that both dosage and type of Vitamin C liquid used have an effect on the tooth length of the Guinea pigs. In coming to this conclusion, the following assumptions were taken.

1) The distribution of tooth length is normal
2) The guinea pigs in the sample are representative of the population of guinea pigs.
