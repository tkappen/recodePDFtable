# Function that generates a list with 
# encoding schemes for different files
encodeList <- function (filelist, baseEncoding = "UTF-8",
	altEncoding = "UTF-8", set = NA) {
		n <- length(filelist)
		x <- rep(baseEncoding, n)
		if (is.numeric(set) & min(set)>0 & max(set)<=n) {
			x[set] <- altEncoding
		} else if (!is.na(set) & !is.numeric(set)) {
			stop('set vector is not a numeric vector')
		} else if (!is.na(set) & (!min(set<=0) | max(set>n))) {
			stop('set vector is out of bounds from file vector')
		}
		x
	}

# Function that reads in multiple datasets
# With possibility for different encoding schemes
# And functionality to verify the structure of the data
read.multi <- function(filelist, FUN = read.csv, 
	baseEncoding = "unknown", baseFileEncoding = "",
	altEncoding = "UTF-8", altFileEncoding = "",
	settoEncode = NA, settoFileEncode = NA, 
	listStruct = NA, ...) {
		if (!is.character(filelist)) stop("a character vector argument
			for 'filelist' expected")
		enc <- encodeList(filelist, baseEncoding, 
			altEncoding, settoEncode)
		fileenc <- encodeList(filelist, baseFileEncoding, 
			altFileEncoding, settoFileEncode)
		data <- mapply(tableRead, file = filelist, 
			enc = enc, fileenc = fileenc, 
			tblStruct = listStruct, SIMPLIFY = TRUE, ...)	
		data	
	}




# Read and possibly verify the structure of the data
tableRead <- function(file, FUN = read.csv,
		enc = "unknown", fileenc = "", colClasses = "character",
		tblStruct = NA, checkData = TRUE, ...) {

	FUN <- match.fun(FUN)
	x <- FUN(file = file, header=FALSE, encoding = enc, fileEncoding = fileenc,
		colClasses = colClasses, ...)
	l <- list()	
	l$data <- x	
	# Subset is at first 0 
	subst <- 0

	# tblStuct: If there is a previous list with table structure info
	if (is.list(tblStruct)) {
		cols <- tblStruct$cols
		cellN <- tblStruct$cellN
		firstNo <- tblStruct$firstVar
		subst <- 1		
	# Checkdata: If there is no previous list with table info and when checkData = True
	} else if (is.na(tblStruct) & checkData == TRUE) {
		# Ask for response on table structure
		print(x)
		cols <- readintegerline(x = "Which columns describe the data? (integers, comma separated)   ")
		cellN <- readinteger(x = "Which line provides information on (n= xx)? (zero is 'no info')  ")
		firstNo <- readinteger(x = "What is the first line with a baseline variable?   ")
		subst <- 1		
	}
	# If checkdata or tblStruct was used
	if (subst==1) {
		if(cellN <= 0) {
			n <- c("",rep("(n = 0)", length(cols)))
		} else {
			n <- x[cellN,c(1,cols)]
		}
		x <- x[firstNo:dim(x)[1],c(1,cols)]
		l$data <- rbind(n, x)
		l$structure <- list(file = file, cols = cols, 
		cellN = cellN, firstVar = firstNo)
	}
	return(l)
}

# Function for single integer prompt
readinteger <- function(x) { 
	n <- readline(prompt = x)
  	if(!grepl("^[0-9]+$",n)) {
		return(readinteger(x))
	}
	return(as.integer(n))
}

# Function for comma separated multiple integer prompt
readintegerline <- function(x) { 
	n <- readline(prompt = x)
	if(n == "") return(readintegerline(x))
	n <- unlist(strsplit(n,"\\,\\s?"))
  	if(!all(sapply(n, grepl, pattern = "^[0-9]+$"))) {
		return(readintegerline(x))
	}
	return(as.integer(n))
}
