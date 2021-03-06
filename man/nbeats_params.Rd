% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dials-nbeats_params.R
\name{nbeats_params}
\alias{nbeats_params}
\alias{lookback_length}
\alias{num_stacks}
\alias{num_batches_per_epoch}
\alias{learn_rate_decay_factor}
\alias{scale}
\title{Tuning Parameters for NBEATS Models}
\usage{
lookback_length(range = c(dials::unknown(), dials::unknown()), trans = NULL)

num_stacks(range = c(2, 100), trans = NULL)

num_batches_per_epoch(range = c(2, 100), trans = NULL)

learn_rate_decay_factor(range = c(0, 1), trans = NULL)

scale(values = c(TRUE, FALSE))
}
\arguments{
\item{range}{A two-element vector holding the \emph{defaults} for the smallest and
largest possible values, respectively.}

\item{trans}{A \code{trans} object from the \code{scales} package, such as
\code{scales::log10_trans()} or \code{scales::reciprocal_trans()}. If not provided,
the default is used which matches the units used in \code{range}. If no
transformation, \code{NULL}.}

\item{values}{A character string of possible values.}
}
\description{
Tuning Parameters for NBEATS Models
}
\details{
The main parameters for NBEATS models are:
\itemize{
\item \code{lookback_length}: Number of time units that condition the predictions.
\item \code{num_stacks}: The number of stacks the network should contain.
\item \code{num_batches_per_epoch}: Number of batches at each epoch.
\item \code{learn_rate_decay_factor}: Factor by which to decrease the learning rate.
\item \code{scale}: Scales numeric data by `id' group using mean = 0, standard deviation = 1 transformation.
}
}
