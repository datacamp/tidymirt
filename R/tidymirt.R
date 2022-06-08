#' @importFrom dplyr rename %>% as_tibble
.format_fit_coef_entry <- function(x) {
  d <- as_tibble(t(x), rownames = 'term') %>%
    rename(estimate = par)

  if (any(stringr::str_detect(names(d), "CI_")))
    d <- rename(d, conf.low = CI_2.5, conf.high = CI_97.5)

  d
}


#' Convert MIRT SingleGroupClass to tidy tibble
#'
#' @param x mirt model (often returned by mirt() function)
#' @param group_pars whether to include non-item parameters (e.g. latent mean or covariance)
#' @param ... passed along with model to coef method
#' @return tibble with columns for item_number, item, term (e.g. a1, d), estimate
#' @examples
#' # We'll use examples from the mirt library (see ?mirt)
#' library(mirt)
#'
#' #load mirt library LSAT section 7 data
#' data <- expand.table(LSAT7)
#'
#' # one-factor model
#' mod1 <- mirt(data, 1)
#' tidy(mod1)
#' tidy(mod1, group_pars = FALSE)      # only item parameters
#'
#' # two-factor model
#' mod2 <- mirt(data, 2)
#' tidy(mod2)
#'
#'
#' @importFrom dplyr filter %>% tibble
#' @importFrom tidyr unnest
#' @importFrom broom tidy
#' @export
tidy.SingleGroupClass <- function(x, group_pars = TRUE, ...) {
  # most common MIRT fit object
  excluded <- if (!group_pars) c("GroupPars", "lr.betas") else c()

  coef(x, ...) %>%
    tibble(item_number = 1:length(.), item = names(.), values = .) %>%
    filter(!item %in% excluded) %>%
    mutate(values = lapply(values, .format_fit_coef_entry)) %>%
    unnest(values)
}


#' Summarize useful model information, for fitted mirt model
#'
#' This function uses mirt's extract.mirt to pull out measures, so
#' see that function for other measures you could get.
#'
#' @param x mirt model (often returned by mirt() function)
#' @param ... ignored
#'
#' @return tibble with columns for TODO
#' @examples
#' # We'll use examples from the mirt library (see ?mirt)
#' library(mirt)
#'
#' #load mirt library LSAT section 7 data
#' data <- expand.table(LSAT7)
#'
#' # one-factor model
#' mod1 <- mirt(data, 1)
#' glance(mod1)
#'
#' # two-factor model
#' mod2 <- mirt(data, 2)
#' glance(mod2)
#'
#' @importFrom mirt extract.mirt
#' @importFrom broom glance
#' @export
glance.SingleGroupClass <- function(x, ...) {
  # measures mirt returns by default from anova method
  pars_anova <- c("AIC", "AICc", "SABIC", "HQ", "BIC", "logLik")

  # other useful to have model summaries
  pars_other <- c("nfact", "nitems", "ngroups", "nest", "df", "converged")

  all_pars <- c(pars_other, pars_anova)

  measures <- lapply(all_pars, function(what) extract.mirt(x, what))
  names(measures) <- all_pars

  as_tibble(measures)
}
