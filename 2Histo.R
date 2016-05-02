#!/usr/bin/Rscript --vanilla

# 2Histo.R
# plot a list numbers as histogram from stdin, cat, piped, ...
# add boxplot and quantiles for good measure
#
# Stephane Plaisance (VIB-NC+BITS) 2015/04/02; v1.0
#
# visit our Git: https://github.com/BITS-VIB

suppressMessages(library("gplots"))

data  <- as.numeric(readLines(file("stdin")))
closeAllConnections()

# customize quantiles
p <- c(0, 5, 25, 50, 75, 95, 100)/100
qt <- round( quantile(data,
                      probs = p,
                      na.rm = FALSE,
                      names = TRUE,
                      type = 7),
             3 )

table <- as.data.frame(qt)
colnames(table) <- "Quantiles"

png(file="2isto.png",  width = 640, height = 480,
    units = "px", pointsize = 12, bg = "white" )

par(mar=c(5, 4, 4, 2)+0.1, mai=c(0.5,0.75,0.5,0.75))

nf <- layout(matrix(c(1,3,2,0), 2, 2,
                    byrow = TRUE),
                    widths=c(3,2),
                    heights=c(3,1),
             respect = TRUE)
#layout.show(nf)

hist(data, main="")
boxplot(data, horizontal = TRUE)
textplot(table, halign="left", valign="top", cex=1.5)
