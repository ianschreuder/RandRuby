# http://www.statmethods.net/graphs/scatterplot.html

library(car)
library(scatterplot3d)

# Simple Scatterplot
mtcars
?mtcars
summary(mtcars)
library(Hmisc)
describe(mtcars)
library(psych)
describe(mtcars)
attach(mtcars)
plot(wt, mpg, main="Scatterplot Example", xlab="Car Weight ", ylab="Miles Per Gallon ", pch=19)

# Add fit lines
abline(lm(mpg~wt), col="red") # regression line (y~x)
lines(lowess(wt,mpg), col="blue") # lowess (locally weighted regression) line (x,y) 


# Enhanced Scatterplot of MPG vs. Weight by Number of Car Cylinders
scatterplot(mpg ~ wt | cyl, data=mtcars,
   xlab="Weight of Car", ylab="Miles Per Gallon",
   main="Enhanced Scatter Plot",
   labels=row.names(mtcars)) 

# Basic Scatterplot Matrix
pairs(~mpg+disp+drat+wt,data=mtcars, main="Simple Scatterplot Matrix")


# Scatterplot Matrices from the car Package
scatterplot.matrix(~mpg+disp+drat+wt|cyl, data=mtcars, main="Three Cylinder Options")

# 3D Scatterplot
scatterplot3d(wt,disp,mpg, main="3D Scatterplot")

# 3D Scatterplot with Coloring and Vertical Drop Lines
scatterplot3d(wt,disp,mpg, pch=16, highlight.3d=TRUE, type="h", main="3D Scatterplot") 


# 3D Scatterplot with Coloring and Vertical Lines
# and Regression Plane
s3d <-scatterplot3d(wt,disp,mpg, pch=16, highlight.3d=TRUE, type="h", main="3D Scatterplot")
fit <- lm(mpg ~ wt+disp)
s3d$plane3d(fit)


