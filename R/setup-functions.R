#' Retrieve subreddit posts and bring into R
#'
#' Write more about \code{get_posts()} here.
#' @param subreddit
#' @param max_posts
#' @param starting_point
#' @param starting_data
#' @return A tibble of subreddit posts and associated metadata
#' @seealso Read more about \href{https://github.com/reddit-archive/reddit/wiki/API}{OAuth2 authentication for the Reddit API}
#'   and \href{https://www.reddit.com/prefs/apps}{creating your own appication key}.
#' @examples
#'
#' \dontrun{
#'
#' get_posts("education")
#' get_posts("instructionaldesign", max_posts = 10)
#' }
#' @export
get_posts <-
  function(subreddit, max_posts = 100, starting_point = "", starting_data = NULL) {
    if (max_posts > 1000) {max_posts <- 1000}

    authentication <-
      httr::POST(
        url = "https://www.reddit.com/api/v1/access_token",
        httr::add_headers("User-Agent" = Sys.getenv('reddit_user_agent')),
        httr::authenticate(Sys.getenv('reddit_client_id'),
                           Sys.getenv('reddit_client_token')
        )
      )

    httr::stop_for_status(authentication, "authenticate with Reddit")

    subreddit_response <-
      httr::GET(
        url = paste0("https://www.reddit.com/r/", subreddit,
                     "/new.json?limit=100&after=",
                     starting_point),
        httr::add_headers("User-Agent" = Sys.getenv('reddit_user_agent')),
        httr::authenticate(Sys.getenv('reddit_client_id'),
                           Sys.getenv('reddit_client_token')
        )
      )

    subreddit_page <- jsonlite::fromJSON(httr::content(subreddit_response, as = "text"))

    #subreddit_page <- jsonlite::fromJSON(url)

    subreddit_data <- starting_data

    if (!exists("subreddit_data")) {
      subreddit_data <- tibble::as_tibble(subreddit_page$data$children$data)
    } else {
      subreddit_data <-
        dplyr::bind_rows(subreddit_data,
                         tibble::as_tibble(subreddit_page$data$children$data)
        )
    }

    message(paste(nrow(subreddit_data), "posts found so far..."))

    if (nrow(subreddit_data) >= max_posts) {

      message(paste("Done retrieving. Returned", nrow(subreddit_data), "posts in total."))
      return(subreddit_data)

    } else {

      message("Going to sleep...")
      Sys.sleep(60)  # Wait 60 seconds before running again to keep below API rate limit
      message("Waking up...")

      get_posts(subreddit = subreddit_data$subreddit[1],
                starting_data = subreddit_data,
                starting_point = paste0("t3_", tail(subreddit_data$id, 1))
      )
    }

  }

#' Clean and shape subreddit data
#'
#' Write more about \code{clean_posts()} here.
#' @param subreddit
#' @param max_posts
#' @param starting_point
#' @param starting_data
#' @return A tibble of subreddit posts and associated metadata
#' @seealso Read more about \href{https://github.com/reddit-archive/reddit/wiki/API}{OAuth2 authentication for the Reddit API}
#'   and \href{https://www.reddit.com/prefs/apps}{creating your own appication key}.
#' @examples
#'
#' \dontrun{
#'
#' example_posts <- get_posts("education")
#' example_posts <- clean_posts(example_posts)
#' min(example_posts$post_date_time)  # Returns date-time of earliest post
#' }
#' @export
clean_posts <- function(x) {
  x <- dplyr::rename(x, post_date_time = created_utc)

  x <-
    dplyr::mutate(
      x,
      post_date_time = anytime::anytime(post_date_time, asUTC=TRUE),
      post_date_time = lubridate::ymd_hms(lubridate::as_datetime(post_date_time)),
      post_date_time = lubridate::with_tz(post_date_time, tzone='US/Eastern')
    )
}
