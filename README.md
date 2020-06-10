
<!-- README.md is generated from README.Rmd. Please edit that file -->

# redditor

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![license](https://img.shields.io/badge/license-GPL3-9cf.svg)](https://www.gnu.org/licenses/gpl.html)

Collection and Analysis of Reddit Data in R

## Overview

The goal of {redditor} is to retrieve recent subreddit data for analysis
in R.

## Installation

Soon, you will be able to install the released version of {redditor}
from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("redditor")
```

You can also install the development version of {redditor} from GitHub
with:

``` r
install.packages("devtools")
devtools::install_github("bretsw/redditor")
```

## Authentication

The Reddit API requires OAuth2 authentication; [read more
here](https://github.com/reddit-archive/reddit/wiki/API). Get started by
create your own appication key at <https://www.reddit.com/prefs/apps>.
Read more about the Reddit API on the [documentation
webpage](https://www.reddit.com/dev/api).

Then save your Reddit API token in the `.Renviron` file as
**reddit\_token**. You can quickly access this file using the R code
`usethis::edit_r_environ(scope='user')`. Add a line to this file that
reads: `reddit_token="PasteYourGoogleKeyInsideTheseQuotes"`. To read
your key into R, use the code `Sys.getenv('reddit_token')`. Note that
{redditor} retrieves your saved API key automatically and securely. Once
you’ve saved the `.Renviron` file, quit your R session and restart.
{redditor} functions will work for you from now on.

If you need to revisit or edit your Reddit application key, simply visit
<https://www.reddit.com/prefs/apps> in a Web browser.

``` r
usethis::edit_r_environ(scope='user')
```

## Usage

The Reddit API rate limit is 60 requests per minute. Each item returned
(e.g., a post) is considered a request. So, using the `get_posts()`
default to retrieve 100 would be considered 100 requests by the API and
requires a pause before running again.

### get\_posts()

### clean\_posts()

## Learning more about {redditor}

For a walkthrough of numerous additional {redditor} functions, visit the
[Using {redditor} with a teaching-related subreddit]() vignette webpage.

## Getting help

{redditor} is still a work in progress, so I fully expect that there are
still some bugs to work out and functions to document better. If you
find an issue, have a question, or think of something that you really
wish {redditor} would do for you, don’t hesitate to [email
Bret](mailto:bret@bretsw.com) or reach out on Twitter:
[@bretsw](https://twitter.com/bretsw).

You can also [file an issue on
Github](https://github.com/bretsw/redditor).

## Future collaborations

This is package is still in development, and I welcome new contributors.
Just reach out through the same channels as “Getting help.”

## License

The {redditor} package is licensed under a *GNU General Public License
v3.0*, or [GPL-3](https://choosealicense.com/licenses/lgpl-3.0/). For
background on why I chose this license, read Hadley Wickham’s take on [R
package licensing](http://r-pkgs.had.co.nz/description.html#license).
