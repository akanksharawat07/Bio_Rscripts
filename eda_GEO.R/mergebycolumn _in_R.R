# To merge two data frames in R, you can use the merge() function. This function combines the rows of two data frames based on common values in one or more columns. Here is an example of how to use merge():
# Load the data frames

df1 <- read.table(text = "
  id score
  1  75
  2  80
  3  90
  4  95
", header = TRUE)

df2 <- read.table(text = "
  id name
  3  Alice
  4  Bob
  5  Carol
", header = TRUE)

# Merge the data frames
merged_df <- merge(df1, df2, by = "id")

# Print the merged data frame
print(merged_df)

# The resulting data frame merged_df would contain the rows from df1 and df2 that have matching values in the id column:
# id score name
# 1  3    90 Alice
# 2  4    95  Bob

# By default, merge() will only include rows that have a match in both data frames. If you want to include all rows from both data frames, regardless of whether there is a match in the other data frame, you can use the all = TRUE argument.

# Merge the data frames, including all rows
merged_df <- merge(df1, df2, by = "id", all = TRUE)

# Print the merged data frame
print(merged_df)

# This will result in a data frame with all rows from both df1 and df2, and NA values for missing data:

# id score  name
# 1  1    75  <NA>
#   2  2    80  <NA>
#   3  3    90 Alice
# 4  4    95   Bob
# 5  5   <NA> Carol
