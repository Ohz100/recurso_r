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

## Coefficient of determination (coeficiente de coorelación)

summary(model)
summary(model_df_2)
summary(model_df_3)
summary(model_df_4)

library(broom)
model %>% glance()
model_df_2 %>% glance()
model_df_3 %>% glance()
model_df_4 %>% glance()

summary(model)
cor(df[['x']], df[['y']])^2

## RSE

model %>% glance %>% pull(sigma)

df %>%
  mutate(residuals_sqrt = residuals(model)^2) %>%
  summarize(
    sum_residuals_sqrt = sum(residuals_sqrt),
    deg_freedom = n() - 2,
    rse = sqrt(sum_residuals_sqrt/deg_freedom)
  )  

## RMSE

df %>%
  mutate(residuals_sqrt = residuals(model)^2) %>%
  summarize(
    sum_residuals_sqrt = sum(residuals_sqrt),
    n_obs = n(),
    rmse = sqrt(sum_residuals_sqrt/n_obs)
  )

## 1 residual vs fitted values
## 2 Q-Q plot
## 3 scale-location

library(ggfortify)
autoplot(model, which = 1)
autoplot(model, which = 2)
autoplot(model, which = 1:3)

autoplot(model_df_3, which = 1:3, nrow = 3, ncol = 1)

## Outliers

n <- 50
x_5 <- runif(n, 1, 9)
y_5 <- 1 + 0.5*x_5 + rnorm(n, sd = .25)
df_5 <- data.frame(x = x_5, y = y_5)
ggplot(df_5, aes(x, y)) + geom_point() + geom_smooth(method = 'lm', se = FALSE)
df_5_out <- data.frame(x = c(1, 9, 12), y = c(4, 4, 6))
df_5_mod <- rbind(df_5, df_5_out)
ggplot(df_5_mod, aes(x, y)) + geom_point() + geom_smooth(method = 'lm', se = FALSE)

### Leverage 

model_df_5 <- lm(y ~ x, df_5_mod)

hatvalues(model_df_5)

augment(model_df_5)
augment(model_df_5) %>% pull(.hat)
model_df_5 %>%
  augment() %>%
  select(x, y, leverage = .hat) %>%
  arrange(desc(leverage)) %>%
  head()

### Influence (Cook's distance)

cooks.distance(model_df_5)

augment(model_df_5) %>% pull(.cooksd)
model_df_5 %>%
  augment() %>%
  select(x, y, cooksd = .cooksd) %>%
  arrange(desc(cooksd)) %>%
  head()

ggplot(df_5_mod, aes(x, y)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  geom_smooth(method = 'lm', se = FALSE, data = df_5, color = 'red')

autoplot(model_df_5, which = 4:6, nrow = 2, ncol = 2)
