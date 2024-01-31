# Walmart-Sales

The dataset contains info about Walmart sales.<br>
Columns x Rows = 1000 x 17<br>
The factors involved and affecting the sales are studied and queried as per.<br>

The columns in the dataset are<br>
`Invoice ID` VARCHAR <br>
`Branch`VARCHAR <br>
`City` VARCHAR <br>
`Customer type` VARCHAR <br>
`Gender` VARCHAR <br>
`Product line` VARCHAR <br>
`Unit price` FLOAT <br>
`Quantity` INT <br>
`Tax 5%` FLOAT <br>
`Total`  FLOAT <br>
`Date` DATE <br>
`Time` TIME <br>
`Payment` VARCHAR <br>
`cogs`FLOAT <br>
`gross margin percentage` DOUBLE <br>
`gross income` FLOAT <br>
`Rating` FLOAT


__"Sales"__ able is created based on the above columns.
`NOT NULL` constraint is used in all columns to ensure there is no problem with data importing and EDA later on.

We can use time to extract the time of day (Morning, Afternoon, Evening, Night) as `"time_of_day"`<br>
Similarly we can use date to find out day, month and year as well for convenience.<br>

