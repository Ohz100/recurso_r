# dplyr
library(dplyr)

df <- data.frame(col_1 = c('A', 'A', 'B', 'B'), 
                 col_2 = c('a', 'b', 'a', 'b'), 
                 col_3 = 1:4)
df

# select
df %>% select(col_1, col_2)
df %>% select(col_1, col_3)

# filter
df %>% filter(col_1 == 'A')
df %>% filter(col_1 == 'A', col_3 == 1)
df %>% filter(col_1 == 'A', col_2 == 'b')
df %>% filter(col_1 == 'A' | col_3 < 4)

# arrange
df %>% arrange(col_2)
df %>% arrange(desc(col_3))
df %>% arrange(col_2, desc(col_3))

# mutate
df %>% mutate(col_4 = pi*col_3)
df %>% mutate(col_1, col_5 = sqrt(col_3), .keep = 'none')
df %>% mutate(col_3, col_5 = sqrt(col_3), .keep = 'none')

# glimpse
glimpse(df)

# count
df <- data.frame(col_1 = sample(c('A', 'B', 'C'), 6, replace = TRUE), 
                 col_2 = sample(1:3, 6, replace = TRUE), 
                 col_3 = sample(1:6))
df
df %>% count(col_1)
df %>% count(col_1, col_2)
df
df %>% count(col_1, wt = col_3)
df %>% count(col_1, wt = col_3, sort = TRUE)

# summarize
df
df %>% summarize(u_1 = sum(col_2))
df %>% summarize(u_2 = sum(col_3))

# group_by & ungroup
df
df %>% group_by(col_1) %>% summarise(u_1 = sum(col_2), u_2 = sum(col_3)) 
df %>% group_by(col_1, col_2) %>% summarise(u_1 = sum(col_3)) 
df %>% 
  group_by(col_1, col_2) %>% 
  summarise(u_1 = sum(col_3)) %>% 
  summarise(u_2 = min(u_1))
df %>% 
  group_by(col_1, col_2) %>% 
  summarise(u_1 = sum(col_3)) %>%
  ungroup()

# slice_max and slice_min
df
df %>% group_by(col_1) %>% slice_max(col_2)
df %>% group_by(col_1) %>% slice_min(col_2)

# select helpers
df <- data.frame(Acol_1 = sample(1:4), 
                 Bcol_2Y = sample(1:4), 
                 col_3Z = sample(1:4), 
                 u = sample(1:4))
df
df %>% select(contains('col'))
df %>% select(starts_with('A'), ends_with('Z'))
df %>% select(starts_with('A'), last_col())

# rename
df
df %>% rename(col_4 = u)
df %>% select(col_1 = Acol_1, col_2 = Bcol_2Y, col_3 = col_3Z)

# relocate
df
df %>% relocate(u, .before = Bcol_2Y)
df %>% relocate(col_3Z, .after = last_col())
df %>% relocate(u, .before = contains('col'))

# group_by & mutate
df <- data.frame(col_1 = sample(c('A', 'B'), 6, replace = TRUE), 
                 col_2 = sample(1:6))
df
df %>% group_by(col_1) %>% summarise(u = sum(col_2))
df %>%
  group_by(col_1) %>%
  mutate(u_1 = sum(col_2)) %>%
  ungroup
df %>%
  group_by(col_1) %>%
  mutate(u_1 = sum(col_2)) %>%
  ungroup %>%
  mutate(u_2 = col_2/u_1)

# lag
x <- sample(1:10, 10, replace = TRUE)
x
lag(x)
x - lag(x)
