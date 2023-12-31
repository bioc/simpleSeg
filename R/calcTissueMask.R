#' @importFrom BiocParallel bplapply
#' @importFrom EBImage normalize otsu bwlabel
#' @importFrom grDevices chull
#' @importFrom spatstat.geom owin
#' @importFrom spatstat.geom as.mask
#' @importFrom methods is
#' @importFrom stats coef cor median resid runif sd

.calcTissueMask <- function(image, tissue_index, size_selection = 10) {
  if (is.null(tissue_index)) {
    tissue_index <- seq_len(dim(image)[3])
  }


  if (is(tissue_index, "character")) {
    tissue_index <- intersect(tissue_index, dimnames(image)[[3]])
  }

  tissue <- apply(
    image[, , tissue_index],
    c(1, 2),
    mean
  )
  ## add intensities of markers to try and highlight the tissue structure


  tissue <- EBImage::normalize(log10(tissue + 0.01),
    ft = c(0, 1)
  )

  tissue_otsu <- EBImage::otsu(tissue,
    range = c(0, 1)
  )

  tissue <- tissue > tissue_otsu


  ## Do a size selection
  tissue_label <- EBImage::bwlabel(tissue)
  ttissue <- table(tissue_label)
  tissue[tissue_label %in% names(which(ttissue <= size_selection))] <- 0

  ## extract the convex hull
  nonZero <- as.data.frame(which(tissue > 0, arr.ind = TRUE))
  colnames(nonZero) <- c("y", "x")

  ch <- grDevices::chull(nonZero[, c("x", "y")])
  poly <- nonZero[, c("x", "y")][rev(ch), ]
  colnames(poly) <- c("x", "y")

  ow <- spatstat.geom::owin(
    xrange = range(nonZero$x),
    yrange = range(nonZero$y),
    poly = poly
  )

  tissueMask <- as.matrix(
    spatstat.geom::as.mask(ow,
      xy = list(
        y = seq_len(nrow(tissue)),
        x = seq_len(ncol(tissue))
      )
    )
  )
  ## this is all the points inside the convex hull

  return(tissueMask)
}
