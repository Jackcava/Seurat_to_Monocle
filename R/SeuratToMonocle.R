#' SeuToMon
#'
#' @param seuObj
#' @param str_assay
#'
#' @return Cell DataSet Objects
#' @export
#'
#' @examples
#'
#' @import dplyr
#' @import Seurat
#' @import patchwork
#' @import monocle3
#'
SeuToMon<-function(seuObj, str_assay){

  expres_matrix<-seuObj@assays[[str_assay]]@data

  #Create the cell_metada with cell names as row
  my_cell_mtd<-data.frame(row.names = colnames(expres_matrix))

  if(!is.null(seuObj@meta.data[["seurat_clusters"]])){
    my_cell_mtd['cluster']<-seuObj@meta.data[["seurat_clusters"]]
  }else{
    print('Clusters not find!')
  }

  my_cell_mtd['Cell_Type']<-seuObj@active.ident

  if(!is.null(seuObj@reductions[["pca"]])){
    my_cell_mtd['pca']<-seuObj@reductions[["pca"]]@cell.embeddings[,1:10]
  }else{
    print('PCA Reduction not find!')
  }

  if(!is.null(seuObj@reductions[["umap"]])){
    my_cell_mtd['umap']<-seuObj@reductions[["umap"]]@cell.embeddings[,1:2]
  }else{
    print('UMAP Reduction not find!')
  }

  my_cell_mtd

  #Create Gene_metadata
  gene_ann <- as.matrix(seuObj@assays[[str_assay]]@data@Dimnames[[1]])
  rownames(gene_ann)<-seuObj@assays[[str_assay]]@data@Dimnames[[1]]
  colnames(gene_ann)<-'gene_short_name'

  cds <- new_cell_data_set(expres_matrix,
                           cell_metadata = my_cell_mtd,
                           gene_metadata = gene_ann)

  return(cds)
}

