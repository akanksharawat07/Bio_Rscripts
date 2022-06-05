# Rscripts for Data Handling
## Importing datasets in R
> what are dummy datasets in R? lets explore......
```
> data()
```
![dataset1_img](https://raw.githubusercontent.com/akanksharawat07/Bioinfo_Rscripts/main/datasets.png)
> selecting ToothGrowth as the dataset of choice and viewing its parameters 
```
> ?ToothGrowth
> head(ToothGrowth)
> head(ToothGrowth[1:10, 1:3])
> head(ToothGrowth[1:4, 1:2])
```
![dataset2 img](https://github.com/akanksharawat07/Bioinfo_Rscripts/blob/main/dataset1.png)
> `class()` function tells about the type of dataset used 
> `dim()` function is used to view the dimensions of a dataframe
> `head()` function is used to view first few lines of the dataframe you want to view 
> `head(<dataframe>[rows, columns])` by default the `head()` throws 6 rows along with some cols. of a dataframe, this is evident from the above attached snippet, the number of rows that can be viewed using `head()` is maximum by 6 and minimum number can be your choice. Since the dataframe has just three columns  
