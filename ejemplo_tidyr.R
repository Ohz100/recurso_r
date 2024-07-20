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

# pivot_longer()
df <- data.frame(A = c('R1', 'R2', 'R3'), B = 1:3, C = 4:6)
df
df %>% pivot_longer(c('B', 'C'))



# uncount
df <- data.frame(foo = c('A', 'B', 'C'), n = c(2, 1, 3))
df
df %>% uncount(n)
df %>% uncount(n, .id = 'id')
