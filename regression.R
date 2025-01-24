# Introduction to regressiOn in R
library(ggplot2)
library(dplyr)

old <- theme_set(theme_bw())
#theme_set(old)

## Simple Linear Regression

n <- 1000
x_1 <- runif(n, 0, 9)
y_1 <- 1 + 0.5*x_1 + rnorm(n, sd = .2)
df <- data.frame(x = x_1, y = y_1)
df
df[['x']]
df[['y']]

ggplot(df, aes(x, y)) + geom_point(alpha = 0.5) + geom_smooth(method = 'lm', se = FALSE)

model <- lm(y ~ x, df)
model

## Simple Linear Regression continuous vs category

n <- 1000
x_2 <- rep(c('A', 'B', 'C'), each = n)
y_2 <- c(rnorm(n, mean = 3), rnorm(n, mean = 4), rnorm(n, mean = 5))
df_2 <- data.frame(x = x_2, y = y_2)

ggplot(df_2, aes(y)) + geom_histogram(bins = 19) + facet_wrap(vars(x))

model_df_2_manual <- df_2 %>% group_by(x) %>% summarise(y_bar = mean(y))
model_df_2_manual

model_df_2 <- lm(y ~ x + 0, df_2)
model_df_2

## Linear Regression + fited points

df_fited <- tibble(x = 0:9)
df_fited <- df_fited %>% mutate(y = predict(model, df_fited))
df_fited

ggplot(df, aes(x, y)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE) + 
  geom_point(data = df_fited, color = 'yellow')

#### hasta aqui me quede

## coefficients() fitted() residuals() summary()
## library() tidy() augment() glance() I()

# dell lorem ipsum
