% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/begin_to_end.r
\name{begin_to_end}
\alias{begin_to_end}
\title{Compute the starting point of the dry spell computation at the begining of the rainy season}
\usage{
begin_to_end(x, from = dt_start(x), period = 50, threshold = 0.85)
}
\arguments{
\item{x}{the rainfall vector}

\item{from}{from which element of x to start}

\item{period}{period of time in days from rain start to bloom}

\item{threshold}{the default value of rain quantity to be counted as a rainy day}
}
\value{
result is an integer
}
\description{
dry_spell function compute the end of the rainy season in julian days using water balance methode.
}
\examples{

begin_to_end(x) ## will return le date to which to look for the start of season dry spell

}
