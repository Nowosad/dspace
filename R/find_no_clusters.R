
#' find_no_clusters
#'
#' Helps identify how many regions should be divided by analyzing the changes in modularity value
#'
#' @param x spatial data for regionalization
#' @param polygon logical if the data is polygon or point
#' @param queen  if data is polygon and without disjoint polygons, should the
#'   neighbourhood be treated by queen topology or rook topology
#' @param method Character or function to declare distance method. If method
#'   is character, method must be "mahalanobis" or "euclidean", "maximum",
#'   "manhattan", "canberra", "binary" or "minkowisk". If method is one of
#'   "euclidean", "maximum", "manhattan", "canberra", "binary" or "minkowisk",
#'   see dist for details, because this function as used to compute the
#'   distance. If method="mahalanobis", the mahalanobis distance is computed
#'   between neighbour areas. If method is a function, this function is used to
#'   compute the distance.
#' @param data data to analyze similarity between regions
#' @param style style can take values “W”, “B”, “C”, “U”, “minmax” and “S”
#' @param n.neigh number of neighbours considered in the k-nearest neighbour
#'   algorithm that builds topology
#' @param disjoint if default settings generate error occuring to disjoint
#'   subgraphs it means, that in some places points or polygons are to disjoint
#'   to generate one connected graph. Use disjoint = T to enforce that one graph
#'   will be created. This is a slower option.
#' @param range number of divisions to test the modularity. THe biger the
#'   numbers, the longer it will take to calculate plot
#'
#' @return A vector of modularity measures for given range of divisions
#' @export
#'
find_no_clusters<-function(x,polygon=T,queen=T,method="euclidean",data=2:ncol(x),
                           style="B",n.neigh=8,disjoint=F,range=2:30)
{
  if(polygon==T)
  {
    res<-prepare_polygons(x=x,queen=queen,
                          method=method,
                          disjoint=disjoint,
                          n.neigh=n.neigh,plot=F)
  } else {
    res<-prepare_points(x=x,
                        method=method,
                        n.neigh=n.neigh,plot=F)
  }


  fg<-build_graph(x=res[["x"]],x.nb=res[["x.nb"]],data=data,method=method,
                  style=style)
  graph<-fg[["graph"]]
  fg<-fg[["fg"]]
  modularities<-c()
  for(i in range)
  {
    z<-cutat(fg,no=i)
    modularities<-append(modularities,modularity(graph,z))
  }
  names(modularities)<-range
  modularities
}
