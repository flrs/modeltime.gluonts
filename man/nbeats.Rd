% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parsnip-nbeats.R
\name{nbeats}
\alias{nbeats}
\title{General Interface for N-BEATS Time Series Models}
\usage{
nbeats(
  mode = "regression",
  id,
  freq,
  prediction_length,
  lookback_length = NULL,
  loss_function = NULL,
  bagging_size = NULL,
  num_stacks = NULL,
  num_blocks = NULL,
  epochs = NULL,
  batch_size = NULL,
  num_batches_per_epoch = NULL,
  learn_rate = NULL,
  learn_rate_decay_factor = NULL,
  learn_rate_min = NULL,
  patience = NULL,
  clip_gradient = NULL,
  penalty = NULL,
  scale = NULL
)
}
\arguments{
\item{mode}{A single character string for the type of model.
The only possible value for this model is "regression".}

\item{id}{A quoted column name that tracks the GluonTS FieldName "item_id"}

\item{freq}{A \code{pandas} timeseries frequency such as "5min" for 5-minutes or "D" for daily.
Refer to \href{https://pandas.pydata.org/pandas-docs/stable/user_guide/timeseries.html#offset-aliases}{Pandas Offset Aliases}.}

\item{prediction_length}{Numeric value indicating the length of the prediction horizon}

\item{lookback_length}{Number of time units that condition the predictions Also known as 'lookback period'. Default is 2 * prediction_length.}

\item{loss_function}{The loss function (also known as metric) to use for training the network. Unlike other models in GluonTS this network does not use a distribution. One of the following: "sMAPE", "MASE" or "MAPE". The default value is "MAPE".}

\item{bagging_size}{(Applicable to Ensemble N-Beats). The number of models that share the parameter combination of 'context_length' and 'loss_function'.
Each of these models gets a different initialization random initialization. Default and recommended value: 10.}

\item{num_stacks}{The number of stacks the network should contain. Default and recommended value for generic mode: 30 Recommended value for interpretable mode: 2}

\item{num_blocks}{The number of blocks per stack. A list of ints of length 1 or 'num_stacks'. Default and recommended value for generic mode: 1. Recommended value for interpretable mode: 3.}

\item{epochs}{Number of epochs that the network will train (default: 5).}

\item{batch_size}{Number of examples in each batch (default: 32).}

\item{num_batches_per_epoch}{Number of batches at each epoch (default: 50).}

\item{learn_rate}{Initial learning rate (default: 10-3).}

\item{learn_rate_decay_factor}{Factor (between 0 and 1) by which to decrease the learning rate (default: 0.5).}

\item{learn_rate_min}{Lower bound for the learning rate (default: 5x10-5 ).}

\item{patience}{The patience to observe before reducing the learning rate, nonnegative integer (default: 10).}

\item{clip_gradient}{Maximum value of gradient. The gradient is clipped if it is too large (default: 10).}

\item{penalty}{The weight decay (or L2 regularization) coefficient. Modifies objective by adding a penalty for having large weights (default 10-8 ).}

\item{scale}{Scales numeric data by \code{id} group using mean = 0, standard deviation = 1 transformation. (default: FALSE)}
}
\description{
\code{nbeats()} is a way to generate a \emph{specification} of a N-BEATS model
before fitting and allows the model to be created using
different packages. Currently the only package is \code{gluonts}.
There are 2 N-Beats implementations: (1) Standard N-Beats, and (2) Ensemble N-Beats.
}
\details{
These arguments are converted to their specific names at the time that
the model is fit. Other options and arguments can be set using
\code{set_engine()}. If left to their defaults here (see above),
the values are taken from the underlying model functions.
If parameters need to be modified, \code{update()} can be used in lieu of recreating
the object from scratch.

The model can be created using the fit() function using the following engines:
\itemize{
\item \strong{GluonTS N-BEATS:} "gluonts_nbeats" (the default)
\item \strong{GluonTS N-BEATS Ensemble:} "gluonts_nbeats_ensemble"
}
}
\section{Engine Details}{


The standardized parameter names in \code{modeltime} can be mapped to their original
names in each engine:\tabular{lll}{
   modeltime \tab NBEATSEstimator \tab NBEATSEnsembleEstimator \cr
   id \tab ListDataset('item_id') \tab ListDataset('item_id') \cr
   freq \tab freq \tab freq \cr
   prediction_length \tab prediction_length \tab prediction_length \cr
   lookback_length \tab context_length (= 2 x prediction_length) \tab meta_context_length (= prediction_length x c(2,4)) \cr
   bagging_size \tab NA \tab meta_bagging_size (3) \cr
   loss_function \tab loss_function ('sMAPE') \tab meta_loss_function (list('sMAPE')) \cr
   num_stacks \tab num_stacks (30) \tab num_stacks (30) \cr
   num_blocks \tab num_blocks (list(1)) \tab num_blocks (list(1)) \cr
   epochs \tab epochs (5) \tab epochs (5) \cr
   batch_size \tab batch_size (32) \tab batch_size (32) \cr
   num_batches_per_epoch \tab num_batches_per_epoch (50) \tab num_batches_per_epoch (50) \cr
   learn_rate \tab learning_rate (0.001) \tab learning_rate (0.001) \cr
   learn_rate_decay_factor \tab learning_rate_decay_factor (0.5) \tab learning_rate_decay_factor (0.5) \cr
   learn_rate_min \tab minimum_learning_rate (5e-5) \tab minimum_learning_rate (5e-5) \cr
   patience \tab patience (10) \tab patience (10) \cr
   clip_gradient \tab clip_gradient (10) \tab clip_gradient (10) \cr
   penalty \tab weight_decay (1e-8) \tab weight_decay (1e-8) \cr
   scale \tab scale_by_id (FALSE) \tab scale_by_id (FALSE) \cr
}


Other options can be set using \code{set_engine()}.
}

\section{Engine}{
 gluonts_nbeats

The engine uses \code{gluonts.model.n_beats.NBEATSEstimator()}.
Default values that have been changed to prevent long-running computations:
\itemize{
\item \code{epochs = 5}: GluonTS uses 100 by default.
\item \code{loss_function = 'sMAPE'}: GluonTS by default uses MAPE. MAPE can suffer from issues with small values.
}

\emph{Required Parameters}

The \code{gluonts_nbeats} implementation has several \emph{Required Parameters},
which are user-defined.

\emph{1. ID Variable (Required):}

An important difference between other parsnip models is that
each time series (even single time series) must be uniquely identified
by an ID variable.
\itemize{
\item The ID feature must be of class \code{character} or \code{factor}.
\item This ID feature is provided as a quoted expression
during the model specification process (e.g. \code{nbeats(id = "ID")} assuming
you have a column in your data named "ID").
}

\emph{2. Frequency (Required):}

The GluonTS models use a Pandas Timestamp Frequency \code{freq} to generate
features internally. Examples:
\itemize{
\item \code{freq = "5min"} for timestamps that are 5-minutes apart
\item \code{freq = "D"} for Daily Timestamps
}

The Pandas Timestamps are quite flexible.
Refer to \href{https://pandas.pydata.org/pandas-docs/stable/user_guide/timeseries.html#offset-aliases}{Pandas Offset Aliases}.

\emph{3. Prediction Length (Required):}

Unlike other parsnip models, a \code{prediction_length} is required
during the model specification and fitting process.

 gluonts_nbeats_ensemble

The engine uses \code{gluonts.model.n_beats.NBEATSEnsembleEstimator()}.

\emph{Number of Models Created}

This model is very good, but can be expensive (long-running) due to the number of models that are being created.
The number of models follows the formula:

\verb{length(lookback_length) x length(loss_function) x meta_bagging_size}

The default values that have been changed from GluonTS implementation to prevent long-running computations:
\itemize{
\item \code{epochs = 5}: GluonTS uses 100 by default.
\item \code{lookback_length = prediction_length * c(2, 4)}. GluonTS uses range of 2:7, which doubles the number of models created.
\item \code{bagging_size = 3}: Averages 5 like models together. GluonTS uses 10, which doubles the number of models created.
\item \code{loss_function = 'sMAPE'}: GluonTS uses 3 \code{meta_loss_function = list('sMAPE', 'MASE', 'MAPE')},
which 3X's (triples) the number of models created.
}

The result is: 2 x 1 x 3 = \strong{6 models.} Each model will have 5 epochs by default.

\emph{Required Parameters}

The \code{gluonts_nbeats_ensemble} implementation has several \emph{Required Parameters},
which are user-defined.

\emph{1. ID Variable (Required):}

An important difference between other parsnip models is that
each time series (even single time series) must be uniquely identified
by an ID variable.
\itemize{
\item The ID feature must be of class \code{character} or \code{factor}.
\item This ID feature is provided as a quoted expression
during the model specification process (e.g. \code{nbeats(id = "ID")} assuming
you have a column in your data named "ID").
}

\emph{2. Frequency (Required):}

The GluonTS models use a Pandas Timestamp Frequency \code{freq} to generate
features internally. Examples:
\itemize{
\item \code{freq = "5min"} for timestamps that are 5-minutes apart
\item \code{freq = "D"} for Daily Timestamps
}

The Pandas Timestamps are quite flexible.
Refer to \href{https://pandas.pydata.org/pandas-docs/stable/user_guide/timeseries.html#offset-aliases}{Pandas Offset Aliases}.

\emph{3. Prediction Length (Required):}

Unlike other parsnip models, a \code{prediction_length} is required
during the model specification and fitting process.
}

\section{Fit Details}{


The following features are REQUIRED to be available in the incoming data for the
fitting process.
\itemize{
\item \strong{Fit:} \code{fit(y ~ date + id, data)}: Includes a target feature that is a
function of a "date" and "id" feature. The ID feature must be pre-specified
in the model_specification.
\item \strong{Predict:} \code{predict(model, new_data)} where \code{new_data} contains both
a column named "date" and "id".
}

\strong{ID Variable}

An ID feature must be included in the recipe or formula fitting
process. This assists with cataloging the time series inside \code{GluonTS} ListDataset.
The column name must match the quoted feature name specified in the
\code{nbeats(id = "id")} expects a column inside your data named "id".

\strong{Date and Date-Time Variable}

It's a requirement to have a date or date-time variable as a predictor.
The \code{fit()} interface accepts date and date-time features and handles them internally.
}

\examples{
\donttest{
library(tidymodels)
library(tidyverse)
library(timetk)


# ---- MODEL SPEC ----
# - Important: Make sure *required* parameters are provided
model_spec <- nbeats(

    # User Defined (Required) Parameters
    id                    = "id",
    freq                  = "M",
    prediction_length     = 24,

    # Hyper Parameters
    epochs                = 1,
    num_batches_per_epoch = 4
) \%>\%
    set_engine("gluonts_nbeats")

model_spec

# ---- TRAINING ----
# Important: Make sure the date and id features are included as regressors
#  and do NOT dummy the id feature.
model_fitted <- model_spec \%>\%
    fit(value ~ date + id, m750)

model_fitted

# ---- PREDICT ----
# - IMPORTANT: New Data must have id and date features
new_data <- tibble(
    id   = factor("M750"),
    date = as.Date("2015-07-01")
)

predict(model_fitted, new_data)
}

}
\seealso{
\code{\link[=fit.model_spec]{fit.model_spec()}}, \code{\link[=set_engine]{set_engine()}}
}
