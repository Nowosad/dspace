

#' part_communities
#'
#' Divides graph into defined number of regions
#'
#' @param k number of clusters to create regionalization
#' @param fg hierarchical community object created from build_graph()
#'
#' @return a vector of classes - numbers of regions that particular polygon or point are classified to
#' @export
#'
part_communities<-function(k,fg)
{

  classes.db<-data.frame()

  classes<-cutat(fg,no=k)
  clusters.fg<-membership(fg)
  clusters.fg<-data.frame(ID=as.numeric(names(membership(fg))),class=classes)
  clusters.fg<-clusters.fg[order(clusters.fg$ID),]
  clusters.fg$class

}
