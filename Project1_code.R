# Load necessary libraries
library(ggplot2)

# Set the simulation constants and seed value 
set.seed(3)
n=40
lambda=0.2

# Run the test data 
Mean <- data.frame(sapply(1:1000,function(x) {mean(rexp(n,lambda))}))
names(Mean) <- c("expDistMean")

# Plot the test results

ggplot(data = Mean, aes(x = expDistMean,y=..density..)) + 
  geom_histogram(binwidth=0.1) +   
  scale_x_continuous(breaks=round(seq(min(Mean$expDistMean), max(Mean$expDistMean), by=1)))

# Find stat values
expMean <- 1/lambda
sampleMean <- mean(Mean$expDistMean)
expVar <- (1/lambda/sqrt(n))^2
samplesd <- sd(Mean$expDistMean)
sampleVar <- samplesd^2

# Plot graph
ggplot(data = Mean, aes(x = expDistMean)) + 
  geom_histogram(binwidth=0.1, aes(y=..density..),alpha=0.2) + 
  stat_function(fun = dnorm, arg = list(mean = expMean , sd = expsd), colour = "red", size=1) + 
  geom_vline(xintercept = expMean, size=1, colour="red") + 
  geom_density(colour="blue", size=1) +
  geom_vline(xintercept = sampleMean, size=1, colour="blue",alpha=0.6) +
  scale_x_continuous(breaks=round(seq(min(Mean$expDistMean), max(Mean$expDistMean), by=1)))
