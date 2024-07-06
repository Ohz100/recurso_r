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
