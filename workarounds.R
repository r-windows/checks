# Set a repo
options(repos = 'https://cloud.r-project.org')

# Can't install from source
install.packages(c('mapdata', '
', 'RBGL'), type = 'win.binary')

# Install igraph (fixed)
#Sys.setenv(LOCAL_CPPFLAGS = "-I/mingw$(WIN)/include/libxml2 -DIGRAPH_THREAD_LOCAL=")
#Sys.setenv(LOCAL_LIBS = '-llzma')
#install.packages("igraph")

# Install XML (fixed)
#Sys.setenv(LOCAL_CPPFLAGS = "-I/mingw$(WIN)/include/libxml2")
#Sys.setenv(LOCAL_LIBS = '-llzma')
#install.packages("XML")

# Install JAGS
Sys.setenv(JAGS_ROOT="/c/progra~1/JAGS/JAGS-4.3.0")
Sys.setenv(LOCAL_CPPFLAGS = "-D_GLIBCXX_USE_CXX11_ABI=0")
install.packages(c("rjags", "runjags"))

# Cleanup
Sys.unsetenv("LOCAL_CPPFLAGS")
Sys.unsetenv("LOCAL_LIBS")

# Fixed Upstream
install.packages('https://github.com/r-windows/RCurl/archive/master.tar.gz', repos = NULL)
#remotes::install_github("r-windows/RCurl")
#remotes::install_github("r-windows/gmp")
#remotes::install_github("r-lib/fs")

# Preinstall pkgs with special treatment
fb_pkgs <- readLines("https://svn.r-project.org/R-dev-web/trunk/CRAN/QA/Uwe/make/config/ForceBiarch")
for(pkg in fb_pkgs){
	install.packages(pkg, INSTALL_opts = '--force-biarch')
}

mm_pkgs <- readLines("https://svn.r-project.org/R-dev-web/trunk/CRAN/QA/Uwe/make/config/MergeMultiarch")
for(pkg in mm_pkgs){
	install.packages(pkg, INSTALL_opts = '--merge-multiarch')
}
