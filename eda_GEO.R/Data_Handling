getwd()
setwd("~/Desktop/GEO_metadata/")
meta_47994 <- read.csv("GSE47994_METAdata.csv")
meta_109710 <- read.csv("meta_109710.csv")
meta_114403 <- read.csv("meta_114403.csv")
meta_137356 <- read.csv("meta_137356.csv")
meta_186102 <- read.csv("meta_186102.csv")
meta_58984 <- read.csv("meta_58984.csv")

#meta_114403 changes 
colnames(meta_114403)[9] <- "til.count.reader.1"
colnames(meta_114403)[10] <- "til.count.reader.2"
colnames(meta_114403)[11] <- "pd.l1.ihc.tumor....r.1"
colnames(meta_114403)[12] <- "pd.l1.ihc.tumor....r.2"
colnames(meta_114403)[13] <- "pd.l1.ihc.ic....r.1"
colnames(meta_114403)[14] <- "pd.l1.ihc.ic....r.1.1"
colnames(meta_114403)[15] <- "ER/PR_status"
colnames(meta_114403)[16] <- "PCR_status"
colnames(meta_114403)[17] <- "treatment_arm" #treatment arm (1 if assigned to bevacizumab (arm a);0 if assigned to control (arm b + c))
meta_114403$til.count.reader.1 <- gsub("til.count.reader.1:", "", meta_114403$til.count.reader.1)
meta_114403$til.count.reader.2 <- gsub("til.count.reader.2:", "", meta_114403$til.count.reader.2)
meta_114403$pd.l1.ihc.tumor....r.1 <- gsub("pd.l1.ihc.tumor....r.1:", "", meta_114403$pd.l1.ihc.tumor....r.1)
meta_114403$pd.l1.ihc.tumor....r.2 <- gsub("pd.l1.ihc.tumor....r.2:", "", meta_114403$pd.l1.ihc.tumor....r.2)
meta_114403$pd.l1.ihc.ic....r.1 <- gsub("pd.l1.ihc.ic....r.1:", "", meta_114403$pd.l1.ihc.ic....r.1)
meta_114403$pd.l1.ihc.ic....r.1.1 <- gsub("pd.l1.ihc.ic....r.1.1:", "", meta_114403$pd.l1.ihc.ic....r.1.1)
meta_114403$`ER/PR_status` <- gsub("\\s", "", meta_114403$`ER/PR_status`) #er/pr status (1 if er+ or pr+; 0 if er- and pr-)
meta_114403$`ER/PR_status` <- gsub("er/prstatus", "", meta_114403$`ER/PR_status`)
meta_114403$`ER/PR_status` <- gsub("[()]", "", meta_114403$`ER/PR_status`)
meta_114403$`ER/PR_status` <- gsub("[+]", "", meta_114403$`ER/PR_status`)
meta_114403$`ER/PR_status` <- gsub("[-]", "", meta_114403$`ER/PR_status`)
meta_114403$`ER/PR_status` <- gsub("[;]", "", meta_114403$`ER/PR_status`)
meta_114403$`ER/PR_status` <- gsub("1iferorpr0iferandpr:", "", meta_114403$`ER/PR_status`)
meta_114403$PCR_status <- gsub("\\s", "", meta_114403$PCR_status) #"pcr status (1 if pcr; 0 if residual disease or progressed before surgery): 1"
meta_114403$PCR_status <- gsub("[()]", "", meta_114403$PCR_status)
meta_114403$PCR_status <- gsub("[;]", "", meta_114403$PCR_status)
meta_114403$PCR_status <- gsub("pcrstatus1ifpcr0ifresidualdiseaseorprogressedbeforesurgery:", "", meta_114403$PCR_status)
meta_114403$treatment_arm <- gsub("\\s", "", meta_114403$treatment_arm) #"treatment arm (1 if assigned to bevacizumab (arm a); 0 if assigned to control (arm b + c)): 1"
meta_114403$treatment_arm <- gsub("[()]", "", meta_114403$treatment_arm)
meta_114403$treatment_arm <- gsub("[;]", "", meta_114403$treatment_arm)
meta_114403$treatment_arm <- gsub("[+]", "", meta_114403$treatment_arm)
meta_114403$treatment_arm <- gsub("treatmentarm1ifassignedtobevacizumabarma0ifassignedtocontrolarmbc:", "", meta_114403$treatment_arm)
write.csv(meta_114403, "meta_114403_rev.csv")
#EDA_109710 [9] "Gender" "Tissue" "Tumor_Type" "Age" "ER_status" "Grade" "Stage" "PR_status" "pcr_status" "dfs_event" "dfs_time"                  "Biomolecule_type"         

meta_109710 <- transform(meta_109710, Age = as.numeric(Age))
meta_109710 <- transform(meta_109710, Grade = as.character(Grade))
meta_109710 <- transform(meta_109710, pcr_status = as.character(pcr_status))
meta_109710 <- transform(meta_109710, dfs_event = as.character(dfs_event))
meta_109710 <- transform(meta_109710, dfs_time = as.numeric(dfs_time))
################################
str(meta_114403)
colnames(meta_114403) #7 sample source name(char) 9:14, 15-17 ("1" or "0")
meta_114403[9:17] <- lapply(meta_114403[9:17], FUN = function(y){as.numeric(y)})
meta_114403[15:17] <- lapply(meta_114403[15:17], FUN = function(y){as.character(y)})
###############
str(meta_137356) #7 BC_subtype(char), 9 treatment group (char), 10 nodal status (char), 11 tumor size(char)
##############
str(meta_186102) #9:12 (num), 13:16, 19 (char) 
meta_186102 <- meta_186102 %>% mutate(TNBC_status = if_else(ER_status == " Negative" & PR_status == " Negative" & HER2_status == " Negative", "Positive", "Negative" ))
meta_186102[,c(9:10,12)] <- lapply(meta_186102[,c(9:10,12)], FUN = function(y){as.numeric(y)})
###############
str(meta_47994) #8:23
meta_47994[,c(8:10,12,18,20)] <- lapply(meta_47994[,c(8:10,12,18,20)], FUN = function(y){as.character(y)})
meta_47994[,c(13,16,17)] <- lapply(meta_47994[,c(13,16,17)], FUN = function(y){as.numeric(y)})
#####################
meta_58984 <- as.data.frame(meta_58984)
str(meta_58984)
meta_58984[,c(15:17)] <- lapply(meta_58984[,c(15:17)], FUN = function(y){as.character(y)})
hist.data.frame(meta_58984[,c(11:20)])
#plots_in_R : GSE109710
# str(meta_109710)
# n <- dim(meta_109710)[2]
# col_list <- colnames(meta_109710) 
# names <- names(meta_109710)
# classes<-sapply(meta_109710,class)
#1 for(name in names[classes == 'numeric'])
# {
#   dev.new()
#   hist(meta_109710[,name]) # subset with [] not $
# }
# 
#2 for (column in meta_109710[classes =='numeric']) {
#   dev.new()
#   hist(column)
# }
BiocManager::install("Hmisc")
library(Hmisc)
hist.data.frame(meta_109710[,c(12:19)])#done "Age", "ER_status", "Grade", Stage", "PR_status", "pcr_status", "dfs_event", "dfs_time"
hist.data.frame(meta_114403[,c(7,9:17)]) #done
hist.data.frame(meta_137356[,c(7,9:11)]) #done
hist.data.frame(meta_186102[,c(9:15,18)]) #error
hist.data.frame(meta_47994[,c(8:23)]) #error

summary(meta_109710[,c(12:19)])
summary(meta_114403[,c(7,9:17)])
summary(meta_137356[,c(7,9:11)])
summary(meta_186102[,c(9:15,18)])
summary(meta_47994[,c(11,19,21)])

##################
