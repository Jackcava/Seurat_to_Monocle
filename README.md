# Seurat_to_Monocle
A package to convert a processed SeuratObject into a CellDataSet usable for Monocle3 analysis.


Before start, checked that the following packages are loaded on your envirnment:
* Seurat
* dplyr
* patchwork
* monocle3

This package mainly contains a function SeuToMon which has to be applied on a SeuratObject to convert it in an object readable and usable with the library Monocle3.
It's advisable to first perform a pre-processing on the SeuratObject which should include a filtering, a normalization of the data, a feature selection, the scaling and the linear dimensionality reduction (PCA) and the non-linear dimensionality reduction (UMAP).
Furthermore, it could be useful to do a clustering of the cells and rename the idents finding the respective possible cell type. For this last operation, we suggest to use some of the online available tools (i.e. EnrichR).

The function requires as input the processed SeuratObject and it will return a new element, a Cell DataSet, which contains the expression matrix of genes in cells metadata regarding both genes and cells. The function wants also the name of the assay of the SeuratObject to use to create the new data set: be careful to assign an assay with consistent initial data and not only with normalized data.
This element will be usable in Monocle3 library to perform each of its analysis.

