df<- data.frame(A = 1:3, B = 4:6)
df
df['A']
df[['A']]
df['C'] <- 7:9
df

vec <- 1:9
vec
c(4,5, 0, -1) %in% vec

!c(TRUE, FALSE)

c(TRUE, TRUE, FALSE, FALSE) & c(TRUE, FALSE, TRUE, FALSE)

c(TRUE, TRUE, FALSE, FALSE) | c(TRUE, FALSE, TRUE, FALSE)

