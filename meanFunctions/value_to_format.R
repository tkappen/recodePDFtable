# All these functions assume the use of
# baseExpr(), baseExprSub(), cellTypes(), valueTypes()

# Get first column of each table
# or return set if only one column
firstCol <- function(x) {
	if(!is.null(dim(x))) {
		x <- x[,1]
	}
	return(x)
}

# Get all the default types and formats
# for a single table
tableDefaultTypes <- function(x, tables = NULL, name = "") {
	# Get all groups linked to their types
	# Types in rownames for selection
	grps <- baseExpr()$group
	names(grps) <- baseExpr()$type
	# Get groups for dataset
	cellgrps <- grps[firstCol(x)]
	# Get celltypes for dataset
	celltypes <- cellTypes()
	celltype <- celltypes[celltypes$ranking==1,]
	if (!is.null(tables)) {
		if (any(cellgrps == "x_")) {
			cat(name)
			cat("\n")
			print(tables, quote = FALSE)
			fp <- readinteger("\nIs this a frequency (press 1), mean (2) or a percentage (3)?\n")
			celltype[celltype$group == "x_",] <- 
				with(celltypes,(celltypes[group == "x_" & ranking == fp,]))
		}
	}
	row.names(celltype) <- celltype$group
	celltype[cellgrps,]
}

# Get all the default types and formats
# for a list of tables according to a tableList object (read.multi())
getDefaultTypes <- function(x, checkFormats = FALSE) {
	if(class(x)!="tableList") {
		stop('x is not a tableList object')
	}
	y <- grepTableSet(x, rowtype=TRUE)
		if (checkFormats == TRUE) {
		name <- names(y)
		dT <- mapply(tableDefaultTypes, y, tables = x[1,], 
			name = name, SIMPLIFY=FALSE)
	} else {
		dT <- lapply(y, tableDefaultTypes)
	}
	class(dT) <- "TypeList"
	return(dT)
}

# Compare orginal table with the current Type
compareTypes <- function(x,y) {
	cols <- c("group","pattern1","pattern2","pattern3","pattern4")
	print(x[,1:2], quote=FALSE)
	cat(" \n")
	print(y[,cols], quote=FALSE, na.print = "")
}



