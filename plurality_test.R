require(ggplot2)

#data copied from Java code output
data <- data.frame("num_of_voters" = rep(c(10^1, 10^2, 10^4, 10^6), 
                                         each=5),
                   "num_of_cands" = rep(c(2, 3, 5, 10, 20), 4),
                   "critical_val" = c(6, 4, 3, 2, 2, 20, 13, 9, 5, 4, 198, 126,
                                      81, 48, 30, 1954, 1234, 788, 416, 254))

#create column to show critical values as a proportion of number of voters
data[,"critical_proportion"] = data[,"critical_val"] / data[,"num_of_voters"]

#
data[,"voter_levels"] = as.factor(data[,"num_of_voters"])
data[,"cand_levels"] = as.factor(data[,"num_of_cands"])

plot1 <- ggplot(data, aes(x=num_of_cands, y=critical_proportion,
                          color=voter_levels)) + geom_line() + geom_point(size=2) +
         ggtitle("number of candidates vs. critical value as proportion \nof number of voters") +
         xlab("number of candidates") + 
         ylab("critical value / number of voters") +
         labs(color = "number of voters")
plot1

#functions for making axis labels more readable
f1 <- function(x) log(x, 10)
f2 <- function(x) round(x, 2)

plot2 <- ggplot(data, aes(x=num_of_voters, y=critical_proportion,
                          color=cand_levels)) + geom_line() + geom_point(size=2) +
         ggtitle("log of number of voters vs. critical value as \nproportion of number of voters") +
         scale_x_continuous(trans="log10", labels=f1, breaks=c(10, 100, 10000, 1000000)) +
         xlab("log10(number of voters)") + 
         ylab("critical value / number of voters") +
         labs(color = "number of candidates")
plot2

plot3 <- ggplot(data, aes(x=num_of_voters, y=critical_proportion,
                      color=cand_levels)) + geom_line() + geom_point(size=2) +
         ggtitle("log of number of voters vs. critical value as \nproportion of number of voters (log scale)") +
         scale_x_continuous(trans="log10", labels=f1, breaks=c(10, 100, 10000, 1000000)) +
         scale_y_continuous(trans="log2", labels=f2) +
         xlab("log10(number of voters)") + 
         ylab("critical value / number of voters") +
         labs(color = "number of candidates")
plot3
