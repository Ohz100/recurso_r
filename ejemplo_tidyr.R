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
