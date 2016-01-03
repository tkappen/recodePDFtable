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
	l$y.matrix <- y
	l$rowsum <- rowSums(y)
	l$uniqueGrep <- all(l$rowsum == 1)
	l$rowType <- as.null()
	if(l$uniqueGrep == TRUE) {
		m <- which(y, arr.ind=TRUE)
		rowType <- type[m[order(m[,1]),2]]
		l$rowType <- rowType
	}
	
	invisible(l)
}


checkGrepTable <- function(x, startCol = 2, cols = NA, expr = baseExpr(), perl=TRUE) {
	if (!class(x) %in% c("data.frame","matrix","table")) stop('Dataframe, matrix or table expected')
	if (!is.numeric(startCol)) stop('Variable cols invalid: numeric vector expected')
	if (!class(x) %in% c("data.frame", "table", "matrix")) stop('Dataframe, matrix or table expected for x')

	if (is.numeric(cols)) {
		k <- cols
		y <- checkGrepCall(x[,k], expr = expr)
	} else {
		k <- startCol:dim(x)[2]
		if(length(k)==1) {
			y <- checkGrepCall(x[,k], expr = expr)
		} else {
			y <- apply(x[,k], 2, FUN = checkGrepCall)
		}
	}
	return(y)
}	




grepTableSet <- function(d, expr = TRUE, cols = NA, alt = TRUE, groups = "all", perl = TRUE, ...) {
	if (expr == TRUE) expr <- baseExpr()
	if(class(d) == "tableList") {
		x <- d[2,]
		d <- d[1,]
		col <- sapply(x, function(x) x$startCol)
		t <- mapply(checkGrepTable, x = d, startCol = col,
			MoreArgs = list(expr = expr))
	} else if(class(d) == "data.frame") {
		if(!is.numeric(cols)) cols <- c(1:dim(d)[2])
		t <- checkGrepTable(d, cols = cols, expr = expr)
	} else {
		stop ('formatted tables are expected in a dataframe or a list of dataframes')
	}
	return (t)
}



