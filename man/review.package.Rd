% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rStuff.R
\name{review.package}
\alias{review.package}
\title{Prepare a practice environment}
\usage{
review.package(pkg = character())
}
\arguments{
\item{pkg}{character: name of the package}
}
\value{
There is no return value. The side effects of the function call
a change of the working directory (where applicable) and the opening of
the documentation for that package.
}
\description{
Reviews a package by opening its documentation, navigating to the relevant
working directory (if necessary).
}
