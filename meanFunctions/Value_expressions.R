valueTypes <- function(dataFrame = TRUE) {
	## Create list with different types values
	g <- data.frame(
		value = character(0),
		aggregateFUN = character(0),
		weighted = logical(0),
		stringsAsFactors=FALSE)	
	i <- 1

	#####################
	####  Frequency  ####
	g[i,] <- list(value = "Frequency",
		aggregateFUN = "sum",
		weighted = FALSE)
	i <- i+1

	######################
	####  Percentage  ####
	g[i,] <- list(value = "Percentage",
		aggregateFUN = "mean",
		weighted = TRUE)
	i <- i+1

	######################
	####  Percentile  ####
	# Includes median, IQR, range(0 and 100th percentile)
	g[i,] <- list(value = "Percentile",
		aggregateFUN = "mean",
		weighted = TRUE)
	i <- i+1

	################
	####  Mean  ####
	g[i,] <- list(value = "Mean",
		aggregateFUN = "mean",
		weighted = TRUE)
	i <- i+1

	###################
	####  SD or SE ####
	g[i,] <- list(value = "SD",
		aggregateFUN = "mean",
		weighted = TRUE)
	i <- i+1

	####################
	####  Conf Int  ####
	g[i,] <- list(value = "CI",
		aggregateFUN = "mean",
		weighted = TRUE)
	i <- i+1

	rownames(g) <- g$value
	if (dataFrame == FALSE)	class(g) <- "valueTypeList"
	return(g)
}


# unique(baseExpr()$group)
cellTypes <- function(dataFrame = TRUE) {
	## Create list with different types values
	## Create list with different types values
	g <- data.frame(
		ID = numeric(0),
		group = character(0),
		pattern1 = character(0),
		pattern2 = character(0),
		pattern3 = character(0),
		pattern4 = character(0),
		formatFUN = character(0),
		ranking = numeric(0),
		stringsAsFactors=FALSE)	
	i <- 1

	################
	####  "x_"  ####
	j <- 1
	g[i,] <- list(ID = i,
		group = "x_",
		pattern1 = "Frequency",
		pattern2 = NA,
		pattern3 = NA,
		pattern4 = NA,
		formatFUN = "paste(p1,sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	g[i,] <- list(ID = i,
		group = "x_",
		pattern1 = "Mean",
		pattern2 = NA,
		pattern3 = NA,
		pattern4 = NA,
		formatFUN = "paste(p1,sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	g[i,] <- list(ID = i,
		group =  "x_",
		pattern1 = "Percentage",
		pattern2 = NA,
		pattern3 = NA,
		pattern4 = NA,
		formatFUN = "paste(p1,\"%\",sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	#################
	####  "(x)"  ####
	j <- 1
	g[i,] <- list(ID = i,
		group = "(x)",
		pattern1 = NA,
		pattern2 = NA,
		pattern3 = "Percentage",
		pattern4 = NA,
		formatFUN = "paste(p3,\"%\",sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	g[i,] <- list(ID = i,
		group = "(x)",
		pattern1 = NA,
		pattern2 = NA,
		pattern3 = "SD",
		pattern4 = NA,
		formatFUN = "paste(\"±\",p3,sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1
	
	###################
	####  "x_(x)"  ####
	j <- 1
	g[i,] <- list(ID = i,
		group = "x_(x)",
		pattern1 = "Frequency",
		pattern2 = NA,
		pattern3 = "Percentage",
		pattern4 = NA,
		formatFUN = "paste(p3,\"%\",sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	g[i,] <- list(ID = i,
		group = "x_(x)",
		pattern1 = "Mean",
		pattern2 = NA,
		pattern3 = "SD",
		pattern4 = NA,
		formatFUN = "paste(p1,\"±\",p3,sep = \"\")",
		ranking = j)
	i <- i+1	
	j <- j+1


	###################
	####  "x±x"  ####
	j <- 1
	g[i,] <- list(ID = i,
		group = "x±x",
		pattern1 = "Mean",
		pattern2 = NA,
		pattern3 = "SD",
		pattern4 = NA,
		formatFUN = "paste(p1,\"±\",p3,sep = \"\")",
		ranking = j)
	i <- i+1	
	j <- j+1

	g[i,] <- list(ID = i,
		group = "x±x",
		pattern1 = "Frequency",
		pattern2 = NA,
		pattern3 = "Percentage",
		pattern4 = NA,
		formatFUN = "paste(p3,\"%\",sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	g[i,] <- list(ID = i,
		group = "x±x",
		pattern1 = "Frequency",
		pattern2 = "Frequency",
		pattern3 = NA,
		pattern4 = NA,
		formatFUN = "paste(p1,\":\",p3, sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	#####################
	####  "x_(x_x)"  ####
	j <- 1
	g[i,] <- list(ID = i,
		group = "x_(x_x)",
		pattern1 = "Percentile",
		pattern2 = NA,
		pattern3 = "Percentile",
		pattern4 = "Percentile",
		formatFUN = "paste(p1,\" (\",p3,\"-\",p4,\")\",sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	g[i,] <- list(ID = i,
		group = "x_(x_x)",
		pattern1 = "Mean",
		pattern2 = NA,
		pattern3 = "CI",
		pattern4 = "CI",
		formatFUN = "paste(p1,\" (95%CI \",p3,\"-\",p4,\")\",sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	g[i,] <- list(ID = i,
		group = "x_(x_x)",
		pattern1 = "Percentage",
		pattern2 = NA,
		pattern3 = "CI",
		pattern4 = "CI",
		formatFUN = "paste(p1,\"%\",\" (95%CI \",p3,\"-\",p4,\")\",sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	#################
	####  "x_x"  ####
	j <- 1
	g[i,] <- list(ID = i,
		group = "x_x" ,
		pattern1 = "Frequency",
		pattern2 = "Frequency",
		pattern3 = NA,
		pattern4 = NA,
		formatFUN = "paste(p1,\":\",p2, sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	g[i,] <- list(ID = i,
		group = "x_x" ,
		pattern1 = "Mean",
		pattern2 = "SD",
		pattern3 = NA,
		pattern4 = NA,
		formatFUN = "paste(p1,\"±\",p2,sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	#######################
	####  "x_x_(x_x)"  ####
	j <- 1
	g[i,] <- list(ID = i,
		group = "x_x_(x_x)",
		pattern1 = "Frequency",
		pattern2 = "Frequency",
		pattern3 = "Percentage",
		pattern4 = "Percentage",
		formatFUN = "paste(p1,\":\",p2,\" (\",p3,\"-\",p4,\"%)\", sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	g[i,] <- list(ID = i,
		group = "x_x_(x_x)",
		pattern1 = "Mean",
		pattern2 = "Mean",
		pattern3 = "SD",
		pattern4 = "SD",
		formatFUN = "paste(p1,\"±\",p3,\", \",p2,\"±\",p4,sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	###################
	####  "empty"  ####
	j <- 1
	g[i,] <- list(ID = i,
		group = "empty",
		pattern1 = NA,
		pattern2 = NA,
		pattern3 = NA,
		pattern4 = NA,
		formatFUN = "paste(\"\",sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	###################
	####  "alpha"  ####
	j <- 1
	g[i,] <- list(ID = i,
		group = "alpha",
		pattern1 = NA,
		pattern2 = NA,
		pattern3 = NA,
		pattern4 = NA,
		formatFUN = "paste(\"\",sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	#################
	####  "n_x"  ####
	j <- 1
	g[i,] <- list(ID = i,
		group = "n_x",
		pattern1 = "Frequency",
		pattern2 = NA,
		pattern3 = NA,
		pattern4 = NA,
		formatFUN = "paste(p1,sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1

	g[i,] <- list(ID = i,
		group = "n_x",
		pattern1 = "Percentage",
		pattern2 = NA,
		pattern3 = NA,
		pattern4 = NA,
		formatFUN = "paste(p1,\"%\",sep = \"\")",
		ranking = j)
	i <- i+1
	j <- j+1


	rownames(g) <- g$value
	if (dataFrame == FALSE)	class(g) <- "cellTypeList"
	return(g)
}

