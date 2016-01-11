Intraoperative Hypotension Review - Summarizing data from a PDF
===============================================================


This document explains how numerical data from PDF tables is extracted, recoded and
summarized.

## Introduction

The review is about the relation between intraoperative low blood pressure or hypotension (IOH).
In this review we summarize the results of over 30 publication that studied this topic.
In a review we often assess the quality of the studies and summarize that in a table, 
and we also summarize the results of the studies. However, we hardly ever 
provide background information about what kind of subjects were included, i.e. the baseline
characteristics.

<br />
A regular manuscript includes a 'Table 1' - or a baseline table.
This provides background info on the characteristics of the subjects that are included.
Such a table can look like this.   
<br />
![Wesselink et al.](https://github.com/tkappen/recodePDFtable/blob/master/Images/Wesselink%20et%20al%20-%20Table%201.png)
<br/>
<br />
We can already see that there are multiple numbers within a single cell with multiple formats.
Yet, this table includes the data from the total cohort of subjects.
This table for example, shows only the data for different subgroups.  
<br />
![Sun et al.](https://github.com/tkappen/recodePDFtable/blob/master/Images/Sun%20et%20al%20-%20Table%201.png)
<br />
<br />
To get the information from the total group, we have to calculate the weighted average 
for each number of each variable. 
The presented project thus aimed to:

1. Extract tables from PDF with [Tabula](https://github.com/tabulapdf/tabula) (not further discussed in this document)
2. Read all tables into R
3. Recognize different patterns of numbers within individual cells
4. Recode these patterns into separate numbers for separate cells
5. Get a weighted average for each number if data is split into groups
6. Provide functionality to get an appropriate format: continuous data require different thing from categorical data


<br />
```
title: "Intraoperative Hypotension Review - Summarizing data from a PDF"
author: "Teus Kappen"
date: "January 10 2015"
output: 
  html_document: 
    fig_caption: yes
    highlight: tango
```
