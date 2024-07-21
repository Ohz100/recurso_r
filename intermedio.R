# apply
df <- data.frame(A = 1:3, B = 4:6)
df
apply(df, MARGIN = 1, sum)
apply(df, MARGIN = 2, sum)

# vapply


# regex
a <- c('lorem', 'ipsum', 'dolor', 'sit', 'amet')

grepl('lo', a)
grepl('^lo', a)
grepl('m', a)
grepl('m$', a)

grep('lo', a)
grep('^lo', a)
grep('m', a)
grep('m$', a)

which(c(TRUE, FALSE, TRUE))

sub('^lo', 'ax', a)
sub('m$', 'zoo', a)
sub('o', 'uu', a)
sub('e|o', 'a', a)

gsub('o', 'uu', a)

b <- c('2a', 'b', '3c', 'd')
grepl('^[0-9]', b)

# date
Sys.Date()
Sys.time()
