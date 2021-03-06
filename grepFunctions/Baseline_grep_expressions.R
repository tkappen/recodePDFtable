# Define different grep expressions in a function
# Argument alt=FALSE/TRUE refers to whether special exceptions with strange character patterns should be used.
# At the moment none of these exceptions are included
baseExpr <- function(dataFrame = FALSE) {
	## Create list with different types of number patterns
	g <- data.frame(
		group = character(0),
		expr = character(0),
		type = character(0),
		alt = logical(0),
		stringsAsFactors=FALSE)	
	i <- 1
	
	##############
	####  x_  ####
	# xx.x or xx.x%
	g[i,] <- list(group = "x_", expr = 
		"^\\s?\\d+([.]\\d+)?\\%?\\s?$", 	# Number before brackets
		type = "x[%]",
		alt = FALSE)
	i <- i+1

	###############
	####  (x)  ####
	# (SD x)
	g[i,] <- list(group = "(x)", expr = paste(
		"^\\s?[(]SD\\s?\\=?\\s?",	# Expression within brackets
		"\\d+([.]\\d+)?\\)\\s?$", 	# Number in brackets
		sep=""),
		type = "(SD_x)",
		alt = FALSE)
	i <- i+1

	# (x) or (x)%
	g[i,] <- list(group = "(x)", expr = paste(
		"^\\s?[(]\\s?\\=?\\s?",		# Expression within brackets
		"\\d+([.]\\d+)?\\s?", 		# Number in brackets
		"[[:punct:]]?\\)\\s?$",		# Possible % or something like that
		sep=""),
		type = "(x%)",
		alt = FALSE)
	i <- i+1


	#################
	####  x_(x)  ####
	# xx.x (xx.x) or xx.x (xx.x%)
	g[i,] <- list(group = "x_(x)", expr = paste(
		"^\\s?\\d+([.]\\d+)?",		# Number before brackets
		"\\s[(]\\d+([.]\\d+)?",		# Number after brackets
		"[[:punct:]]?\\)\\s?$",		# Possible % or something like that
		sep=""),
		type = "x_(x[%])",
		alt = FALSE)
	i <- i+1

	g[i,] <- list(group = "x_(x)", expr = paste(
		"^\\s?\\d+([.]\\d+)?",			# Number before brackets
		"\\s[(]\\d+([.]\\d+)?",			# Number after brackets
		"\\)[[:alnum:]]*\\s?\\w+$",		# Possible word after 
		sep=""),
		type = "x_(x)_abc",
		alt = FALSE)
	i <- i+1


	###############
	####  x�x  ####
	# Subgroup of x_(x)
	# However, has a different default format
	# It belongs to the mean (SD) group
	g[i,] <- list(group = "x�x", expr = paste(
		"^\\s?\\d+([.]\\d+)?\\%?",		# First Number before brackets
		"\\s?\\�\\s?",				# Separator �
		"\\d+([.]\\d+)?",				# Second Number before brackets
		sep=""),
		type = "x�x",
		alt = FALSE)
	i <- i+1

	# Find xx.x xx.x It belongs to the mean (SD) group, but without parentheses
	g[i,] <- list(group = "x�x", expr = paste(
		"^\\s?\\d+([.]\\d+)?\\%?",		# First Number before brackets
		"\\s",					# Separator any one space
		"\\d+([.]\\d+)?\\%?\\s?$",		# Second Number before brackets
		sep=""),
		type = "x__x",
		alt = FALSE)
	i <- i+1


	#########################################
	####  x_(x - x) (not per se a dash)  ####
	# Find xx.x (xx.x-xx.x) with or without spaces, any dash or hyphen (I hope)	
	g[i,] <- list(group = "x_(x_x)", expr = paste(
		"^\\s?\\d+([.]\\d+)?",			# Number before brackets
		"\\s\\(\\d+([.]\\d+)?",			# First Number after brackets
		"\\s?[\\p{Pd}\\�\\�\\?\\-]",		# Separator (dash) within brackets
		"\\s?\\d+([.]\\d+)?\\)\\s?$",		# Second Number after brackets
		sep=""),
		type = "x_(x-x)",
		alt = FALSE)
	i <- i+1

	# Find xx.x xx.x-xx.x with or without comma, any dash or hyphen (I hope)	
	g[i,] <- list(group = "x_(x_x)", expr = paste(
		"^\\s?\\d+([.]\\d+)?\\,?",			# Number before 
		"\\s\\d+([.]\\d+)?",			# First Number of range
		"[\\p{Pd}\\�\\�\\?\\-]",		# Separator (dash)
		"\\d+([.]\\d+)?\\s?$",			# Second Number of range
		sep=""),
		type = "x_x-x",
		alt = FALSE)
	i <- i+1


	# Find xx.x (xx.x to xx.x) 	
	g[i,] <- list(group = "x_(x_x)", expr = paste(
		"^\\s?\\d+([.]\\d+)?",			# Number before brackets
		"\\s\\(\\d+([.]\\d+)?",			# First Number after brackets
		"\\sto",					# Separator 'to' within brackets
		"\\s\\d+([.]\\d+)?\\)\\s?$",		# Second Number after brackets
		sep=""),
		type = "x_(xtox)",
		alt = FALSE)
	i <- i+1

	# Find xx.x [xx.x - xx.x] 	
	g[i,] <- list(group = "x_(x_x)", expr = paste(
		"^\\s?\\d+([.]\\d+)?",			# Number before brackets
		"\\s\\[\\d+([.]\\d+)?",			# First Number after brackets
		"\\s?[\\p{Pd}\\�\\�\\?\\-]",		# Separator (dash) within brackets
		"\\s?\\d+([.]\\d+)?\\]\\s?$",		# Second Number after brackets
		sep=""),
		type = "x_[x-x]",
		alt = FALSE)
	i <- i+1

	# Find xx.x [xx.x, xx.x] 	
	g[i,] <- list(group = "x_(x_x)", expr = paste(
		"^\\s?\\d+([.]\\d+)?",			# Number before brackets
		"\\s\\[\\d+([.]\\d+)?",			# First Number after brackets
		"\\,\\s",					# Separator (comma) within brackets
		"\\d+([.]\\d+)?\\]\\s?$",		# Second Number after brackets
		sep=""),
		type = "x_[x,x]",
		alt = FALSE)
	i <- i+1

	# Find xx.x (xx.x, xx.x) 	
	g[i,] <- list(group = "x_(x_x)", expr = paste(
		"^\\s?\\d+([.]\\d+)?",			# Number before brackets
		"\\s\\(\\d+([.]\\d+)?",			# First Number after brackets
		"\\,\\s",					# Separator (comma) within brackets
		"\\d+([.]\\d+)?\\)\\s?$",		# Second Number after brackets
		sep=""),
		type = "x_(x,x)",
		alt = FALSE)
	i <- i+1


	#######################################
	####  x_x (with /, : )  ####

	# Find xx.x/xx.x 
	g[i,] <- list(group = "x_x", expr = paste(
		"^\\s?\\d+([.]\\d+)?\\%?",		# First Number before brackets
		"\\s?\\/\\s?",				# Separator /
		"\\d+([.]\\d+)?\\%?\\s?$",		# Second Number before brackets
		sep=""),
		type = "x/x",
		alt = FALSE)
	i <- i+1

	# Find xx.x:xx.x
	g[i,] <- list(group = "x_x", expr = paste(
		"^\\s?\\d+([.]\\d+)?\\%?",		# First Number before brackets
		"\\s?\\:\\s?",				# Separator /
		"\\d+([.]\\d+)?\\%?\\s?$",		# Second Number before brackets
		sep=""),
		type = "x:x",
		alt = FALSE)
	i <- i+1

	
	#############################################
	####  x_x_(x_x) (with /, : or space   ####
	# Find xx.x/xx.x (xx.x/xx.x)
	g[i,] <- list(group = "x_x_(x_x)", expr = paste(
		"^\\s?\\d+([.]\\d+)?\\%?",		# First Number before brackets
		"\\s?\\/\\s?",				# Separator /
		"\\d+([.]\\d+)?\\%?",			# Second Number before brackets
		"\\s\\(\\d+([.]\\d+)?\\%?",		# First Number after brackets
		"\\s?\\/\\s?",				# Separator / within brackets
		"\\d+([.]\\d+)?\\%?\\)\\s?$",		# Second Number after brackets
		sep=""),
		type = "x/x_(x/x)",
		alt = FALSE)				
	i <- i+1

	# Find xx.x:xx.x (xx.x:xx.x)
	g[i,] <- list(group = "x_x_(x_x)", expr = paste(
		"^\\s?\\d+([.]\\d+)?\\%?",		# First Number before brackets
		"\\s?\\:\\s?",				# Separator :
		"\\d+([.]\\d+)?\\%?",			# Second Number before brackets
		"\\s\\(\\d+([.]\\d+)?\\%?",		# First Number after brackets
		"\\s?\\:\\s?",				# Separator : within brackets
		"\\d+([.]\\d+)?\\%?\\)\\s?$",		# Second Number after brackets
		sep=""),
		type = "x:x_(x:x)",
		alt = FALSE)
	i <- i+1

	# Find xx.x xx.x (xx.x xx.x)
	g[i,] <- list(group = "x_x_(x_x)", expr = paste(
		"^\\s?\\d+([.]\\d+)?\\%?",		# First Number before brackets
		"\\s",					# Separator any one space
		"\\d+([.]\\d+)?\\%?",			# Second Number before brackets
		"\\s\\(\\d+([.]\\d+)?\\%?",		# First Number after brackets
		"\\s",					# Separator any one space within brackets
		"\\d+([.]\\d+)?\\%?\\)\\s?$",		# Second Number after brackets
		sep=""),
		type = "x__x_(x__x)",
		alt = FALSE)
	i <- i+1

	#########################
	####  "empty"  cells ####
	# Find empty cells
	g[i,] <- list(group = "empty", expr = 
		"^\\s*$", 	
		type = "__",
		alt = FALSE)
	i <- i+1

	#########################
	####  "alpha"  cells ####
	# Find non-numeric, non-empty cells that contain at least one letter
	g[i,] <- list(group = "alpha", expr = 
		"^[[:alpha:]+[:space:]*[:punct:]*]+$", 	
		type = "abc",
		alt = FALSE)
	i <- i+1

	########################
	####  "n_x"  cells  ####
	# Find (n=xx) or (N=xx) with or without text 
	# (so not per se at the start of a cell)
	# Parentheses optional
	g[i,] <- list(group = "n_x", expr = 
		"\\s?[(]?[Nn]\\s?\\=\\s?\\d+[)]?\\s?$", 	
		type = "n=x",
		alt = FALSE)
	i <- i+1

	# Find (n xx) or (N xx) with or without text 
	# (so not per se at the start of a cell)
	# Parentheses optional
	g[i,] <- list(group = "n_x", expr = 
		"\\s?[(]?[Nn]\\s\\d+[)]?\\s?$", 	
		type = "n__x",
		alt = FALSE)
	i <- i+1

	# Find (xx patients)
	# (so not per se at the start of a cell)
	# Parentheses optional
	g[i,] <- list(group = "n_x", expr = 
		"\\s?[(]\\s?\\d+\\spatients[)]\\s?$", 	
		type = "n_pats",
		alt = FALSE)
	i <- i+1

	rownames(g) <- g$type	
	if (dataFrame == FALSE)	class(g) <- "grepExpr"
	# Return g
	g
}
