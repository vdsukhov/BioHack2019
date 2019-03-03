gff <- read.table(file="Annotation/GCF_000181335.3_Felis_catus_9.0_genomic.gff",
                  sep = "\t")
gffSubset <- gff[grep("NC_018741.3", gff[, 1]), ] 

write.table(gffSubset, file="Annotation/xChromoAnnotation.gff", sep="\t", quote = FALSE,
            row.names = FALSE, col.names = FALSE)
