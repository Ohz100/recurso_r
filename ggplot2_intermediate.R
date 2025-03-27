#
# stat_bin()     geom_histogram() geom_freqpoly()
# stat_count()   geom_bar()
# stat_smooth()  geom_smooth()
#
library(ggplot2)

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  # Add 3 smooth LOESS stats, varying span & color
  stat_smooth(se = FALSE, color = 'red', span = 0.9) +
  stat_smooth(se = FALSE, color = 'green', span = 0.6) +
  stat_smooth(se = FALSE, color = 'blue', span = 0.3)

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  # Add a smooth LOESS stat, no ribbon
  stat_smooth(se = FALSE) +
  # Add a smooth lin. reg. stat, no ribbon
  stat_smooth(method = 'lm', se = FALSE) 

ggplot(Vocab, aes(x = education, y = vocabulary, color = year_group)) +
  geom_jitter(alpha = 0.25) +
  # Map the fill color to year_group, set the line size to 2
  stat_smooth(method = "lm")

