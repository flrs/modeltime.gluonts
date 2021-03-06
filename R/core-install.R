#' Install GluonTS
#'
#' Installs `GluonTS` Probabilisitic Deep Learning Time Series Forecasting Software
#' using `reticulate::py_install()`.
#' - A `Python` Environment will be created
#' named `r-gluonts`.
#' - The Modletime GluonTS R package will connect to the `r-gluonts` Python environment
#'
#' @details
#'
#' __Options for Connecting to Python__
#'
#' - __Recommended__ _Use Pre-Configured Python Environment:_ Use `install_gluonts()` to
#'    install GluonTS Python Libraries into a conda environment named 'r-gluonts'.
#' - __Advanced__ _Use a Custom Python Environment:_ Before running `library(modeltime.gluonts)`,
#'    use `Sys.setenv(GLUONTS_PYTHON = 'path/to/python')` to set the path of your
#'    python executable in an environment that has 'gluonts', 'mxnet', 'numpy', 'pandas',
#'    and 'pathlib' available as dependencies.
#'
#' __Package Manager Support (Python Environment)__
#'
#' - __Conda Environments:__ Currently, `install_gluonts()` supports Conda and Miniconda Environments.
#'
#' - __Virtual Environments:__ are not currently supported with the default installation method, `install_gluonts()`.
#'    However, you can connect to virtual environment that you have created using
#'     `Sys.setenv(GLUONTS_PYTHON = 'path/to/python')` prior to running `library(modeltime.ensemble)`.
#'
#' @examples
#' \dontrun{
#' install_gluonts()
#' }
#'
#'
#' @export
install_gluonts <- function() {

    if (!check_conda()) {
        return()
    }

    method <- "conda"

    default_pkgs <- c(
        "mxnet==1.6",
        "gluonts==0.6.3",
        "numpy==1.16.6",
        "pandas==1.0.5",
        "scikit-learn==0.23.2",
        "matplotlib==3.3.2",
        "seaborn==0.11.0",
        "pathlib==1.0.1"
    )

    cli::cli_process_start("Installing gluonts python dependencies...")
    message("\n")
    reticulate::py_install(
        packages       = default_pkgs,
        envname        = "r-gluonts",
        method         = method,
        conda          = "auto",
        python_version = "3.6",
        pip            = TRUE
    )

    if (!is.null(detect_default_gluonts_env())) {
        cli::cli_process_done(msg_done = "The {.field r-gluonts} conda environment has been created.")
        cli::cli_alert_info("Please restart your R Session and run {.code library(modeltime.gluonts)} to activate the {.field r-gluonts} environment.")
    } else {
        cli::cli_process_failed(msg_failed = "The {.field r-gluonts} conda environment could not be created.")
    }

}


check_conda <- function() {

    conda_list_nrow <- nrow(reticulate::conda_list())

    if (is.null(conda_list_nrow) || conda_list_nrow == 0L) {
        # No conda
        message("Could not detect Conda or Miniconda Package Managers, one of which is required for 'install_gluonts()'. \nAvailable options:\n",
                " - [Preferred] You can install Miniconda (light-weight) using 'reticulate::install_miniconda()'. \n",
                " - Or, you can install the full Aniconda distribution (1000+ packages) using 'reticulate::conda_install()'. \n\n",
                "Then use 'install_gluonts()' to set up the GluonTS python environment.")
        conda_found <- FALSE
    } else {
        conda_found <- TRUE
    }

    return(conda_found)
}

