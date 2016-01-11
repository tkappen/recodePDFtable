---
title: "Intraoperative Hypotension Review - Code for summarizing data from a PDF"
author: "Teus Kappen"
date: "January 10 2016"
output: 
  html_document: 
    fig_caption: yes
---



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
files_full <- list.files("./Data extracts", full.names=T, pattern="*.csv")
files_full
```

```
##  [1] "./Data extracts/tabula-2002 - Journal of intensive care medicine - Barone et al.csv"                    
##  [2] "./Data extracts/tabula-2003 - Renal Failure - Lima et al.csv"                                           
##  [3] "./Data extracts/tabula-2005 - Anesthesia and Analgesia - Monk et al.csv"                                
##  [4] "./Data extracts/tabula-2006 - Sharma et al.csv"                                                         
##  [5] "./Data extracts/tabula-2007 - Clinical Journal of the American Society of Nephrology - Thakar et al.csv"
##  [6] "./Data extracts/tabula-2007 - Tallgren et al.csv"                                                       
##  [7] "./Data extracts/tabula-2008 - Journal of Korean Neurosurgical Society - Chong et al.csv"                
##  [8] "./Data extracts/tabula-2009 - Acta anaesthesiologica Scandinavica - Taffé et al.csv"                    
##  [9] "./Data extracts/tabula-2009 - Scandinavian Cardiovascular Journal - Nakamura et al.csv"                 
## [10] "./Data extracts/tabula-2009 Bijker et al.csv"                                                           
## [11] "./Data extracts/tabula-2009 Kheterpal et al.csv"                                                        
## [12] "./Data extracts/tabula-2011 - British Journal of Anaesthesia - Sabaté et al.csv"                        
## [13] "./Data extracts/tabula-2011 - Journal of anesthesia - Tassoudis et al.csv"                              
## [14] "./Data extracts/tabula-2011 - Journal of International Medical Research - Franck et al.csv"             
## [15] "./Data extracts/tabula-2011 - Siepe et al.csv"                                                          
## [16] "./Data extracts/tabula-2011 Patti et al.csv"                                                            
## [17] "./Data extracts/tabula-2012 - Nephrology Dialysis Transplantation - Haase et al.csv"                    
## [18] "./Data extracts/tabula-2012 Bijker et al.csv"                                                           
## [19] "./Data extracts/tabula-2013 - Anesthesiology research and practice - Aronson et al.csv"                 
## [20] "./Data extracts/tabula-2013 - Chinese medical journal - Yue et al.csv"                                  
## [21] "./Data extracts/tabula-2013 Walsh et al.csv"                                                            
## [22] "./Data extracts/tabula-2014 - Transplantation proceedings - Sirivatanauksorn et al.csv"                 
## [23] "./Data extracts/tabula-2014 Pipanmekaporn et al.csv"                                                    
## [24] "./Data extracts/tabula-2015 - Anesthesiology - Mascha et al.csv"                                        
## [25] "./Data extracts/tabula-2015 - Anesthesiology - Monk et al.csv"                                          
## [26] "./Data extracts/tabula-2015 - Anesthesiology - Sun et al.csv"                                           
## [27] "./Data extracts/tabula-2015 - Anesthesiology Research and Practice - Petsiti et al.csv"                 
## [28] "./Data extracts/tabula-2015 - British journal of anaesthesia - Hirsch et al.csv"                        
## [29] "./Data extracts/tabula-2015 - British journal of anaesthesia - Wesselink et al.csv"
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
# dput(myfiles2[2,], "./Data/tableStructures.R")

# Create more simple names from filenames
m1 <- regexpr("[[:upper:]][[:alnum:][:space:]]+[.]",files_full)
m2 <- regexpr("[[:digit:]]+",files_full)
mynames <- paste(regmatches(files_full,m1), regmatches(files_full,m2))

# Re-read existing table structure and load tables
listStruct <- dget("./Data/tableStructures.R")
myfiles <- read.multi(files_full, 
	baseEncoding = "UTF-8", baseFileEncoding = "windows-1252",
	altEncoding = "windows-1252", altFileEncoding = "437",
 	listStruct= listStruct, row.names = mynames)

# Read only the tables into separte variable
myfiles[1,2:3]
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
## $`Monk et al. 2005`
##       V1                                                                                             
##  [1,] ""                                                                                             
##  [2,] "Age (yr) "                                                                                    
##  [3,] "Weight (kg) "                                                                                 
##  [4,] "Body mass index (kg/m2) "                                                                     
##  [5,] "Gender (female:male) "                                                                        
##  [6,] "Preoperative Mini-Mental State examination score "                                            
##  [7,] "Preoperative Beck Depression Inventory "                                                      
##  [8,] "Preoperative State Trait Anxiety Inventory "                                                  
##  [9,] "Educational level (yr) "                                                                      
## [10,] "Race"                                                                                         
## [11,] "White "                                                                                       
## [12,] "Black "                                                                                       
## [13,] "Other "                                                                                       
## [14,] "Marital status"                                                                               
## [15,] "Widowed or single "                                                                           
## [16,] "Married or living as married "                                                                
## [17,] "Medical history"                                                                              
## [18,] "Heart disease "                                                                               
## [19,] "Angina pectoris "                                                                             
## [20,] "Myocardial infarction "                                                                       
## [21,] "Hypertension "                                                                                
## [22,] "Stroke "                                                                                      
## [23,] "Hepatic disease "                                                                             
## [24,] "Diabetes (insulin-dependent) "                                                                
## [25,] "Peripheral ischemia "                                                                         
## [26,] "Depression "                                                                                  
## [27,] "Previous anesthetic "                                                                         
## [28,] "Alcohol consumption (units/wk)"                                                               
## [29,] "None "                                                                                        
## [30,] "1<U+0096>7 "                                                                                         
## [31,] "8<U+0096>14 "                                                                                        
## [32,] "15 "                                                                                          
## [33,] "Tobacco use (pack-years)"                                                                     
## [34,] "0 "                                                                                           
## [35,] "1<U+0096>10 "                                                                                        
## [36,] "11<U+0096>20 "                                                                                       
## [37,] "21 "                                                                                          
## [38,] "New York Heart Association functional class"                                                  
## [39,] "Class 1 "                                                                                     
## [40,] "Class 2 "                                                                                     
## [41,] "Class 3 or 4 "                                                                                
## [42,] "Charlson Comorbidity Score"                                                                   
## [43,] "0<U+0096>2 "                                                                                         
## [44,] "3 "                                                                                           
## [45,] "ASA physical status"                                                                          
## [46,] "I "                                                                                           
## [47,] "II "                                                                                          
## [48,] "III or IV "                                                                                   
## [49,] "Preoperative systolic blood pressure (mm Hg) "                                                
## [50,] "Preoperative diastolic blood pressure (mm Hg) "                                               
## [51,] "Preoperative hematocrit "                                                                     
## [52,] "Preoperative hemoglobin "                                                                     
## [53,] "Surgery type"                                                                                 
## [54,] "Intracavitary "                                                                               
## [55,] "Minimally invasive or superficial "                                                           
## [56,] "Orthopedic "                                                                                  
## [57,] "Surgical duration (h) "                                                                       
## [58,] "Maintenance anesthetic"                                                                       
## [59,] "Volatile "                                                                                    
## [60,] "IV only "                                                                                     
## [61,] "Unknown "                                                                                     
## [62,] "Intraoperative opioid administration "                                                        
## [63,] "Neuromuscular blockade "                                                                      
## [64,] "Duration of systolic blood pressure 80 mm Hg (min), patients with non-zero duration (n 203) " 
## [65,] "Duration of systolic blood pressure 160 mm Hg (min), patients with non-zero duration (n 331) "
## [66,] "Duration of mean arterial blood pressure 55 mm Hg (min), patients with non-zero duration (n " 
## [67,] "Duration of mean arterial blood pressure 100 mm Hg (min), patients with non-zero duration (n "
## [68,] "Duration of heart rate 45 bpm (min), patients with non-zero duration (n 45) "                 
## [69,] "Duration of heart rate 110 bpm (min), patients with non-zero duration (n 205) "               
## [70,] "Cumulative deep hypnotic time (h) "                                                           
##       V4                
##  [1,] "(n = 0)"         
##  [2,] "51 (37<U+0096>65)"      
##  [3,] "82 (67<U+0096>100)"     
##  [4,] "27.9 (24.1<U+0096>34.2)"
##  [5,] "63.5%:36.5%"     
##  [6,] "30 (29<U+0096>30)"      
##  [7,] "5 (2<U+0096>10)"        
##  [8,] "65 (54<U+0096>81)"      
##  [9,] "13 (12<U+0096>15)"      
## [10,] ""                
## [11,] "89.4%"           
## [12,] "9.4%"            
## [13,] "1.2%"            
## [14,] ""                
## [15,] "33.3%"           
## [16,] "66.7%"           
## [17,] ""                
## [18,] "10.2%"           
## [19,] "5.7%"            
## [20,] "5.5%"            
## [21,] "33.1%"           
## [22,] "3.6%"            
## [23,] "5.2%"            
## [24,] "3.9%"            
## [25,] "8.1%"            
## [26,] "16.2%"           
## [27,] "91.0%"           
## [28,] ""                
## [29,] "75.8%"           
## [30,] "19.5%"           
## [31,] "3.3%"            
## [32,] "1.4%"            
## [33,] ""                
## [34,] "50.8%"           
## [35,] "14.8%"           
## [36,] "10.2%"           
## [37,] "24.2%"           
## [38,] ""                
## [39,] "67.5%"           
## [40,] "23.8%"           
## [41,] "8.7%"            
## [42,] ""                
## [43,] "81.4%"           
## [44,] "18.6%"           
## [45,] ""                
## [46,] "13.1%"           
## [47,] "51.9%"           
## [48,] "35.0%"           
## [49,] "131 (118<U+0096>145)"   
## [50,] "78 (70<U+0096>84)"      
## [51,] "37.6 (34.3<U+0096>40.4)"
## [52,] "12.8 (11.6<U+0096>13.9)"
## [53,] ""                
## [54,] "55.8%"           
## [55,] "18.3%"           
## [56,] "25.9%"           
## [57,] "3.1 (2.3<U+0096>4.3)"   
## [58,] ""                
## [59,] "90.9%"           
## [60,] "8.3%"            
## [61,] "0.8%"            
## [62,] "96.0%"           
## [63,] "88.3%"           
## [64,] "5.0 (5.0<U+0096>10.0)"  
## [65,] "10.0 (5.0<U+0096>20.0)" 
## [66,] "10.0 (5.0<U+0096>15.0)" 
## [67,] "20.0 (10.0<U+0096>40.0)"
## [68,] "10.0 (5.0<U+0096>22.5)" 
## [69,] "10.0 (5.0<U+0096>20.0)" 
## [70,] "1.1 (0.3<U+0096>2.1)"
```

```r
myfiles[2,2:3]
```

```
## $`Lima et al. 2003`
## $file
## [1] "./Data extracts/tabula-2003 - Renal Failure - Lima et al.csv"
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
## $`Monk et al. 2005`
## $file
## [1] "./Data extracts/tabula-2005 - Anesthesia and Analgesia - Monk et al.csv"
## 
## $cols
## [1] 4
## 
## $cellN
## [1] 0
## 
## $firstVar
## [1] 1
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
grepTableSet(myfiles)[[15]]
```

```
## $V2
## $V2$y.matrix
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
## $V2$rowsum
##  [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
## 
## $V2$uniqueGrep
## [1] TRUE
## 
## $V2$rowType
##  [1] "n_pats"   "x__x"     "x_(x[%])" "x__x"     "x_(x[%])" "x_(x[%])"
##  [7] "x_(x[%])" "x_(x[%])" "x_(x[%])" "x_(x[%])" "x_(x[%])" "x_(x[%])"
## [13] "x__x"     "x__x"     "x__x"     "x__x"     "x__x"    
## 
## 
## $V3
## $V3$y.matrix
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
## $V3$rowsum
##  [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
## 
## $V3$uniqueGrep
## [1] TRUE
## 
## $V3$rowType
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
tableGrepNum(myfiles)[[1]]
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 34 --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 34 --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 24,36,37,38,39 --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 16,20,26,28,30 --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 16,20,26,28,30 --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 49,50 --> row.names NOT used
```

```
## Warning in data.row.names(row.names, rowsi, i): some row.names duplicated:
## 49,50 --> row.names NOT used
```

```
## $V2
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
## $V3
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
# dput(dFormat, "./Data/default_formats_.R")
dFormat <- dget("./Data/default_formats_.R")
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
# dput(missingN, "./Data/missing_Ns.R")
missingN <- dget("./Data/missing_Ns.R")
```

### Changing some default cell types

Some manual changes had to be made to the formatting of the data, because
the default cell type was not appropriate, or some percentages are missing, because only 
frequencies are reported.

[Change cell types for format](https://github.com/tkappen/IOHReviewReadPDFs/blob/master/Data/changeFormat_tables.R)

[Calculate missing percentages](https://github.com/tkappen/IOHReviewReadPDFs/blob/master/Data/calculate_missing_Percentages.R)




### Calculate and format summary data

After all the formats have been adjusted, we now need to calculate weighted means and sums. 
In addition, appropriate formatting is applied and converted back to a formatted table
 (although it is possible to extract only the numerical values as well).

[Weighing functions](https://github.com/tkappen/recodePDFtable/blob/master/meanFunctions/weightedMean_functions.R)

And the result:

![Sun et al.](https://github.com/tkappen/recodePDFtable/blob/master/Images/Sun%20et%20al%20-%20Table%201.png)


```r
formatTables(mywtdtables, dFormat2, formatonly=TRUE)[[26]]
```

```
##                                       y
## 1                                  5127
## Age (yr)                      61.3±14.2
##  Female                             53%
##  Hypertension                       48%
## Coronary artery disease             11%
##  Heart failure                       1%
##  Peripheral vascular disease         8%
##  Cerebrovascular disease             2%
##  Chronic obstructive                 9%
## pulmonary disease                      
## Diabetes                            15%
## Estimated glomerular                   
## filtration rate (ml/min)               
## >60                                 83%
## 30<U+0096>60                               15%
## <30                                  1%
## Anemia                              16%
## Malignancy                          53%
## Preoperative medications               
## ACE inhibitor                       16%
##  Angiotensin receptor               11%
## blocker                                
##  ß Blocker                          16%
##  Type of surgery                       
##  General surgery                    26%
## Vascular                            10%
##  Thoracic                           26%
## Gynecological                       17%
## Ear, nose, and throat               16%
##  Plastic                             4%
## Intraoperative                         
##  Blood Loss (ml)                       
##  =100                                8%
## 101<U+0096>600                              7%
##  601<U+0096>1000                           31%
##  >1000                              54%
##  Duration of surgery (h)               
##  =2                                 21%
##  2<U+0096>5                                49%
##   =5                                30%
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




