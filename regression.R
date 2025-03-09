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

## Regression to de mean

ggplot(df, aes(x, y)) +
  geom_point() +
  geom_abline(color = 'green', size = 1) +
  coord_fixed() +
  geom_smooth(method = 'lm', se = FALSE)

predict(model, data.frame(x = 1)) # predicted y > x

predict(model, data.frame(x = 3)) # predicted y < x

## Transforming variables y ~ x^2
n <- 200
x_3 <- runif(n, 2, 9)
y_3 <- 4*(x_3 + 2)^2 + 2 + rnorm(n, sd = 5)
df_3 <- data.frame(x = x_3, y = y_3)

ggplot(df_3, aes(x, y)) +
  geom_point()+
  geom_smooth(method = 'lm', se = FALSE)

ggplot(df_3, aes(x^2, y)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

model_df_3 <- lm(y ~ I(x^2), df_3)
model_df_3

df_3_x <- data.frame(x = 2:9)
df_3_predict <- df_3_x %>%
  mutate(y = predict(model_df_3, df_3_x))
df_3_predict

ggplot(df_3, aes(x, y)) + 
  geom_point() + 
  geom_smooth(method = 'lm', se = FALSE) + 
  geom_point(data = df_3_predict, color = 'blue', size = 4)

ggplot(df_3, aes(x^2, y)) + 
  geom_point() + 
  geom_smooth(method = 'lm', se = FALSE) + 
  geom_point(data = df_3_predict, color = 'blue', size = 4)

## Transforming variables y^0.5 ~ x^0.5
n <- 400
t <- runif(n, 0, 10)
x_4 <- t^2
y_4 <- abs(x_4 + rnorm(n, sd = 3))
df_4 <- data.frame(x = x_4, y = y_4)

ggplot(df_4, aes(x, y)) +
  geom_point()+
  geom_smooth(method = 'lm', se = FALSE)

ggplot(df_4, aes(sqrt(x), sqrt(y))) +
  geom_point()+
  geom_smooth(method = 'lm', se = FALSE)

model_df_4 <- lm(sqrt(y) ~ sqrt(x), df_4)
model_df_4

df_4_x <- data.frame(x = 1:9)
df_4_predict <- df_4_x %>%
  mutate(sqr_y = predict(model_df_4, df_4_x), y = sqr_y^2)
df_4_predict

ggplot(df_4, aes(x, y)) + 
  geom_point() + 
  geom_smooth(method = 'lm', se = FALSE) + 
  geom_point(data = df_4_predict, color = 'blue', size = 4)

ggplot(df_4, aes(sqrt(x), sqrt(y))) + 
  geom_point() + 
  geom_smooth(method = 'lm', se = FALSE) + 
  geom_point(data = df_4_predict, color = 'blue', size = 4)
