# recodePDFtable
### R recode PDF tables to structured tables

This project aims to recode PDF tables from scientific papers that were 
captured using [tabula](https://github.com/tabulapdf/tabula) into structured tables.

##Introduction
Typically scientific papers contain multiple tables, such as baseline data (for which I created these functions). 
However the format of these tables do not directly allow for structured analysis of these tables.
The functions in this repository aim to provide functions to read the `tabula`-extracted tables into R
and then recode the data into structured data. 
It does require human input, e.g. for the character encoding scheme, and to determine which tables are what.

The funcions here have not been very well defined yet, so when you have any questions, please contact me.
