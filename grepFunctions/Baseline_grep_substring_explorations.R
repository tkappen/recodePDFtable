e <- baseExpr()

# "x[%]"
e$type[1]
pattern1 <- "\\d+([.]\\d+)?(?=\\%?\\s?$)"
pattern2 <- NA
pattern3 <- NA
pattern4 <- NA
y1 <- as.data.frame(mytables[[1]])
x <- as.character(y1$V2[10])

"(SD_x)"
e$type[2]
pattern1 <- NA
pattern2 <- NA
pattern3 <- "\\d+([.]\\d+)?(?=\\)\\s?$)" 
pattern4 <- NA
y1 <- as.data.frame(mytables[[8]])
x <- as.character(y1$V3[3])

# "(x%)"
e$type[3]
pattern1 <- NA
pattern2 <- NA
pattern3 <- "\\d+([.]\\d+)?(?=\\s?[[:punct:]]?\\)\\s?$)" 
pattern4 <- NA
y1 <- as.data.frame(mytables[[16]])
x <- as.character(y1$V3[1])

# "x_(x[%])"
e$type[4]
pattern1 <- "\\d+([.]\\d+)?(?=\\s[(]\\d+([.]\\d+)?[[:punct:]]?\\)\\s?$)" 
pattern2 <- NA
pattern3 <- "\\d+([.]\\d+)?(?=[[:punct:]]?\\)\\s?$)"
pattern4 <- NA
y1 <- as.data.frame(mytables[[1]])
x <- as.character(y1$V2[5])

# "x_(x)_abc"
e$type[5]
pattern1 <- "\\d+([.]\\d+)?(?=\\s[(]\\d+([.]\\d+)?\\)[[:alnum:]]*\\s?\\w+$)" 
pattern2 <- NA 
pattern3 <- "(?<=\\s[(])\\d+([.]\\d+)?(?=\\)[[:alnum:]]*\\s?\\w+$)"  
pattern4 <- NA 
y1 <- as.data.frame(mytables[[13]])
x <- as.character(y1$V2[2])

# "x__x" (it is for example mean SD)
e$type[6]
pattern1 <- "\\d+([.]\\d+)?(?=\\%?\\s\\d+([.]\\d+)?\\%?\\s?$)" 
pattern2 <- NA 
pattern3 <- "(?<=\\s)\\d+([.]\\d+)?(?=\\%?\\s?$)" 
pattern4 <- NA         
y1 <- as.data.frame(mytables[[4]])
x <- as.character(y1$V2[6])

# "x_(x-x)"
e$type[7]
pattern1 <- "\\d+([.]\\d+)?(?=\\s\\(\\d+([.]\\d+)?\\s?[\\p{Pd}\\–\\—\\?\\-]\\s?\\d+([.]\\d+)?\\)\\s?$)" 
pattern2 <- "\\d+([.]\\d+)?(?=\\s?[\\p{Pd}\\–\\—\\?\\-]\\s?\\d+([.]\\d+)?\\)\\s?$)"
pattern3 <- "(?<=[\\p{Pd}\\–\\—\\?\\-])\\s?\\d+([.]\\d+)?(?=\\)\\s?$)"
pattern4 <- NA       
x <- as.character(y1$V4[2])

# "x_x-x"
e$type[8]
pattern1 <- "\\d+([.]\\d+)?(?=\\,?\\s\\d+([.]\\d+)?[\\p{Pd}\\–\\—\\?\\-]\\d+([.]\\d+)?\\s?$)"  
pattern2 <- "(?<=\\s)\\d+([.]\\d+)?(?=[\\p{Pd}\\–\\—\\?\\-]\\d+([.]\\d+)?\\s?$)"  
pattern3 <- "(?<=[\\p{Pd}\\–\\—\\?\\-])\\d+([.]\\d+)?(?=\\s?$)"  
pattern4 <- NA       
x <- "45.1 34-59.2"
x <- "1.1, 0.9-1.3"

# "x_(xtox)"
e$type[9]
pattern1 <- "\\d+([.]\\d+)?(?=\\s\\(\\d+([.]\\d+)?\\sto\\s\\d+([.]\\d+)?\\)\\s?$)"  
pattern2 <- "\\d+([.]\\d+)?(?=\\sto\\s\\d+([.]\\d+)?\\)\\s?$)"  
pattern3 <- "(?<=\\sto\\s)\\d+([.]\\d+)?(?=\\)\\s?$)"  
pattern4 <- NA       
y1 <- as.data.frame(mytables[[21]])
x <- as.character(y1$V4[21])

# "x_[x-x]"
e$type[10]
pattern1 <- "\\d+([.]\\d+)?(?=\\s\\[\\d+([.]\\d+)?\\s?[\\p{Pd}\\–\\—\\?\\-]\\s?\\d+([.]\\d+)?\\]\\s?$)"     
pattern2 <- "(?<=\\s\\[)\\d+([.]\\d+)?(?=\\s?[\\p{Pd}\\–\\—\\?\\-]\\s?\\d+([.]\\d+)?\\]\\s?$)"   
pattern3 <- "(?<=[\\p{Pd}\\–\\—\\?\\-])\\s?\\d+([.]\\d+)?(?=\\]\\s?$)"  
pattern4 <- NA       
x <- "2.7 [1.9-3.8] "
x <- "3.0 [2 - 4.4] "

# "x_[x,x]"
e$type[11]
pattern1 <- "\\d+([.]\\d+)?(?=\\s\\[\\d+([.]\\d+)?\\,\\s\\d+([.]\\d+)?\\]\\s?$)"    
pattern2 <- "(?<=\\[)\\d+([.]\\d+)?(?=\\,\\s\\d+([.]\\d+)?\\]\\s?$)"  
pattern3 <- "(?<=\\,\\s)\\d+([.]\\d+)?(?=\\]\\s?$)"  
pattern4 <- NA       
y1 <- as.data.frame(mytables[[24]])
x <- as.character(y1$V3[57])

# "x_(x,x)"
e$type[12]
pattern1 <- "\\d+([.]\\d+)?(?=\\s\\(\\d+([.]\\d+)?\\,\\s\\d+([.]\\d+)?\\)\\s?$)"    
pattern2 <- "(?<=\\()\\d+([.]\\d+)?(?=\\,\\s\\d+([.]\\d+)?\\)\\s?$)"  
pattern3 <- "(?<=\\,\\s)\\d+([.]\\d+)?(?=\\)\\s?$)" 
pattern4 <- NA        
x <- "2.7 (1.9, 3.8)"
x <- "3.0 (2, 4.4) "

# "x±x"
e$type[13]
pattern1 <- "\\d+([.]\\d+)?(?=\\%?\\s?\\±\\s?\\d+([.]\\d+)?)"  
pattern2 <- "(?<=\\±)\\s?\\d+([.]\\d+)?"  
pattern3 <- NA       
pattern4 <- NA         
y1 <- as.data.frame(mytables[[1]])
x <- as.character(y1$V2[2])

# "x/x"
e$type[14]
pattern1 <- "\\d+([.]\\d+)?(?=\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\%?\\s?$)" 
pattern2 <- "(?<=\\/)\\s?\\d+([.]\\d+)?(?=\\%?\\s?$)"   
pattern3 <- NA       
pattern4 <- NA          
y1 <- as.data.frame(mytables[[1]])
x <- as.character(y1$V2[3])

# "x:x"
e$type[15]
pattern1 <- "\\d+([.]\\d+)?(?=\\%?\\s?\\:\\s?\\d+([.]\\d+)?\\%?\\s?$)" 
pattern2 <- "(?<=\\:)\\s?\\d+([.]\\d+)?(?=\\%?\\s?$)"   
pattern3 <- NA       
pattern4 <- NA          
x <-  "11:9 "
x <- "1.1 : 2.3" 

# "x/x_(x/x)"
e$type[16]
pattern1 <- "\\d+([.]\\d+)?(?=\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\%?\\)\\s?$)"
pattern2 <- "\\d+([.]\\d+)?(?=\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\%?\\)\\s?$)"
pattern3 <- "(?<=\\s\\()\\d+([.]\\d+)?(?=\\%?\\s?\\/\\s?\\d+([.]\\d+)?\\%?\\)\\s?$)"
pattern4 <- "(?<=\\/)\\s?\\d+([.]\\d+)?(?=\\%?\\)\\s?$)"
y1 <- as.data.frame(mytables[[6]])
x <- as.character(y1$V3[6])

# "x:x_(x:x)"
e$type[17]
pattern1 <- "\\d+([.]\\d+)?(?=\\%?\\s?\\:\\s?\\d+([.]\\d+)?\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s?\\:\\s?\\d+([.]\\d+)?\\%?\\)\\s?$)"
pattern2 <- "\\d+([.]\\d+)?(?=\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s?\\:\\s?\\d+([.]\\d+)?\\%?\\)\\s?$)"
pattern3 <- "(?<=\\s\\()\\d+([.]\\d+)?(?=\\%?\\s?\\:\\s?\\d+([.]\\d+)?\\%?\\)\\s?$)"
pattern4 <- "(?<=\\:)\\s?\\d+([.]\\d+)?(?=\\%?\\)\\s?$)"
y1 <- as.data.frame(mytables[[22]])
x <- as.character(y1$V2[3])

# "x__x_(x__x)"
e$type[18]
pattern1 <- "\\d+([.]\\d+)?(?=\\%?\\s\\d+([.]\\d+)?\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s\\d+([.]\\d+)?\\%?\\)\\s?$)" 
pattern2 <- "(?<=\\s)\\d+([.]\\d+)?(?=\\%?\\s\\(\\d+([.]\\d+)?\\%?\\s\\d+([.]\\d+)?\\%?\\)\\s?$)" 
pattern3 <- "(?<=\\s\\()\\d+([.]\\d+)?(?=\\%?\\s\\d+([.]\\d+)?\\%?\\)\\s?$)" 
pattern4 <- "(?<=\\s)\\d+([.]\\d+)?(?=\\%?\\)\\s?$)"   
x <- "17 6 (74 26) "
x <- "39.2 19.1 (67.6 33.4) "

# "__"
e$type[19]
pattern1 <- NA
pattern2 <- NA
pattern3 <- NA
pattern4 <- NA


# "abc"
e$type[20]
pattern1 <- NA
pattern2 <- NA
pattern3 <- NA
pattern4 <- NA

# "n=x"
e$type[21]
pattern1 <- "(?<=\\=)\\s?\\d+(?=[)]?\\s?$)"
pattern2 <- NA
pattern3 <- NA
pattern4 <- NA
y1 <- as.data.frame(mytables[[1]])
x <- as.character(y1$V2[1])

# "n__x"
e$type[22]
pattern1 <- "(?<=[Nn]\\s)\\d+(?=[)]?\\s?$)"     
pattern2 <- NA
pattern3 <- NA
pattern4 <- NA
y1 <- as.data.frame(mytables[[4]])
x <- as.character(y1$V3[1])


# "n_pats"
e$type[23]
pattern1 <- "\\d+(?=\\spatients[)]\\s?$)"      
pattern2 <- NA
pattern3 <- NA
pattern4 <- NA
y1 <- as.data.frame(mytables[[15]])
x <- as.character(y1$V2[1])



as.numeric(regmatches(x, gregexpr(pattern1, x, perl=TRUE)))
as.numeric(regmatches(x, gregexpr(pattern2, x, perl=TRUE)))
as.numeric(regmatches(x, gregexpr(pattern3, x, perl=TRUE)))
as.numeric(regmatches(x, gregexpr(pattern4, x, perl=TRUE)))