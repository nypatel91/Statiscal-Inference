#Simulation

The exponential distribution can be simulated in R with rexp(n, lambda) where lambda $\lambda$ is the rate parameter. The mean of exponential distribution is $1/\lambda$ and the standard deviation is also $1/\lambda$. For this simulation, we set $\lambda=0.2$. In this simulation, we investigate the distribution of averages of 40 numbers sampled from exponential distribution with $\lambda=0.2$.

Let's do a thousand simulated averages of 40 exponentials.

```{r}
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
```

#Sample Mean vs Theoretical Mean

The expected mean $\mu$ of a exponential distribution of rate $\lambda$ is

$\mu= \frac{1}{\lambda}$

```{r}
expMean <- 1/lambda
expMean
```

Let $\bar X$ be the average sample mean of 1000 simulations of 40 randomly sampled exponential distributions.

```{r}
sampleMean <- mean(Mean$expDistMean)
sampleMean
```

Due to high number of simulations, it can be observed that the sample mean and expected mean are fairly close to one another.

#Sample Variance vs Theoritical Variance

The expected variance $\sigma$ of a exponential distribution of rate $\lambda$ is

$\sigma = \frac{1/\lambda}{\sqrt{n}}$

```{r}

expsd <- 1/lambda/sqrt(n)
expsd
   
```

While the expected variance then is simply the square of $\sigma$

```{r}

expVar <- (1/lambda/sqrt(n))^2
expVar
   
```

The sample $\sigma$ of the average sample mean of 1000 simulations of 40 randomly sampled exponential distribution is 

```{r}

samplesd <- sd(Mean$expDistMean)
samplesd
   
```

and as before, the sample variance $\sigma^2$ is 

```{r}

sampleVar <- samplesd^2
sampleVar
   
```

# Distribution in Graphical Manner

The line in read denotes the values from a normally distributed population while that in blue denotes that of the sampled cohort. It can be seen that due to the fairly large sample size, the sampled cohort closely resembles that of a normal distribution, as seen in the Central Limit Theorem (CLT). 

```{r, echo=FALSE}
# plot the means

ggplot(data = Mean, aes(x = expDistMean)) + 
  geom_histogram(binwidth=0.1, aes(y=..density..),alpha=0.2) + 
  stat_function(fun = dnorm, arg = list(mean = expMean , sd = expsd), colour = "red", size=1) + 
  geom_vline(xintercept = expMean, size=1, colour="red") + 
  geom_density(colour="blue", size=1) +
  geom_vline(xintercept = sampleMean, size=1, colour="blue",alpha=0.6) +
  scale_x_continuous(breaks=round(seq(min(Mean$expDistMean), max(Mean$expDistMean), by=1)))
```

The vertical line in the middle denotes the centre of the distribution and it can be seen that the mean sampled distribution almost directly overlaps that of the normal distribution.
