#1. data download using TCGAbiolinks###
setwd("~/Desktop/TCGAbiolinks")
BiocManager::install("TCGAbiolinks")
library(TCGAbiolinks)
query.exp.hg19 <- GDCquery(project = "TCGA-BRCA", data.category = "Gene expression", data.type = "Gene expression quantification", platform = "Illumina HiSeq", file.type  = "results", experimental.strategy = "RNA-Seq", legacy = TRUE)
TCGAbiolinks2 <- file.path(getwd())
GDCdownload(query = query.exp.hg19, directory = TCGAbiolinks2)
expdat <- GDCprepare(query.exp.hg19, directory = TCGAbiolinks2)
sample.info <- SummarizedExperiment::colData(expdat)
library(SummarizedExperiment)
#2. get expression matrix
exp.brca <- assay(expdat, "raw_count") #  19947  1215
#3. cleanup of count data, where sample ids are trimmed using gsub in order to matchit with the metafile samples
exp.brca.t <- as.data.frame(t(exp.brca))
exp.brca.t1 <- tibble::rownames_to_column(exp.brca.t, "SampleID")
exp.brca.t1$SampleID <- gsub(".{13}$", "", as.character(exp.brca.t1$SampleID))
exp.brca.t2 <- tibble::column_to_rownames(exp.brca.t1, "SampleID")
exp.brca.t2r <- as.data.frame(t(exp.brca.t2)) #gene present as rownames
exp.brca.t2r.t <- as.data.frame(t(exp.brca.t2r))
dim(exp.brca.t2r)
#to remove the bar followed by number from gene ID
exp.brca.t2r_bm <- adj.brca.t2r 
exp.brca.t2r_bm<- tibble::rownames_to_column(exp.brca.t2r_bm, "GeneID") 
rownames(exp.brca.t2r_bm) <- rownames(adj.brca.t2r)
exp.brca.t2r_bm$GeneID <- gsub("\\|.*", "", as.character(exp.brca.t2r_bm$GeneID)) #to remove anything that after |(bar) incuding | itself 
exp.brca.t2r_bm<- tibble::rownames_to_column(exp.brca.t2r_bm, "GeneID1")
head(exp.brca.t2r_bm[1:10,1:10])
dim(exp.brca.t2r_bm) # 19947  1217
#to remove the rows having duplicate gene symbol as ? 
# length(unique(exp.brca.t2r_bm$GeneID)) #[1] 19938
# table(exp.brca.t2r_bm$GeneID>2) #FALSE 9 TRUE 19938
exp.brca.t2r_bm <- exp.brca.t2r_bm[!duplicated(exp.brca.t2r_bm$GeneID),]
dim(exp.brca.t2r_bm) #19938  1217
geneID1 <- as.data.frame(exp.brca.t2r_bm[,1]) 
head(geneID1)
colnames(geneID1)[1] <- "geneID1"
head(exp.brca.t2r_bm[1:10,1:10])
exp.brca.t2r_bm <- exp.brca.t2r_bm[,-1]
rownames(exp.brca.t2r_bm) <- NULL 
exp.brca.t2r_bm <- tibble::column_to_rownames(exp.brca.t2r_bm, "GeneID") #gene ID1 WILL be preserved for future use when matching gene names etc rn we need just gene ID for extraction of gene length from biomart after this will remove the rownames with gene id1
library(devtools)
# if(!require(devtools)) install.packages("devtools")
# devtools::install_github("AAlhendi1707/countToFPKM", build_vignettes = TRUE)
library(countToFPKM)
# require(biomaRt) #https://davetang.org/muse/2012/04/27/learning-to-use-biomart/
library(biomaRt)
# ensembl <- useMart('ensembl', dataset = 'hsapiens_gene_ensembl') # https://www.biostars.org/p/136775/
grch37 = useMart(biomart="ENSEMBL_MART_ENSEMBL", host="grch37.ensembl.org", path="/biomart/martservice", dataset="hsapiens_gene_ensembl")
#ensembl_75 = useMart(biomart="ENSEMBL_MART_ENSEMBL", host="feb2014.archive.ensembl.org", path="/biomart/martservice", dataset="hsapiens_gene_ensembl")
gene.coords <- biomaRt::getBM(mart = grch37, attributes=c("ensembl_gene_id", "external_gene_name", "start_position", "end_position"))
gene.annotations <- dplyr::transmute(gene.coords, external_gene_name,  ensembl_gene_id, length = end_position - start_position)
# Filter and re-order gene.annotations to match the order in feature counts matrix
gene.annotation1 <- gene.annotations %>% dplyr::filter(external_gene_name %in% rownames(exp.brca.t2r_bm))
gene.annotation2 <- gene.annotation1[order(match(gene.annotation1$external_gene_name, rownames(exp.brca.t2r_bm))),]

# #to QC the genes matched
# dim(gene.annotation2)
# head(gene.annotation2)
# tail(gene.annotation2[1:10,1:3])
# dim(exp.brca.t2r_bm)
# head(exp.brca.t2r_bm[1:10,1:10])
# tail(exp.brca.t2r_bm[1:10,1:10])

# Assign feature lenghts into a numeric vector
featureLength <- gene.annotation2$length

#to calculate FPKM values https://haroldpimentel.wordpress.com/2014/05/08/what-the-fpkm-a-review-rna-seq-expression-units/ 
countToFpkm <- function(exp.brca.t2r_bm, featureLength)
{
  N <- sum(exp.brca.t2r_bm)
  exp( log(exp.brca.t2r_bm) + log(1e9) - log(featureLength) - log(N) )
}
fpkm_counts <- countToFpkm(exp.brca.t2r_bm, featureLength)
class(fpkm_counts)
dim(fpkm_counts) #19938  1215
head(fpkm_counts[1:10,1:10])
head(exp.brca.t2r_bm[1:10,1:10])

fpkm_counts$geneID1 <- geneID1$geneID1
head(fpkm_counts$geneID1)
fpkm_counts_1 <- fpkm_counts
rownames(fpkm_counts_1) <- NULL 
fpkm_counts_1<- tibble::column_to_rownames(fpkm_counts_1, "geneID1")
head(fpkm_counts_1[1:10,1:10])
