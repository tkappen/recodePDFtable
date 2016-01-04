# "x[%]"
e$type[1]
pattern1 <- "\\d+([.]\\d+)?(?=\\%?\\s?$)" 
y1 <- as.data.frame(mytables[[1]])
x <- as.character(y1$V2[10])

"(SD_x)"
e$type[2]
pattern3 <- "\\d+([.]\\d+)?(?=\\)\\s?$)" 
y1 <- as.data.frame(mytables[[8]])
x <- as.character(y1$V3[3])

# "x_(x[%])"
e$type[4]
pattern1 <- "\\d+([.]\\d+)?(?=\\s[(]\\d+([.]\\d+)?[[:punct:]]?\\)\\s?$)" 
pattern3 <- "\\d+([.]\\d+)?(?=[[:punct:]]?\\)\\s?$)"
y1 <- as.data.frame(mytables[[1]])
x <- as.character(y1$V2[5])

# "x_(x)_abc"
e$type[5]
pattern1 <- "\\d+([.]\\d+)?(?=\\s[(]\\d+([.]\\d+)?\\)[[:alnum:]]*\\s?\\w+$)"  
pattern3 <- "(?<=\\s[(])\\d+([.]\\d+)?(?=\\)[[:alnum:]]*\\s?\\w+$)"  
y1 <- as.data.frame(mytables[[13]])
x <- as.character(y1$V2[2])

# "x__x" (it is for example mean SD)
e$type[6]
pattern1 <- "\\d+([.]\\d+)?(?=\\%?\\s\\d+([.]\\d+)?\\%?\\s?$)" 
pattern3 <- "(?<=\\s)\\d+([.]\\d+)?(?=\\%?\\s?$)"         
y1 <- as.data.frame(mytables[[4]])
x <- as.character(y1$V2[6])

# "x_(x-x)"
e$type[7]
pattern1 <- "\\d+([.]\\d+)?(?=\\s\\(\\d+([.]\\d+)?\\s?[\\p{Pd}\\–\\—\\?\\-]\\s?\\d+([.]\\d+)?\\)\\s?$)" 
pattern2 <- "\\d+([.]\\d+)?(?=\\s?[\\p{Pd}\\–\\—\\?\\-]\\s?\\d+([.]\\d+)?\\)\\s?$)"
pattern3 <- "(?<=[\\p{Pd}\\–\\—\\?\\-])\\s?\\d+([.]\\d+)?(?=\\)\\s?$)"
y1 <- as.data.frame(mytables[[3]])
x <- as.character(y1$V4[2])

# "x±x"
e$type[13]
pattern1 <- "\\d+([.]\\d+)?(?=\\%?\\s?\\±\\s?\\d+([.]\\d+)?)"  
pattern2 <- "(?<=\\±)\\s?\\d+([.]\\d+)?"    
y1 <- as.data.frame(mytables[[1]])
x <- as.character(y1$V2[2])

# "x/x"
e$type[14]
pattern1 <- "\\d+([.]\\d+)?(?=\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\%?\\s?$)" 
pattern2 <- "(?<=\\/)\\s?\\d+([.]\\d+)?(?=\\%?\\s?$)"    
y1 <- as.data.frame(mytables[[1]])
x <- as.character(y1$V2[3])

# "x/x_(x/x)"
e$type[16]
pattern1 <- "\\d+([.]\\d+)?(?=\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\)\\s?$)"
pattern2 <- "\\d+([.]\\d+)?(?=\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\)\\s?$)"
pattern3 <- "(?<=\\s\\()\\d+([.]\\d+)?(?=\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\)\\s?$)"
pattern4 <- "(?<=\\/)\\s?\\d+([.]\\d+)?(?=\\)\\s?$)"
y1 <- as.data.frame(mytables[[6]])
x <- as.character(y1$V3[6])


# "n=x"
e$type[21]
pattern1 <- "(?<=\\=)\\s?\\d+(?=[)]?\\s?$)"    
y1 <- as.data.frame(mytables[[1]])
x <- as.character(y1$V2[1])

# "n__x"
e$type[22]
pattern1 <- "(?<=[Nn]\\s)\\d+(?=[)]?\\s?$)"     
y1 <- as.data.frame(mytables[[4]])
x <- as.character(y1$V3[1])

# "n__x"
e$type[22]
pattern1 <- "(?<=[Nn]\\s)\\d+(?=[)]?\\s?$)"     
y1 <- as.data.frame(mytables[[4]])
x <- as.character(y1$V3[1])

y1 <- as.data.frame(mytables[[2]])
x <- as.character(y1$V2[2])


as.numeric(regmatches(x, gregexpr(pattern1, x, perl=TRUE)))
as.numeric(regmatches(x, gregexpr(pattern2, x, perl=TRUE)))
as.numeric(regmatches(x, gregexpr(pattern3, x, perl=TRUE)))
as.numeric(regmatches(x, gregexpr(pattern4, x, perl=TRUE)))