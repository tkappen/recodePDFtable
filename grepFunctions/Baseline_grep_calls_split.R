# Apply pattern over a cell and return its value as
# a numeric value
getGrepNum <- function(pattern, x, perl=TRUE,...) {
	y <- NA
	if (!is.na(pattern)){
		g <- gregexpr(pattern, x, perl=TRUE)
		y <- regmatches(x, g)
	}
	return(as.numeric(y))
}

# Apply a single pattern (through getGrepNum) over a
# column (vector) formatted table values
splitGrepNum <- function(pattern, x, perl=TRUE,...) {
	y <- mapply(pattern, x, FUN = getGrepNum,  perl=perl)
	return(y)
}

# Apply multiple matterns over a single column/vector
# of formatted table values
colGrepNum <- function(x, patterns, row.names, asMatrx = FALSE, perl=TRUE, ...) {
	nr.cols <- length(patterns)
	z <- replicate(nr.cols, x)
	z <- as.list(as.data.frame(z, stringsAsFactors=FALSE))
	if(asMatrx==TRUE){
		y <- mapply(patterns, z, FUN = splitGrepNum,  
			perl=perl, SIMPLIFY = "array")
		row.names(y) <- row.names
		return(y)
	} else {
		y <- mapply(patterns, z, FUN = splitGrepNum,  perl=perl)
		return(cbind(x,as.data.frame(y, row.names = row.names)))
	}
}

# A function that maps a vector of expression types
# to their actual expressions
typetoExpr <- function(x) {
	expr = baseExprSub()[,-1]
	return(as.list(expr[x,]))
}

# A function that maps multiple columns of expression types
# to their actual expressions
colstoExpr <- function(x) {
	y <- apply(x, 2, typetoExpr)
	return(y)
}

# Apply an array of types/expressions to recode one table
# with a left variable name column (otherwise specify cols)
# expr = "base" use baseExprSub() as the input for type
# otherwise expr can be a list of array with patterns to match to
# (probably not the easiest thing to do.
#
# type has to be a vector of type for each column of the table
# so that the expression can be looked up in baseExprSub()
# The type vectors can be generated through grepTableSet()
# asMatrx determines whether the tables are returned as multidimensional array
colsGrepNum <- function(x,  type, expr = "base",
		startCol = 2, cols = NULL, row.names = NULL, perl=TRUE, asMatrx = FALSE, ...) {
	e <- expr
	if (is.numeric(cols)) {
		k <- cols
	} else {
		k <- startCol:dim(x)[2]
	}
	d <- x[,k]
	if(is.null(row.names)) {
		row.names <- x[,1]
	}
	if(length(k) != dim(as.data.frame(type))[2]) {
		stop("Number of columns in table and type do not match")
 	}

	d <- as.list(as.data.frame(d, stringsAsFactors=FALSE))
	if(length(k)==1) {
		if(expr=="base"){
			e <- typetoExpr(type)
		}
		y <- colGrepNum(patterns = e, x = d,
			perl = TRUE, row.names = row.names, asMatrx = asMatrx)
	} else {
		if(expr=="base"){
			e <- colstoExpr(type)
		}
		simple <- FALSE
		if(asMatrx==TRUE){
			simple <- "array"
		}
		y <- mapply(patterns = e, x = d, colGrepNum,
			perl = TRUE, SIMPLIFY=simple,
			MoreArgs = list(row.names = row.names, asMatrx = asMatrx))
	}
	return(y)
}

# Apply colsGrepNum to each table of a list of tables and 
# use grepTableSet to get the matching classification for pattern type
tableGrepNum <- function(x, expr = "base", type = "base", asMatrx = FALSE, ...) {
	if(type=="base"){
		type <- grepTableSet(x, rowtype=TRUE)
	} 
	if(class(x)=="tableList") {
		x <- x[1,]
	}
	y <- mapply(x = x, type = type, colsGrepNum, asMatrx = asMatrx, ...)
	class(y)  <- "splitTableListDF"
	if (asMatrx == TRUE) class(y)  <- "splitTableListMatrix"
	return(y)
}


