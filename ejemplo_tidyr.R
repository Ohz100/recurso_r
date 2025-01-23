# tidyr
library(tidyr)
df <- data.frame(c = c('1-A', '2-B', '3-C'), d = 1:3)
df

# separate
df %>% separate(c, into = c('a', 'b'), sep = '-', convert = TRUE)

# unite
df %>% unite('e', c, d, sep = ' | ')

# separate_rows
df <- data.frame(A = c('R1', 'R2', 'R3'), B = c('1, 2, 3', '4', '5, 6'))
df
df %>% separate_rows(B, sep = ', ')

# replace_na
df <- data.frame(A = c('R1', 'R2', 'R3'), B = c(1, NA, 3))
df
df %>% replace_na(list(B = 0L))

# fill
df %>% fill(B, .direction = 'down')
df %>% fill(B, .direction = 'up')

# drop_na
df %>% drop_na()
df %>% drop_na(B)

# pivot_longer
df <- data.frame(A = c('R1', 'R2', 'R3'), B = 1:3, C = 4:6)
df
df %>% pivot_longer(c('B', 'C'))

# uncount
df <- data.frame(foo = c('A', 'B', 'C'), n = c(2, 1, 3))
df
df %>% uncount(n)
df %>% uncount(n, .id = 'id')

# pivot_wider
df <- data.frame(c_1 = c('A', 'A', 'B', 'B'), 
                 c_2 = c('x', 'y', 'x', 'y'),
                 c_3 = 1:4)
df
df %>% pivot_wider(names_from = c_2, values_from = c_3)

# pivot_longer variante
df <- data.frame(A = c('A', 'B', 'C'), 
                 x_1 = 1:3,
                 x_2 = 4:6,
                 y_1 = 7:9,
                 y_2 = 10:12)
df
df %>% pivot_longer(-A)
df %>% pivot_longer(-A, 
                    names_to = c('B', 'C'), 
                    values_to = 'D', 
                    names_sep = '_')
df %>% pivot_longer(-A, 
                    names_to = c('B', 'C'), 
                    values_to = 'D', 
                    names_sep = '_',
                    names_transform = list(C = as.integer))

# pivot_longer otra variante
df
df %>% pivot_longer(-A, 
                    names_to = c('B', '.value'), 
                    names_sep = '_')

# expand_grid
expand_grid(c_1 = 0:3, c_2 = 0:3)

# right_join(df, by = c(x, y))

# anti_join

# complete
df <- data.frame(c1 = c(1, 3, 3), 
                 c2 = c('A', 'A', 'B'), 
                 c3 = c(1, 2, 3))
df
df %>% complete(c1, c2)
df %>% complete(c1, c2, fill = list(c3 = 0L))
df %>% 
  complete(c1 = full_seq(df[['c1']], period = 1), c2, fill = list(c3 = 0L))

# unnest_wider unnest_longer
x <- list(list(c_1 = 'A', c_2 = 1, c_list = list(a = 1, b = 2, c = 3)), 
          list(c_1 = 'B', c_2 = 2, c_list = list(a = 15, b = 20)))
x

tibble(col = x) %>% unnest_wider(col) %>% unnest_longer(c_list)

# hoist
tibble(col = x) %>%
  hoist(col, 'col_A' = list('c_1'))

tibble(col = x) %>%
  hoist(col, 'col_B' = list('c_2'))

tibble(col = x) %>%
  hoist(col, 'col_A' = list('c_1'), 'a' = list('c_list', 'a'), 'b' = list('c_list', 'b'))

tibble(col = x) %>%
  hoist(col, 'col_A' = 'c_1', 'a' = list('c_list', 'a'), 'b' = list('c_list', 'b'))

str(x)

# glance, tidy, 
library(dplyr)
library(broom)
library(purrr)
df <- data.frame(x = c(1, 2, 3, 1, 2, 3), 
                 y = c(1.1, 1.9, 3.2, 0.9, 1.9, 3.3), 
                 z = c('a', 'a', 'a', 'b', 'b', 'b'))
df

model <- lm(y ~ x, data = df)
model
summary(model)

glance(model)
tidy(model)

map(list(l.1 = c(1,1,1), l.2 = c(1,2,3)), sum)

map(df[c('x','y')], sum)

df %>%
  group_by(z) %>%
  nest() %>%
  mutate(fit = map(data, function(x){lm(y ~ x, data = x)}), 
         glance = map(fit, glance), 
         tidy = map(fit, tidy)) %>%
  unnest(glance)

df_2 = df %>% 
  group_by(z) %>%
  nest() %>%
  mutate(fit = map(data, function(x){lm(y ~ x, data = x)}), 
         glance = map(fit, glance), 
         tidy = map(fit, tidy))
df_2 %>% unnest(glance)
df_2 %>% unnest(tidy)