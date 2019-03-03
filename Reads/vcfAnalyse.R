library(data.table)
vcfData <- fread(file="Reads/VarScan_results.vcf", sep = "\t")
colnames(vcfData) <- c("CHROM", "POS", "ID", "REF", "ALT", "QUAL",
                       "FILTER", "INFO", "FORMAT","Sample1")


subVcfData <- vcfData[which(vcfData$POS >= 109539955 & vcfData$POS <= 109590032), ]
subVcfData[, shiftedPos := POS - 109539955 + 1]
setcolorder(subVcfData, c("CHROM", "POS", "shiftedPos", "REF", "ALT"))

exons <- fread(file="ExonsParsing/exonsStartEndPos.tsv")
colnames(exons) <- c("StartPos", "EndPos")
exons <- unique(exons)

snpInExonsIndx <- numeric()

for (i in 1:nrow(exons)){
  for (j in 1:nrow(subVcfData)){
    if ((exons[i, 1] <= subVcfData$shiftedPos[j]) & (subVcfData$shiftedPos[j] <= exons[i, 2])){
      snpInExonsIndx <- c(snpInExonsIndx, j)
    }
  }
}

snpOut <- subVcfData[snpInExonsIndx]
