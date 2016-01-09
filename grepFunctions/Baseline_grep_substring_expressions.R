# Define different grep expressions within a function
# to split table strings in four different columns
baseExprSub <- function(dataFrame = TRUE) {
	## Create list with different expressions 
	## to split a particular types of number patterns
	g <- data.frame(
		type = character(0),
		pattern1 = character(0),
		pattern2 = character(0),
		pattern3 = character(0),
		pattern4 = character(0),
		stringsAsFactors=FALSE)	
	i <- 1

	# "x[%]"
	g[i,] <- list(type = "x[%]",
		pattern1 = "\\d+([.]\\d+)?(?=\\%?\\s?$)",
		pattern2 = NA,
		pattern3 = NA,
		pattern4 = NA)
	i <- i+1

	# "(SD_x)"
	g[i,] <- list(type = "(SD_x)",
		pattern1 = NA,
		pattern2 = NA,
		pattern3 = "\\d+([.]\\d+)?(?=\\)\\s?$)", 
		pattern4 = NA)
	i <- i+1

	# "(x%)"
	g[i,] <- list(type = "(x%)",
		pattern1 = NA,
		pattern2 = NA,
		pattern3 = "\\d+([.]\\d+)?(?=\\s?[[:punct:]]?\\)\\s?$)", 
		pattern4 = NA)
	i <- i+1

	# "x_(x[%])"
	g[i,] <- list(type = "x_(x[%])",
		pattern1 = "\\d+([.]\\d+)?(?=\\s[(]\\d+([.]\\d+)?[[:punct:]]?\\)\\s?$)", 
		pattern2 = NA,
		pattern3 = "\\d+([.]\\d+)?(?=[[:punct:]]?\\)\\s?$)",
		pattern4 = NA)
	i <- i+1

	# "x_(x)_abc"
	g[i,] <- list(type = "x_(x)_abc",
		pattern1 = "\\d+([.]\\d+)?(?=\\s[(]\\d+([.]\\d+)?\\)[[:alnum:]]*\\s?\\w+$)", 
		pattern2 = NA, 
		pattern3 = "(?<=\\s[(])\\d+([.]\\d+)?(?=\\)[[:alnum:]]*\\s?\\w+$)",  
		pattern4 = NA) 
	i <- i+1

	# "x±x"
	g[i,] <- list(type = "x±x",
		pattern1 = "\\d+([.]\\d+)?(?=\\%?\\s?\\±\\s?\\d+([.]\\d+)?)", 
		pattern2 = NA,       
		pattern3 = "(?<=\\±)\\s?\\d+([.]\\d+)?",
		pattern4 = NA)         
	i <- i+1

	# "x__x" (it is for example mean SD)
	g[i,] <- list(type = "x__x",
		pattern1 = "\\d+([.]\\d+)?(?=\\%?\\s\\d+([.]\\d+)?\\%?\\s?$)", 
		pattern2 = NA, 
		pattern3 = "(?<=\\s)\\d+([.]\\d+)?(?=\\%?\\s?$)", 
		pattern4 = NA)         
	i <- i+1

	# "x_(x-x)"
	g[i,] <- list(type = "x_(x-x)",
		pattern1 = "\\d+([.]\\d+)?(?=\\s\\(\\d+([.]\\d+)?\\s?[\\p{Pd}\\–\\—\\?\\-]\\s?\\d+([.]\\d+)?\\)\\s?$)", 
		pattern2 = NA, 
		pattern3 = "\\d+([.]\\d+)?(?=\\s?[\\p{Pd}\\–\\—\\?\\-]\\s?\\d+([.]\\d+)?\\)\\s?$)",
		pattern4 = "(?<=[\\p{Pd}\\–\\—\\?\\-])\\s?\\d+([.]\\d+)?(?=\\)\\s?$)")
	i <- i+1

	# "x_x-x"
	g[i,] <- list(type = "x_x-x",
		pattern1 = "\\d+([.]\\d+)?(?=\\,?\\s\\d+([.]\\d+)?[\\p{Pd}\\–\\—\\?\\-]\\d+([.]\\d+)?\\s?$)",  
		pattern2 = NA,
		pattern3 = "(?<=\\s)\\d+([.]\\d+)?(?=[\\p{Pd}\\–\\—\\?\\-]\\d+([.]\\d+)?\\s?$)",  
		pattern4 = "(?<=[\\p{Pd}\\–\\—\\?\\-])\\d+([.]\\d+)?(?=\\s?$)" ) 
	i <- i+1

	# "x_(xtox)"
	g[i,] <- list(type = "x_(xtox)",
		pattern1 = "\\d+([.]\\d+)?(?=\\s\\(\\d+([.]\\d+)?\\sto\\s\\d+([.]\\d+)?\\)\\s?$)",  
		pattern2 = NA,
		pattern3 = "\\d+([.]\\d+)?(?=\\sto\\s\\d+([.]\\d+)?\\)\\s?$)",  
		pattern4 = "(?<=\\sto\\s)\\d+([.]\\d+)?(?=\\)\\s?$)")
	i <- i+1

	# "x_[x-x]"
	g[i,] <- list(type = "x_[x-x]",
		pattern1 = "\\d+([.]\\d+)?(?=\\s\\[\\d+([.]\\d+)?\\s?[\\p{Pd}\\–\\—\\?\\-]\\s?\\d+([.]\\d+)?\\]\\s?$)",     
		pattern2 = NA,
		pattern3 = "(?<=\\s\\[)\\d+([.]\\d+)?(?=\\s?[\\p{Pd}\\–\\—\\?\\-]\\s?\\d+([.]\\d+)?\\]\\s?$)",   
		pattern4 = "(?<=[\\p{Pd}\\–\\—\\?\\-])\\s?\\d+([.]\\d+)?(?=\\]\\s?$)")
	i <- i+1

	# "x_[x,x]"
	g[i,] <- list(type = "x_[x,x]",
		pattern1 = "\\d+([.]\\d+)?(?=\\s\\[\\d+([.]\\d+)?\\,\\s\\d+([.]\\d+)?\\]\\s?$)",    
		pattern2 = NA,
		pattern3 = "(?<=\\[)\\d+([.]\\d+)?(?=\\,\\s\\d+([.]\\d+)?\\]\\s?$)",  
		pattern4 = "(?<=\\,\\s)\\d+([.]\\d+)?(?=\\]\\s?$)")
	i <- i+1

	# "x_(x,x)"
	g[i,] <- list(type = "x_(x,x)",
		pattern1 = "\\d+([.]\\d+)?(?=\\s\\(\\d+([.]\\d+)?\\,\\s\\d+([.]\\d+)?\\)\\s?$)",    
		pattern2 = NA,
		pattern3 = "(?<=\\()\\d+([.]\\d+)?(?=\\,\\s\\d+([.]\\d+)?\\)\\s?$)",  
		pattern4 = "(?<=\\,\\s)\\d+([.]\\d+)?(?=\\)\\s?$)")
	i <- i+1

	# "x/x"
	g[i,] <- list(type = "x/x",
		pattern1 = "\\d+([.]\\d+)?(?=\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\%?\\s?$)", 
		pattern2 = "(?<=\\/)\\s?\\d+([.]\\d+)?(?=\\%?\\s?$)",   
		pattern3 = NA,       
		pattern4 = NA)          
	i <- i+1

	# "x:x"
	g[i,] <- list(type = "x:x",
		pattern1 = "\\d+([.]\\d+)?(?=\\%?\\s?\\:\\s?\\d+([.]\\d+)?\\%?\\s?$)", 
		pattern2 = "(?<=\\:)\\s?\\d+([.]\\d+)?(?=\\%?\\s?$)",   
		pattern3 = NA,       
		pattern4 = NA)          
	i <- i+1

	# "x/x_(x/x)"
	g[i,] <- list(type = "x/x_(x/x)",
		pattern1 = "\\d+([.]\\d+)?(?=\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\%?\\)\\s?$)",
		pattern2 = "\\d+([.]\\d+)?(?=\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\%?\\)\\s?$)",
		pattern3 = "(?<=\\s\\()\\d+([.]\\d+)?(?=\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\%?\\)\\s?$)",
		pattern4 = "(?<=\\/)\\s?\\d+([.]\\d+)?(?=\\%?\\)\\s?$)")
	i <- i+1

	# "x:x_(x:x)"
	g[i,] <- list(type = "x:x_(x:x)",
		pattern1 = "\\d+([.]\\d+)?(?=\\%?\\s?\\:\\s?\\d+([.]\\d+)?\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s?\\:\\s?\\d+([.]\\d+)?\\%?\\)\\s?$)",
		pattern2 = "\\d+([.]\\d+)?(?=\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s?\\:\\s?\\d+([.]\\d+)?\\%?\\)\\s?$)",
		pattern3 = "(?<=\\s\\()\\d+([.]\\d+)?(?=\\%?\\s?\\:\\s?\\d+([.]\\d+)?\\%?\\)\\s?$)",
		pattern4 = "(?<=\\:)\\s?\\d+([.]\\d+)?(?=\\%?\\)\\s?$)")
	i <- i+1

	# "x__x_(x__x)"
	g[i,] <- list(type = "x__x_(x__x)",
		pattern1 = "\\d+([.]\\d+)?(?=\\%?\\s\\d+([.]\\d+)?\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s\\d+([.]\\d+)?\\%?\\)\\s?$)", 
		pattern2 = "(?<=\\s)\\d+([.]\\d+)?(?=\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s\\d+([.]\\d+)?\\%?\\)\\s?$)", 
		pattern3 = "(?<=\\s\\()\\d+([.]\\d+)?(?=\\%?\\s\\d+([.]\\d+)?\\%?\\)\\s?$)", 
		pattern4 = "(?<=\\s)\\d+([.]\\d+)?(?=\\%?\\)\\s?$)") 
	i <- i+1

	# "__"
	g[i,] <- list(type = "__",
		pattern1 = NA,
		pattern2 = NA,
		pattern3 = NA,
		pattern4 = NA)
	i <- i+1

	# "abc"
	g[i,] <- list(type = "abc",
		pattern1 = NA,
		pattern2 = NA,
		pattern3 = NA,
		pattern4 = NA)
	i <- i+1

	# "n=x"
	g[i,] <- list(type = "n=x",
		pattern1 = "(?<=\\=)\\s?\\d+(?=[)]?\\s?$)",
		pattern2 = NA,
		pattern3 = NA,
		pattern4 = NA)
	i <- i+1

	# "n__x"
	g[i,] <- list(type = "n__x",
		pattern1 = "(?<=[Nn]\\s)\\d+(?=[)]?\\s?$)",     
		pattern2 = NA,
		pattern3 = NA,
		pattern4 = NA)
	i <- i+1

	# "n_pats"
	g[i,] <- list(type = "n_pats",
		pattern1 = "\\d+(?=\\spatients[)]\\s?$)",      
		pattern2 = NA,
		pattern3 = NA,
		pattern4 = NA)
	i <- i+1

	rownames(g) <- g$type	
	if (dataFrame == FALSE)	class(g) <- "grepExprSub"
	# Return g
	g
}
