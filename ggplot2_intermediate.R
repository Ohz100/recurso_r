#
# stat_bin()     geom_histogram() geom_freqpoly()
# stat_count()   geom_bar()
# stat_smooth()  geom_smooth()
#
library(ggplot2)
library(dplyr)

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  # Add 3 smooth LOESS stats, varying span & color
  stat_smooth(se = FALSE, color = 'red', span = 0.9) +
  stat_smooth(se = FALSE, color = 'green', span = 0.6) +
  stat_smooth(se = FALSE, color = 'blue', span = 0.3)

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  # Add a smooth LOESS stat, no ribbon
  stat_smooth(se = FALSE) +
  # Add a smooth lin. reg. stat, no ribbon
  stat_smooth(method = 'lm', se = FALSE) 

# heteroscedasticity
## geom_count stat_sum()

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point()

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_count(alpha = 0.5)

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_jitter(alpha = 0.5)

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_jitter(alpha = 0.25) +
  # Map the fill color to year_group, set the line size to 2
  stat_smooth(method = "lm")

# geom_quantile | stat_quantile
n <- 200
x <- sample(1:5, n, replace = TRUE)
y <- x + sample(-1:1, n, replace = TRUE)
df <- data.frame(x, y)
df

ggplot(df, aes(x, y)) + geom_point()
ggplot(df, aes(x, y)) + stat_sum()
ggplot(df, aes(x, y)) + geom_jitter()
ggplot(df, aes(x, y)) + geom_jitter(alpha = 0.25) + 
  stat_quantile(quantiles = c(0.05, 0.5, 0.95))

ggplot(df, aes(x, y)) + stat_sum()
ggplot(df, aes(x, y)) + stat_sum() + scale_size(range = c(1, 10))
ggplot(df, aes(x, y)) + stat_sum(aes(size = ..prop..))
ggplot(df, aes(x, y, group = x)) + stat_sum(aes(size = ..prop..))

# mean_sdl
mean_sdl(x)
mean_sdl(x, 2) # -2 +2 sd

mean_cl_normal(x) # 95% -0.025 + 0.025

n <- 200
x <- sample(1:5, n, replace = TRUE)
y <- x + 2 + sample(-2:2, n, replace = TRUE)
df2a <- data.frame(x, y, z = 'A')
y <- x + 4 + sample(-2:2, n, replace = TRUE)
df2b <- data.frame(x, y, z = 'B')
y <- x + 6 + sample(-2:2, n, replace = TRUE)
df2c <- data.frame(x, y, z = 'C')
df2 <- rbind(df2a, df2b, df2c)
ggplot(df2, aes(x, y, color = z)) + geom_jitter()
# position_jitter
# position_dodge
# position_jitterdodge
ggplot(df2, aes(x, y, color = z)) + geom_point(position = position_jitter(width = 0.2))
ggplot(df2, aes(x, y, color = z)) + geom_point(position = position_dodge(width = 0.1))
ggplot(df2, aes(x, y, color = z)) + geom_point(
  position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.1)
)

ggplot(df2, aes(z, y)) + stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1))
df2 %>%
  group_by(z) %>%
  summarise(y_bar = mean(y), s = sd(y)) %>%
  mutate(lw = y_bar - 1*s, up = y_bar + 1*s) %>%
  ggplot(aes(z, y_bar)) + geom_pointrange(aes(ymin = lw, ymax = up))

ggplot(df2, aes(z, y)) +
  stat_summary(fun = mean, geom = 'point') +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = 'errorbar', width = 0.1)

# stat_summary()
# stat_fubction()
# stat_qq()
n <- 200
xmean <- 10
xsd <- 2
df3 <- data.frame(x = rnorm(n, xmean, xsd))

b <- 40
ggplot(df3, aes(x)) + geom_histogram(bins = b)
ggplot(df3, aes(x)) + geom_histogram(bins = b) + geom_rug()

ggplot(df3, aes(x)) + geom_histogram(aes(y = ..density..), bins = b)
ggplot(df3, aes(x)) + geom_histogram(aes(y = ..density..), bins = b) + geom_rug()

ggplot(df3, aes(x)) + geom_histogram(aes(y = ..density..), bins = b) +
  geom_rug() +
  stat_function(
    fun = dnorm,
    color = 'red',
    args = list(mean = xmean, sd = xsd)
  )

ggplot(df3, aes(sample = x)) + stat_qq() + geom_qq_line()
ggplot(df3, aes(sample = x)) + stat_qq() + geom_qq_line(col = 'red')

# coord_cartesian

n <- 200
x <- runif(n, 1, 5)
y <- x + 2 + runif(n, -2, 2)
df4a <- data.frame(x, y, z = 'A')
y <- x + 4 + runif(n, -2, 2)
df4b <- data.frame(x, y, z = 'B')
y <- x + 6 + runif(n, -2, 2)
df4c <- data.frame(x, y, z = 'C')
df4 <- rbind(df4a, df4b, df4c)
ggplot(df4, aes(x, y, color = z)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  coord_cartesian(xlim = c(0, 6))

ggplot(df4, aes(x, y, color = z)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  coord_fixed()

ggplot(df4, aes(x, y, color = z)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  coord_fixed(ratio = 0.5)

# log coord log scale

n <- 100
x <- 10^runif(n, -2, 3)
y <- runif(n, 1, 3)
df5 <- data.frame(x, y)
ggplot(df5, aes(x, y)) + geom_point()
ggplot(df5, aes(log10(x), y)) + geom_point()
ggplot(df5, aes(log10(x), y)) + geom_point() + annotation_logticks()

ggplot(df5, aes(x, y)) + geom_point() + scale_x_log10()

ggplot(df5, aes(x, y)) + geom_point() + coord_trans(x = 'log10')

# coord_flip()
ggplot(df4, aes(x, y, color = z)) +
  geom_point() +
  geom_smooth(method = 'lm')

ggplot(df4, aes(x, y, color = z)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  coord_flip()

# coord_polar()

df5 <- data.frame(x = 0:40, y = 0:40/2)
ggplot(df5, aes(x, y)) + geom_line() + coord_fixed()
ggplot(df5, aes(x, y)) + geom_line() + coord_polar()
ggplot(df5, aes(x, y)) + geom_line() + coord_polar(theta = 'y')

# facet

a <- iris[c('Sepal.Length', 'Sepal.Width', 'Species')]
names(a) <- c('Length', 'Width', 'Species')
a[['Part']] <- 'Sepal'
b <- iris[c('Petal.Length', 'Petal.Width', 'Species')]
names(b) <- c('Length', 'Width', 'Species')
b[['Part']] <- 'Petal'
iris_w <- rbind(a, b)
iris_w
