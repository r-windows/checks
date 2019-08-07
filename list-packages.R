#library(dplyr)
setRepositories(ind = 1:3) # <- to also check bioconductor
options(repos = 'https://cloud.r-project.org')
pkgs <- as.data.frame(available.packages(), stringsAsFactors = FALSE)

parse_depends <- function(strings){
    out <- lapply(strsplit(strings, ",\\W*"),
           function(x) sub("\\W.*", "", x))
    unlist(out)
}

all_imports <- unlist(parse_depends(pkgs$Imports))
all_depends <- unlist(parse_depends(pkgs$Depends))
all_suggests <- unlist(parse_depends(pkgs$Suggests))
all_linking <- unlist(parse_depends(pkgs$LinkingTo))
all_counts <- c(all_imports, all_depends, all_suggests, all_linking)

top_packages <- sort(table(all_counts), decreasing = TRUE)
pkg_names <- names(top_packages)
pkg_names <- pkg_names[pkg_names %in% pkgs$Package]
writeLines(pkg_names)

