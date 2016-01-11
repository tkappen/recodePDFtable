---
title: "Intraoperative Hypotension Review - Code for summarizing data from a PDF"
author: "Teus Kappen"
date: "January 10 2016"
output: 
  html_document: 
    fig_caption: yes
---

# Example of the recode PDF table functions



## Previous actions
Exported all Table 1 for the articles with [Tabula Win 1.0.1](https://github.com/tabulapdf/tabula).  
Except for:
- Gold et al (only image based PDF)
- Jain et al (only image based PDF)
- Marcantonio et al (only text based baseline info)
- Sessler et al (no baseline description)
- Reich et al (no baseline description)  
  
## Read baseline data file




```r
# Get list of data extract files
files_full <- list.files("Z:/Drive/Medicine/Science/Projecten/Esther Wesselink/Manuscripts/2. IOH and Outcomes Review/IOHReviewReadPDFs/Data extracts", full.names=T, pattern="*.csv")
```

Multiple tables should be read. However, due to different formatting
this possibly requires different character encoding schemes, as well 
as some information about the structure of the table.  

[Encoding Functions](https://github.com/tkappen/recodePDFtable/blob/master/readFunctions/Encoding_functions.R)



The next R code uses the function `read.multi` to read all the files.
Within the R code, originally there was a first time that we called
for `checkData=TRUE` to enter all table information. This information 
was then stored in `./Data/tableStructures.R` to ensure that we did not
have to repeat the process and would use the same information every time.



```r
# Read with prompts for database structure
# myfiles <- read.multi(files_full, 
#	baseEncoding = "UTF-8", baseFileEncoding = "windows-1252",
#	altEncoding = "windows-1252", altFileEncoding = "437",
###	settoEncode =6, settoFileEncode =6, ### Don't need it, changed dataset
#	checkData = TRUE, startCol = TRUE, subThousands = TRUE)
# dput(myfiles2[2,], "Z:/Drive/Medicine/Science/Projecten/Esther Wesselink/Manuscripts/2. IOH and Outcomes Review/IOHReviewReadPDFs/Data/tableStructures.R")

# Create more simple names from filenames
m1 <- regexpr("[[:upper:]][[:alnum:][:space:]]+[.]",files_full)
m2 <- regexpr("(?<=\\-)[[:digit:]]+",files_full, perl=TRUE)
mynames <- paste(regmatches(files_full,m1), regmatches(files_full,m2))


# Re-read existing table structure and load tables
listStruct <- dget("Z:/Drive/Medicine/Science/Projecten/Esther Wesselink/Manuscripts/2. IOH and Outcomes Review/IOHReviewReadPDFs/Data/tableStructures.R")
myfiles <- read.multi(files_full, 
	baseEncoding = "UTF-8", baseFileEncoding = "windows-1252",
	altEncoding = "windows-1252", altFileEncoding = "437",
 	listStruct= listStruct, row.names = mynames)

# Read only the tables into separte variable
myfiles[1,c(2,9)]
```

```
## $`Lima et al. 2003`
##       V1                    V2           V3         
##  [1,] "N "                  "56 (61%) "  "36 (39%)" 
##  [2,] "Sex (M/F) "          "29/27 "     "19/17"    
##  [3,] "Age (years) "        "46±13 "     "41±16"    
##  [4,] "Urea (mg/dL) "       "39±28 "     "27±11"    
##  [5,] "Creatinine (mg/dL) " "1.16±0.54 " "0.87±0.27"
##  [6,] "Potassium (mEq/L) "  "4.3±0.6 "   "3.9±0.3"  
##  [7,] "Sodium (mEq/L) "     "136±7 "     "137±5"    
##  [8,] "Albumin (g/dL) "     "3.3±0.1 "   "3.3±0.1"  
##  [9,] "Bilirubin (mg/dL) "  "5.8±1.1 "   "2.7±0.9"  
## [10,] "Ascites "            "41 (73%) "  "22 (61%)" 
## [11,] "Encephalopathy "     "21 (38%) "  "11 (31%)" 
## [12,] "Variceal bleeding "  "21 (38%) "  "14 (39%)" 
## 
## $`Nakamura et al. 2009`
##       V1                                                        
##  [1,] ""                                                        
##  [2,] "Age (year-old) "                                         
##  [3,] "Male (%) "                                               
##  [4,] "Emergent operation (%) "                                 
##  [5,] "Location of the thoracic aortic diseases"                
##  [6,] "Proximal descending thoracic aorta adjacent to the Left "
##  [7,] "subclavian artery (%)"                                   
##  [8,] "Descending thoracic aorta (%) "                          
##  [9,] "Entire descending thoracic aorta (%) "                   
## [10,] "Aortic Pathology"                                        
## [11,] "Degenerative aneurysm (%) "                              
## [12,] "Chronic dissection (%) "                                 
## [13,] "Traumatic aortic injury (%) "                            
## [14,] "Postoperative pseudaneurysm (%) "                        
## [15,] "Infection (%) "                                          
## [16,] "Hypertension (%) "                                       
## [17,] "Heart disease (%) "                                      
## [18,] "COPD (%) "                                               
## [19,] "Previous Cerebrovascular disease (%) "                   
## [20,] "Preoperative renal dysfunction (%) "                     
## [21,] "Previous thoracotomy for lung or aortic disease (%) "    
## [22,] "Diabetes mellitus (%) "                                  
## [23,] "Perioperative hypotension (%) "                          
## [24,] "Reattachment of ICA to the graft "                       
## [25,] "Cross-clamping the aortic arch (%) "                     
## [26,] "Previous or concurrent AAA repair (%) "                  
##       V2                 V4               
##  [1,] "OS group (n 36) " "SG group (n 36)"
##  [2,] "70.19 ± 10.1 "    "70.89 ± 9.4"    
##  [3,] "66.7 "            "75.0"           
##  [4,] "16.7 "            "13.9"           
##  [5,] ""                 ""               
##  [6,] "13.9 "            "13.9"           
##  [7,] ""                 ""               
##  [8,] "75.0 "            "75.0"           
##  [9,] "11.1 "            "11.1"           
## [10,] ""                 ""               
## [11,] "66.7 "            "58.3"           
## [12,] "22.2 "            "25.0"           
## [13,] "8.3 "             "8.3"            
## [14,] "0 "               "5.6"            
## [15,] "2.8 "             "2.8"            
## [16,] "91.7 "            "83.3"           
## [17,] "16.7 "            "22.2"           
## [18,] "13.9 "            "8.3"            
## [19,] "5.6 "             "25.0"           
## [20,] "11.1 "            "11.1"           
## [21,] "0 "               "8.3"            
## [22,] "11.1 "            "2.8"            
## [23,] "8.3 "             "0"              
## [24,] "5.6 "             "0"              
## [25,] "13.9 "            "0"              
## [26,] "0 "               "19.4"
```

```r
myfiles[2,c(2,9)]
```

```
## $`Lima et al. 2003`
## $file
## [1] "Z:/Drive/Medicine/Science/Projecten/Esther Wesselink/Manuscripts/2. IOH and Outcomes Review/IOHReviewReadPDFs/Data extracts/tabula-2003 - Renal Failure - Lima et al.csv"
## 
## $cols
## [1] 2 3
## 
## $cellN
## [1] 2
## 
## $firstVar
## [1] 3
## 
## $startCol
## [1] 2
## 
## $subThousands
## [1] 1
## 
## attr(,"class")
## [1] "tableStructure"
## 
## $`Nakamura et al. 2009`
## $file
## [1] "Z:/Drive/Medicine/Science/Projecten/Esther Wesselink/Manuscripts/2. IOH and Outcomes Review/IOHReviewReadPDFs/Data extracts/tabula-2009 - Scandinavian Cardiovascular Journal - Nakamura et al.csv"
## 
## $cols
## [1] 2 4
## 
## $cellN
## [1] 1
## 
## $firstVar
## [1] 2
## 
## $startCol
## [1] 2
## 
## $subThousands
## [1] 1
## 
## attr(,"class")
## [1] "tableStructure"
```

## Explore data patterns

After the tables have been read they should be reencoded from string
to numerical values. So called regular expressions using `UNIX Grep` 
were used to match string patterns to different types. For our purpose, 
each cell should have only one matching expression to avoid wrong coding.  

Several functions were written to match regular expressions to the string data 
for each cell, and check whether a single expression was found for all table cells.

[Pattern match functions](https://github.com/tkappen/recodePDFtable/blob/master/grepFunctions/Baseline_grep_calls.R)

[Grep expressions](https://github.com/tkappen/recodePDFtable/blob/master/grepFunctions/Baseline_grep_expressions.R)

This what that looks like:



```r
grepTableSet(myfiles)[15]
```

```
## $`Siepe et al. 2011`
## $`Siepe et al. 2011`$V2
## $`Siepe et al. 2011`$V2$y.matrix
##        x[%] (SD_x)  (x%) x_(x[%]) x_(x)_abc   x±x  x__x x_(x-x) x_x-x
##  [1,] FALSE  FALSE FALSE    FALSE     FALSE FALSE FALSE   FALSE FALSE
##  [2,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
##  [3,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
##  [4,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
##  [5,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
##  [6,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
##  [7,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
##  [8,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
##  [9,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
## [10,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
## [11,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
## [12,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
## [13,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
## [14,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
## [15,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
## [16,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
## [17,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
##       x_(xtox) x_[x-x] x_[x,x] x_(x,x)   x/x   x:x x/x_(x/x) x:x_(x:x)
##  [1,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [2,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [3,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [4,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [5,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [6,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [7,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [8,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [9,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [10,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [11,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [12,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [13,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [14,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [15,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [16,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [17,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##       x__x_(x__x)    __   abc   n=x  n__x n_pats
##  [1,]       FALSE FALSE FALSE FALSE FALSE   TRUE
##  [2,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [3,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [4,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [5,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [6,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [7,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [8,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [9,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [10,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [11,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [12,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [13,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [14,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [15,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [16,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [17,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## 
## $`Siepe et al. 2011`$V2$rowsum
##  [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
## 
## $`Siepe et al. 2011`$V2$uniqueGrep
## [1] TRUE
## 
## $`Siepe et al. 2011`$V2$rowType
##  [1] "n_pats"   "x__x"     "x_(x[%])" "x__x"     "x_(x[%])" "x_(x[%])"
##  [7] "x_(x[%])" "x_(x[%])" "x_(x[%])" "x_(x[%])" "x_(x[%])" "x_(x[%])"
## [13] "x__x"     "x__x"     "x__x"     "x__x"     "x__x"    
## 
## 
## $`Siepe et al. 2011`$V3
## $`Siepe et al. 2011`$V3$y.matrix
##        x[%] (SD_x)  (x%) x_(x[%]) x_(x)_abc   x±x  x__x x_(x-x) x_x-x
##  [1,] FALSE  FALSE FALSE    FALSE     FALSE FALSE FALSE   FALSE FALSE
##  [2,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
##  [3,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
##  [4,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
##  [5,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
##  [6,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
##  [7,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
##  [8,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
##  [9,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
## [10,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
## [11,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
## [12,] FALSE  FALSE FALSE     TRUE     FALSE FALSE FALSE   FALSE FALSE
## [13,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
## [14,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
## [15,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
## [16,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
## [17,] FALSE  FALSE FALSE    FALSE     FALSE FALSE  TRUE   FALSE FALSE
##       x_(xtox) x_[x-x] x_[x,x] x_(x,x)   x/x   x:x x/x_(x/x) x:x_(x:x)
##  [1,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [2,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [3,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [4,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [5,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [6,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [7,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [8,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##  [9,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [10,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [11,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [12,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [13,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [14,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [15,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [16,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
## [17,]    FALSE   FALSE   FALSE   FALSE FALSE FALSE     FALSE     FALSE
##       x__x_(x__x)    __   abc   n=x  n__x n_pats
##  [1,]       FALSE FALSE FALSE FALSE FALSE   TRUE
##  [2,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [3,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [4,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [5,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [6,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [7,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [8,]       FALSE FALSE FALSE FALSE FALSE  FALSE
##  [9,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [10,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [11,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [12,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [13,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [14,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [15,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [16,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## [17,]       FALSE FALSE FALSE FALSE FALSE  FALSE
## 
## $`Siepe et al. 2011`$V3$rowsum
##  [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
## 
## $`Siepe et al. 2011`$V3$uniqueGrep
## [1] TRUE
## 
## $`Siepe et al. 2011`$V3$rowType
##  [1] "n_pats"   "x__x"     "x_(x[%])" "x__x"     "x_(x[%])" "x_(x[%])"
##  [7] "x_(x[%])" "x_(x[%])" "x_(x[%])" "x_(x[%])" "x_(x[%])" "x_(x[%])"
## [13] "x__x"     "x__x"     "x__x"     "x__x"     "x__x"
```


```r
# Check which tables are matched to a single grep expression
matchedTable(myfiles)
```

```
## All cells of all tables are matched to a single grep expression
```

```r
# Adjustments have been made to baseExpr() as well to a smaller 
# part to the data (history on Git) to ensure that all row of each 
# table have a single grep function associated
```

## Extract the data

Then the data had to be extracted for all numerical variables. However, each cell can contain 
multiple numbers. For these tables we assumed that there would be a maximum of four numbers:
1. the main number: `x`
2. a second number, separated by spaces, slashes or colons: `x y`
3. a first number within parentheses or brackets: (x)
4. a second number within parentheses or brackets, separated by different punctuation: (x-y)

Again, these expressions were written within a function that related to the the matched patterns
that were found using the previous matching functions. Other functions were written to match 
and extract different numbers.

[Grep extraction expressions](https://github.com/tkappen/recodePDFtable/blob/master/grepFunctions/Baseline_grep_substring_expressions.R)

[Number extraction functions](https://github.com/tkappen/recodePDFtable/blob/master/grepFunctions/Baseline_grep_calls_split.R)

An example:

```r
tableGrepNum(myfiles)[1]
```

```
## $`Barone et al. 2002`
## $`Barone et al. 2002`$V2
##                                                                     x
##                                                               (n = 0)
## Mean age/range                                       75 ± 10 (59-96) 
## Gender (male/female)                                            11/9 
## Diabetes mellitus                                             6 (30) 
## Hypertension                                                 11 (55) 
## Heart disease                                                 7 (35) 
## Variable (unmatched)                                                 
## Medical clearance                                            15 (75) 
## Emergency surgery                                             3 (15) 
## ASA classification                                               3.0 
## Operative duration (minutes)                                124 ± 74 
## Estimated blood loss (mL)                                  292 ± 714 
## Intravenous fluids given in the operating room (mL)      1338 ± 1352 
##                                                      pattern1 pattern2
##                                                             0       NA
## Mean age/range                                             75       NA
## Gender (male/female)                                       11        9
## Diabetes mellitus                                           6       NA
## Hypertension                                               11       NA
## Heart disease                                               7       NA
## Variable (unmatched)                                       NA       NA
## Medical clearance                                          15       NA
## Emergency surgery                                           3       NA
## ASA classification                                          3       NA
## Operative duration (minutes)                              124       NA
## Estimated blood loss (mL)                                 292       NA
## Intravenous fluids given in the operating room (mL)      1338       NA
##                                                      pattern3 pattern4
##                                                            NA       NA
## Mean age/range                                             10       NA
## Gender (male/female)                                       NA       NA
## Diabetes mellitus                                          30       NA
## Hypertension                                               55       NA
## Heart disease                                              35       NA
## Variable (unmatched)                                       NA       NA
## Medical clearance                                          75       NA
## Emergency surgery                                          15       NA
## ASA classification                                         NA       NA
## Operative duration (minutes)                               74       NA
## Estimated blood loss (mL)                                 714       NA
## Intravenous fluids given in the operating room (mL)      1352       NA
## 
## $`Barone et al. 2002`$V3
##                                                                    x
##                                                              (n = 0)
## Mean age/range                                       74 ± 11 (56-91)
## Gender (male/female)                                           22/18
## Diabetes mellitus                                             5 (13)
## Hypertension                                                 13 (33)
## Heart disease                                                11 (28)
## Variable (unmatched)                                                
## Medical clearance                                            27 (68)
## Emergency surgery                                            13 (33)
## ASA classification                                               2.8
## Operative duration (minutes)                                124 ± 46
## Estimated blood loss (mL)                                  241 ± 289
## Intravenous fluids given in the operating room (mL)      1447 ± 1221
##                                                      pattern1 pattern2
##                                                           0.0       NA
## Mean age/range                                           74.0       NA
## Gender (male/female)                                     22.0       18
## Diabetes mellitus                                         5.0       NA
## Hypertension                                             13.0       NA
## Heart disease                                            11.0       NA
## Variable (unmatched)                                       NA       NA
## Medical clearance                                        27.0       NA
## Emergency surgery                                        13.0       NA
## ASA classification                                        2.8       NA
## Operative duration (minutes)                            124.0       NA
## Estimated blood loss (mL)                               241.0       NA
## Intravenous fluids given in the operating room (mL)    1447.0       NA
##                                                      pattern3 pattern4
##                                                            NA       NA
## Mean age/range                                             11       NA
## Gender (male/female)                                       NA       NA
## Diabetes mellitus                                          13       NA
## Hypertension                                               33       NA
## Heart disease                                              28       NA
## Variable (unmatched)                                       NA       NA
## Medical clearance                                          68       NA
## Emergency surgery                                          33       NA
## ASA classification                                         NA       NA
## Operative duration (minutes)                               46       NA
## Estimated blood loss (mL)                                 289       NA
## Intravenous fluids given in the operating room (mL)      1221       NA
```

## Weighted averages

Up till now we assumed that tables with multiples columns should have a weighted average for each variable.
However, when frequencies are reported, it should not report the weighted average, 
but simply the sum across columns. Additionally, different types of variables require different
formatting in the final table. Thus we have to recognize which patterns are likely to belong to 
a particular type of variable. For example, `x (x-x)` is likely to belong to a median 
with interquartile range, but could also incidentally represent a mean with the full range.

### Get default cell types
Pattern groups were matched to particular types of variables in a function.
And then functions were used to create a default set of cell/variable types.

[Cell types](https://github.com/tkappen/recodePDFtable/blob/master/meanFunctions/Value_expressions.R)

[Get default types](https://github.com/tkappen/recodePDFtable/blob/master/meanFunctions/value_to_format.R)

For some tables the function will ask for input on the type for `x` (one value only):


```r
# get the default format type for all files
# dFormat <- getDefaultTypes(myfiles, checkFormats = TRUE)
# At the moment no function is available to check 
# dput(dFormat, "Z:/Drive/Medicine/Science/Projecten/Esther Wesselink/Manuscripts/2. IOH and Outcomes Review/IOHReviewReadPDFs/Data/default_formats_.R")
dFormat <- dget("Z:/Drive/Medicine/Science/Projecten/Esther Wesselink/Manuscripts/2. IOH and Outcomes Review/IOHReviewReadPDFs/Data/default_formats_.R")
```
  

```
Barone et al. 2002
      V1                                                   V2               V3             
 [1,]                                                      (n = 0)          (n = 0)        
 [2,] Mean age/range                                       75 ± 10 (59-96)  74 ± 11 (56-91)
 [3,] Gender (male/female)                                 11/9             22/18          
 [4,] Diabetes mellitus                                    6 (30)           5 (13)         
 [5,] Hypertension                                         11 (55)          13 (33)        
 [6,] Heart disease                                        7 (35)           11 (28)        
 [7,] Variable (unmatched)                                                                 
 [8,] Medical clearance                                    15 (75)          27 (68)        
 [9,] Emergency surgery                                    3 (15)           13 (33)        
[10,] ASA classification                                   3.0              2.8            
[11,] Operative duration (minutes)                         124 ± 74         124 ± 46       
[12,] Estimated blood loss (mL)                            292 ± 714        241 ± 289      
[13,] Intravenous fluids given in the operating room (mL)  1338 ± 1352      1447 ± 1221    

Is this a frequency (press 1), mean (2) or a percentage (3)?
```

### Tables without appropriate subject numbers

At the top of a column there is usually an indicator of the number of subjects within a group
 (mostly expressed like `(N = 459)`).
However, sometimes this `N` is missing. We used a [function](https://github.com/tkappen/recodePDFtable/blob/master/meanFunctions/weightedMean_functions.R)
 for that to prompt the user for missing `Ns`. The output is again written to a file for consistency.


```r
# Fill in the missing N = in tables
#
# missingN <- fillNnull(myfiles)
# dput(missingN, "Z:/Drive/Medicine/Science/Projecten/Esther Wesselink/Manuscripts/2. IOH and Outcomes Review/IOHReviewReadPDFs/Data/missing_Ns.R")
missingN <- dget("Z:/Drive/Medicine/Science/Projecten/Esther Wesselink/Manuscripts/2. IOH and Outcomes Review/IOHReviewReadPDFs/Data/missing_Ns.R")
```

### Changing some default cell types

Some manual changes had to be made to the formatting of the data, because
the default cell type was not appropriate, or some percentages are missing, because only 
frequencies are reported.

For example:

```
# Custom changes to format per row, mostly Freq(%) to Mean(SD) conversion
# i <- is the indicator of which rows need to be changed
# t <- which cellType it needs to become


# Display all cellTypes() as a reference
ct <- cellTypes()

# Function to add rows to data.frame that already has names
addRows <- function(x) {
	n <- 1:nrow(x)
	cbind(n,x)
}

# `Taffé et al. 2009`
addRows(myformatted$`Taffé et al. 2009`)
i <- c(2,3,22)
t <- c(2,5,2 )
dFormat$`Taffé et al. 2009`[i,] <- ct[t,]

# `Bijker et al. 2009`
addRows(myformatted$`Bijker et al. 2009`)
i <- c(2,4,28)
t <- c(7,7,7 )
dFormat$`Bijker et al. 2009`[i,] <- ct[t,]
```

And for calculation of percentages:

```
# Recalculate percentage from values that only have frequencies
# f <- is Frequencies without percentage
# t <- which cellType it needs to become

dFormat2 <- dFormat
ct <- cellTypes()

# `Petsiti et al. 2015`
addRows(myformatted$`Petsiti et al. 2015`)
f <- c(3,5,6,8,9,10,11,12,13,14,15,16,17,18,19)
n <- mywtdtables$`Petsiti et al. 2015`[1,1]
p <- round(mywtdtables$`Petsiti et al. 2015`[f,1]/n*100,0)
mywtdtables$`Petsiti et al. 2015`[f,1] <- p
# Change 3rd row, second column
p <- round(mywtdtables$`Petsiti et al. 2015`[3,2]/n*100,0)
mywtdtables$`Petsiti et al. 2015`[3,2] <- p
dFormat2$`Petsiti et al. 2015`[f,] <- ct[3,]
dFormat2$`Petsiti et al. 2015`[3,] <- ct[14,]
dFormat2$`Petsiti et al. 2015`[3,"formatFUN"] <- "paste(p1,\"%:\",p2,\"%\", sep = \"\")"
```




### Calculate and format summary data

After all the formats have been adjusted, we now need to calculate weighted means and sums. 
In addition, appropriate formatting is applied and converted back to a formatted table
 (although it is possible to extract only the numerical values as well).

[Weighing functions](https://github.com/tkappen/recodePDFtable/blob/master/meanFunctions/weightedMean_functions.R)

And the result:

![Kheterpal et al.](https://github.com/tkappen/recodePDFtable/blob/master/Images/15TT1.png)


```r
formatTables(mywtdtables, dFormat2, formatonly=TRUE)[11]
```

```
## $`Kheterpal et al. 2009`
##                                                           y
## 1                                                      7740
## Age 68                                                  23%
## Body mass index                                         37%
## Male sex                                                51%
## Orally controlled diabetes mellitus                      7%
## Insulin controlled diabetes mellitus                     6%
## History of chronic obstructive pulmonary disease         4%
## Ascites                                                  1%
## Active congestive heart failure                          1%
## Acute renal failure                                      1%
## Preoperative dialysis dependence                         2%
## Cerebrovascular disease                                  5%
## History of myocardial infarction within past 6 months    1%
## Previous cardiac intervention*                          10%
## History of angina within 1 month before surgery          1%
## Hypertension requiring medications                      40%
## History of peripheral vascular occlusive disease         4%
## Emergency surgery                                       12%
## High-risk surgery                                       22%
```

### Writing to datasets

I did not do the restructuring of all tables into a single table with code, because it would require
all kinds of classifications of the variables (which variables across different tables are the same).
So I simply exported the formatted tables and did the rest manually.

```
write.multi.csv(myresults, directory, FUN = write.csv2)


# Write all files into separate named files
write.multi.csv <- function (x, directory, FUN = write.csv) {
	FUN <- match.fun(FUN)
	f <- function (x, d) paste(d, x,".csv", sep="")
	namelist <- sapply(names(x), f, d = directory)
	mapply(FUN, x, namelist)
}
```

## The final result

![Results](https://github.com/tkappen/recodePDFtable/blob/master/Images/Summary%20Baseline%20Data.png)




