# missing doc here
# .. what else is missing from the function below?
plot_scatterhist <- function(x, xbreaks = 10, ybreaks = 10, ...) {
  layout(matrix(c(2, 1, 0, 3), ncol = 2), widths = c(2, 1), heights = c(1, 2))

  par(mar = c(3, 3, 1, 1))
  #browser()
  plot(x, xlab = "", ylab = "", ...)

  y <- hist(x[, 1], breaks = xbreaks, plot = FALSE)
  par(mar = c(0, 3, 2, 1))
  barplot(y$counts, col = 0, space = 0)

  y <- hist(x[, 2], breaks = ybreaks, plot = FALSE)
  par(mar = c(3, 0, 1, 2))
  barplot(y$counts, col = 0, space = 0, horiz = TRUE)
}
