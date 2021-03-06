#' accuracy_ds
#'
#' Calculates the accuracy measure based on caret's ranger model for the regionalization done by polygon_ds or points_ds
#'
#' @param x data frame with class atribute and the data that has been taken
#'   into regionalization
#'
#' @return the accuracy measure of random forest classification
#' @export
#'

accuracy_ds<-function(x)
{
  x$class<-as.factor(x$class)
  x<-x[complete.cases(x),]
  garbage<-capture.output(model.rf <- train(
    class~., x,
    method = "ranger",
    trControl = trainControl(n=5,
                             method = "cv",
                             verboseIter = TRUE
    ))

  )
  round(max(model.rf$results$Accuracy),2)
}
