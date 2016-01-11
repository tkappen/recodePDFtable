# Apply all set of grep expressions to character vector x
# Using baseExpr() as default
# rowtype = TRUE, returns only the rowtype variable
checkGrepCall <- function(x, expr = baseExpr(), perl=TRUE, rowtype=FALSE) {
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
	l$y.matrix <- y
	l$rowsum <- rowSums(y)
	l$uniqueGrep <- all(l$rowsum == 1)
	l$rowType <- as.null()
	# When each cell of the column has a single Grep expression matched
	# then a list with the associated Grep Types are returned
	if(l$uniqueGrep == TRUE) {
		m <- which(y, arr.ind=TRUE)
		rowType <- type[m[order(m[,1]),2]]
		l$rowType <- rowType
	}
	if (rowtype==TRUE) {
		invisible(rowType)
	} else {
		invisible(l)
	}
}

# For each (appropraite) column within a table
# startCol is used to define at which column the data starts
# Unless 'cols' has been used to indicate which columns to use
# it then overrides startCol
checkGrepTable <- function(x, startCol = 2, cols = NA, expr = baseExpr(), perl=TRUE, ...) {
	if (!class(x) %in% c("data.frame","matrix","table")) stop('Dataframe, matrix or table expected')
	if (!is.numeric(startCol)) stop('Variable cols invalid: numeric vector expected')
	if (!class(x) %in% c("data.frame", "table", "matrix")) stop('Dataframe, matrix or table expected for x')

	if (is.numeric(cols)) {
		k <- cols
	} else {
		k <- startCol:dim(x)[2]
	}
	if(length(k)==1) {
		y <- checkGrepCall(x[,k], expr = expr, ...)
	} else {
		y <- apply(x[,k], 2, FUN = checkGrepCall, ...)
	}
	return(y)
}	



# Go through a whole set of tables
grepTableSet <- function(d, expr = TRUE, cols = NA, alt = TRUE, groups = "all", perl = TRUE, ...) {
	if (expr == TRUE) expr <- baseExpr()
	if(class(d) == "tableList") {
		x <- d[2,]
		d <- d[1,]
		col <- sapply(x, function(x) x$startCol)
		t <- mapply(checkGrepTable, x = d, startCol = col,
			MoreArgs = list(expr = expr), ...)
	} else if(class(d) == "data.frame") {
		if(!is.numeric(cols)) cols <- c(1:dim(d)[2])
		t <- checkGrepTable(d, cols = cols, expr = expr, ...)
	} else {
		stop ('formatted tables are expected in a dataframe or a list of dataframes')
	}
	return (t)
}


# Find out if the values of a table are not yet matched by a single grep expression
# (not yet mean no match or >1 match)
findTrue <- function (x) {
	if (is.null(x$uniqueGrep)) {
		z <- sapply(x, function(z) z$uniqueGrep)
		all(z==TRUE)
	} else {
		x$uniqueGrep
	}
}

# Apply findTrue to all datasets
# and returns the Table names for which no single
# grep expression was matched
matchedTable <- function(x, ...) {
	x <- grepTableSet(x)
	m <- sapply(x, findTrue)
	m <- as.data.frame(m)
	y <- which(m==FALSE, arr.ind=TRUE)
	if(dim(y)[1] == 0) {
		cat("All cells of all tables are matched to a single grep expression\n")
	} else {
		return(y)
	}
}
