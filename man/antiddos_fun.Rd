% Generated by roxygen2: do not edit by hand
\name{antiddos_fun}
\alias{antiddos}
\alias{antiddos_fun}
\title{Anti DDoS}
\usage{
antiddos_fun(source_system, antiddos.sec = getOption("Rbitcoin.antiddos.sec",
  10), antiddos.verbose = getOption("Rbitcoin.antiddos.verbose", 0),
  verbose = getOption("Rbitcoin.verbose", 0))
}
\arguments{
\item{source_system}{character, a unique name of source system, could be any name \code{c('kraken','bitstamp','blockchain','alt_bitstamp')}}

\item{antiddos.sec}{numeric time in seconds between API calls on the particular source system, defeault \code{getOption("Rbitcoin.antiddos.sec",10)}.}

\item{antiddos.verbose}{integer, Rbitcoin antiddos verbose message. Should be used when user prefer \code{verbose=0} but still wants to see antiddos waiting time.}

\item{verbose}{integer. Rbitcoin processing messages, print to console if \code{verbose > 0}, each subfunction reduce \code{verbose} by 1. If missing then \code{getOption("Rbitcoin.verbose",0)} is used.}
}
\value{
numeric time of wait in seconds.
}
\description{
Wait if necessary before next API call to market (or any other source system) to do not get banned.
}
\details{
The following options can control antiddos process:
\itemize{
\item \code{getOption("Rbitcoin.antiddos",TRUE)}
\item \code{getOption("Rbitcoin.antiddos.sec",10)} seconds to wait between calls to the same system
\item \code{getOption("Rbitcoin.antiddos.fun",antiddos_fun)} - custom antiddos function. Default the one documentated on this site.
}
}
\note{
Rbitcoin built-in antiddos function handle only api calls launched within the current R session.
By default it will wait \code{getOption("Rbitcoin.antiddos.sec",10)} seconds between calls to the same system.
It cache the api calls in \code{Rbitcoin.last_api_call} environment object in current workspace.
User can provide own custom antiddos function using \code{getOption("Rbitcoin.antiddos.fun",antiddos_fun)}.
This way it is possible to cache last api call in own data storage (like database), this can allow concurrent R sessions + queueing to be handled by the antiddos process.
Custom antiddos should return numeric value of time spent on antiddos waiting in seconds.
}
\section{Side effect}{

Environment of name \code{Rbitcoin.last_api_call} which holds the timestamps of last api call per \code{source_system} during the R session.
}
\examples{
\dontrun{
# run below code in a batch
options("Rbitcoin.antiddos.verbose"=1) # alternatively: options("Rbitcoin.verbose" = 3)
market.api.process('kraken',c('BTC','EUR'),'ticker')
market.api.process('kraken',c('BTC','LTC'),'ticker')
options("Rbitcoin.antiddos.verbose"=0)
}
}
\seealso{
\code{\link{market.api.process}}, \code{\link{wallet_manager}}
}

