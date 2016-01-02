# Apply all set of grep expressions to character vector x
# Using baseExpr() as default
checkGrepCall <- function(x, expr = baseExpr(), perl=TRUE) {
	if (class(expr) == "grepExpr") {
		e <- expr$expr
		type <- expr$type
	} else {
		if (class(expr) != "character") {
			stop ('character vector expected for grep expressions')
		} else {
			e <- expr
			type <- expr		
		}
	}
	y <- sapply(e, FUN = grepl, x, perl = perl)
	colnames(y) <- type
	l <- list()
	l$y <- y
	l$rowsum <- rowSums(y)
	print(l$rowsum)
	invisible(l)
}

g <- checkGrepCall(x)


grepTableSet <- function(data, expr = TRUE, alt = TRUE, groups = "all", perl = TRUE, ...) {
	if(class(data) != "list") {
		if(class(data) == "data.frame") 
			d <- data
			data <- list()
			data[[1]] <- d
		} else {
			stop ('formatted tables are expected in a list format')
		}
	} 
}

grepTable <- function(x, 