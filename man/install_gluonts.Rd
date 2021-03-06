% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/core-install.R
\name{install_gluonts}
\alias{install_gluonts}
\title{Install GluonTS}
\usage{
install_gluonts()
}
\description{
Installs \code{GluonTS} Probabilisitic Deep Learning Time Series Forecasting Software
using \code{reticulate::py_install()}.
\itemize{
\item A \code{Python} Environment will be created
named \code{r-gluonts}.
\item The Modletime GluonTS R package will connect to the \code{r-gluonts} Python environment
}
}
\details{
\strong{Options for Connecting to Python}
\itemize{
\item \strong{Recommended} \emph{Use Pre-Configured Python Environment:} Use \code{install_gluonts()} to
install GluonTS Python Libraries into a conda environment named 'r-gluonts'.
\item \strong{Advanced} \emph{Use a Custom Python Environment:} Before running \code{library(modeltime.gluonts)},
use \code{Sys.setenv(GLUONTS_PYTHON = 'path/to/python')} to set the path of your
python executable in an environment that has 'gluonts', 'mxnet', 'numpy', 'pandas',
and 'pathlib' available as dependencies.
}

\strong{Package Manager Support (Python Environment)}
\itemize{
\item \strong{Conda Environments:} Currently, \code{install_gluonts()} supports Conda and Miniconda Environments.
\item \strong{Virtual Environments:} are not currently supported with the default installation method, \code{install_gluonts()}.
However, you can connect to virtual environment that you have created using
\code{Sys.setenv(GLUONTS_PYTHON = 'path/to/python')} prior to running \code{library(modeltime.ensemble)}.
}
}
\examples{
\dontrun{
install_gluonts()
}


}
