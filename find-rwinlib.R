# Find cran packages with an autobrew script
res <- gh::gh('/search/code?q=rwinlib+user:cran')
items <- res$items
repeat {
  cat("Found", length(items), "results...\n")
  Sys.sleep(90)
  res <- try(gh::gh_next(res))
  if(!is.list(res))
    break
  items <- c(items, res$items)
}

pkgs <- vapply(items, function(x){x$repository$name}, "")
pkgs <- sort(unique(pkgs))
print(pkgs)

# Install binary packages + dependencies
install.packages(pkgs)

# Install packages from source
results <- sapply(pkgs, function(pkg){
  try(remove.packages(pkg), silent = TRUE)
  install.packages(pkg, type = 'source')
  tryCatch({
    find.package(pkg)
    TRUE
  }, error = function(e){
    FALSE
  })
})

# Check if everything is installed
if(any(!results)){
  stop("Packages failed to install: ", paste(names(which(!results)), collapse = ", "))
}
print("Great success!")
print(pkgs)

#ijtiff, notifier, RProtoBuf, RQuantLib, rzmq, s2


