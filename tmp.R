adsf

library(ggplot2)

data = data.frame(x = sample(1:10, 10, replace=TRUE), y = sample(1:10, 10, replace=TRUE), 
           Rank = sample(1:10, 10, replace = TRUE), Quantified = factor(sample(1:2, 10, replace = TRUE))
)

ggplot(data, aes(x = x, y = y)) +
          geom_point(aes(size = Rank, shape = Quantified)) +
          scale_shape_manual("Quantified", labels = c("wweebo", "No"), values = c(5, 20)
 )

#### OG
ggplot(plotDt) +
  labs(title = 'Example of divinity in action over the past year', 
       subtitle = 'Ticker = TSLA') +
  xlab('Date') +
  ylab('Price per share (USD)') +
  geom_point(mapping = aes(x = ds, y = y, color = 'Actual TSLA price')) +
  geom_line(mapping = aes(x = ds, y = yhat, color = 'Predicted TSLA price')) +
  geom_ribbon(mapping = aes(x = ds, 
                            ymin = yhat_lower, ymax = yhat_upper, fill = 'Predicted price CIs'), 
              alpha = .3) +
  geom_line(mapping = aes(x = ds, y = maFast, color = '3 day moving average')) +
  geom_line(mapping = aes(x = ds, y = maSlow, color = '5 day moving average')) +
  geom_point(mapping = aes(x = actionDate, y = actionY, color = 'Buy or sell signal')) +
  scale_color_manual(values = c('Actual TSLA price' = 'black', 
                                'Predicted TSLA price' = 'cornflowerblue', '3 day moving average' = 'darkorange1',
                                '5 day moving average' = 'green4', 
                                'Buy or sell signal' = 'red'), 
                     guide = guide_legend(overide.aes = list(linetype = c('blank', 'blank', 'blank', 'blank', 'blank'), 
                                                             shape = c(16, 16, 16, 16, 16)))) +
  scale_fill_manual(values = c('Predicted price CIs' = 'cornflowerblue')) +
  scale_shape_manual('Quantifed', labels = c("Yes", "No"))

library(data.table)
library(ggplot2)

dt <- fread('~/Library/CloudStorage/Dropbox/divinity/output/backtestTSLAOutcome.csv')[,-1:-2]
# only include cross points if they fall outside of CIs
dt[crossY <= yhat_lower | crossY >= yhat_upper, `:=` (actionDate = crossDate, 
                                                      actionY = crossY)]
# same thing here but exclude them if they're not the first upper/lower cross
dt[grp != 1, `:=` (actionDate = NA, actionY = NA)]

plotDt <- dt[ds >= '2021-01-01' & ds <= '2022-01-01']

#########

ggplot(plotDt) +
  labs(title = 'Example of divinity in action over the past year', 
       subtitle = 'Ticker = TSLA') +
  xlab('Date') +
  ylab('Price per share (USD)') +
  geom_point(mapping = aes(x = ds, y = y, color = 'Actual TSLA price')) +
  geom_line(mapping = aes(x = ds, y = yhat, color = 'Predicted TSLA price')) +
  geom_ribbon(mapping = aes(x = ds, 
                            ymin = yhat_lower, ymax = yhat_upper, fill = 'Predicted price CIs'), 
              alpha = .3) +
  geom_line(mapping = aes(x = ds, y = maFast, color = '3 day moving average')) +
  geom_line(mapping = aes(x = ds, y = maSlow, color = '5 day moving average')) +
  geom_point(mapping = aes(x = actionDate, y = actionY, color = 'Buy or sell signal')) +
  scale_color_manual(values = c('Actual TSLA price' = 'black', 
                                'Predicted TSLA price' = 'cornflowerblue', 
                                '3 day moving average' = 'darkorange1',
                                '5 day moving average' = 'green4', 
                                'Buy or sell signal' = 'red')) +
  scale_fill_manual(values = c('Predicted price CIs' = 'cornflowerblue')) +
  guides(color = guide_legend(override.aes = list(shape = c(16, NA, NA, NA, 16), 
                                                  linetype = c('blank', 'solid', 'solid', 'solid', 'blank'))))


ggplot(plotDt) +
  labs(title = 'Example of divinity in action over the past year', 
       subtitle = 'Ticker = TSLA') +
  xlab('Date') +
  ylab('Price per share (USD)') +
  geom_point(mapping = aes(x = ds, y = y, color = 'Actual TSLA price')) +
  geom_line(mapping = aes(x = ds, y = yhat, color = 'Predicted TSLA price')) +
  geom_ribbon(mapping = aes(x = ds, 
                            ymin = yhat_lower, ymax = yhat_upper, fill = 'Predicted price CIs'), 
              alpha = .3) +
  geom_line(mapping = aes(x = ds, y = maFast, color = '3 day moving average')) +
  geom_line(mapping = aes(x = ds, y = maSlow, color = '5 day moving average')) +
  geom_point(mapping = aes(x = actionDate, y = actionY, color = 'Buy or sell signal')) +
  scale_color_manual(values = c('Actual TSLA price' = 'black', 
                                'Predicted TSLA price' = 'cornflowerblue', 
                                '3 day moving average' = 'darkorange1',
                                '5 day moving average' = 'green4', 
                                'Buy or sell signal' = 'red')) +
  scale_fill_manual(values = c('Predicted price CIs' = 'cornflowerblue')) +
  guides(color = guide_legend(title = '',
                              override.aes = list(shape = c(16, NA, NA, NA, 16), 
                                                  linetype = c('blank', 'solid', 'solid', 'solid', 'blank'))), 
         fill = guide_legend(title = ''))
  
set.seed(1)
dist <- rnorm(10000, mean = 100, sd = 15)

samples <- c()
for(i in 1:1000){
  set.seed(i)
  indexes <- round(runif(10, min = 1, max = 10000))
  samples <- append(samples, dist[indexes])
}

dt <- as.data.table(samples)
dt[, greater := samples > shift(samples)]
dt[, less := samples < shift(samples)]
dt[, diffMean := samples - 100]
dt[, sd := (samples - 100)/100]
dt[, rowid := 1:10000]

dt[, .(unique(round(sd, 1)), .N)]


