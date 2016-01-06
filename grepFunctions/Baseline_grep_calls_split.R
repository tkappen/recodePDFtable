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
colGrepNum <- function(x, patterns, row.names, perl=TRUE, ...) {
	nr.cols <- length(patterns)
	z <- replicate(nr.cols, x)
	z <- as.list(as.data.frame(z, stringsAsFactors=FALSE))
	y <- mapply(patterns, z, FUN = splitGrepNum,  perl=perl)
	return(cbind(x,as.data.frame(y, row.names = row.names)))
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

# Apply 
# expr = "base" use baseExprSub() as the input for type
# otherwise expr can be a list of array with patterns to match to
# (probably not the easiest thing to do.
#
# type has to be a vector of type for each column of the table
# so that the expression can be looked up in baseExprSub()
# The type vectors can be generated through grepTableSet()
colsGrepNum <- function(x,  type, expr = "base",
		startCol = 2, cols = NA, row.names = NA, perl=TRUE, ...) {
	e <- expr
	if (is.numeric(cols)) {
		k <- cols
	} else {
		k <- startCol:dim(x)[2]
	}
	d <- x[,k]
	if(is.na(row.names)) {
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
			perl = TRUE,row.names = row.names)
	} else {
		if(expr=="base"){
			e <- colstoExpr(type)
		}
		y <- mapply(patterns = e, x = d, colGrepNum,
			perl = TRUE, SIMPLIFY=FALSE,
			MoreArgs = list(row.names = row.names))
	}
	return(y)
	
}


tableGrepNum <- function(x, expr = "base", type = "base", ...) {
	if(type=="base"){
		type <- grepTableSet(x, rowtype=TRUE)
	} 
	if(class(x)=="tableList") {
		x <- x[1,]
	}
	y <- mapply(x = x, type = type, colsGrepNum, ...)
	return(y)
}

tableGrepNum(myfiles)

mapply(patterns = y[[2]], x = d, colGrepNum,
		perl = TRUE, SIMPLIFY=FALSE,
		MoreArgs = list(row.names = row.names))

y <- grepTableSet(myfiles, rowtype=TRUE)
x <- myfiles[1,]
mapply(x = x, type = type, colsGrepNum)

colsGrepNum(x[[2]], type = type[[2]])

dim(as.data.frame(type[[3]]))[2]
e <- colstoExpr(type[[2]])


d <- x[[3]][,2]
row.names <- x[[3]][,1]
e <- typetoExpr(type[[3]])
		}
colGrepNum(patterns = e, x = d,perl = TRUE,row.names = row.names)
		y <- sapply(patterns = e, x = d, colGrepNum,
			perl = TRUE, SIMPLIFY=FALSE,
			MoreArgs = list(row.names = row.names))

e <- baseExprSub()
x <- y[[1]][[1]]$rowType
e1 <- e[x,col.names]
e2 <- as.list(e1)
y1 <- mytables[[1]][,2]
y2 <- as.data.frame(cbind(y1,y1,y1,y1),  stringsAsFactors = FALSE)
names(y2) <- c("y.pattern1","y.pattern2","y.pattern3","y.pattern4")
y2 <- as.list(y2)

x <- y[[1]][[1]]$rowType
col.names <- c("pattern1","pattern2","pattern3","pattern4")
p <- e[x,col.names]
e1[x,]
splitGrepNum(as.character(e1[x,]), y1,)

splitGrepNum(e1[x,1],y1, perl=TRUE)

splitGrepNum(e2[[1]],y2[[1]], perl=TRUE)



g <- gregexpr(p[1],y1, perl=TRUE)
regmatches(y1, g)
# Apply all set of grep expressions to character vector x
# Using baseExprSub() as default
splitGrepCall <- function(x, 
		type = baseExprSub()$type,
		p1 = baseExprSub()$pattern1, 
		p2 = baseExprSub()$pattern2, 
		p3 = baseExprSub()$pattern3, 
		p4 = baseExprSub()$pattern4, 
		perl=TRUE) 
{
	if (class(p1) != "character") stop ('character vector expected for p1')
	if (class(p2) != "character") stop ('character vector expected for p2')
	if (class(p3) != "character") stop ('character vector expected for p3')
	if (class(p4) != "character") stop ('character vector expected for p4')

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
	
	invisible(l)
}