# Set a repo
options(repos = 'https://cloud.r-project.org')

# Can't install from source
install.packages(c('mapdata', 'RBGL'), type = 'win.binary')

# Install JAGS
Sys.setenv(JAGS_ROOT="/c/progra~1/JAGS/JAGS-4.3.0")
Sys.setenv(LOCAL_CPPFLAGS = "-D_GLIBCXX_USE_CXX11_ABI=0")
install.packages(c("rjags", "runjags"))
Sys.unsetenv("LOCAL_CPPFLAGS")

# Fixed Upstream
install.packages('https://github.com/r-windows/RCurl/archive/master.tar.gz', repos = NULL)

# Preinstall pkgs with special treatment
fb_pkgs <- readLines("https://svn.r-project.org/R-dev-web/trunk/CRAN/QA/Uwe/make/config/ForceBiarch")
for(pkg in fb_pkgs){
	install.packages(pkg, INSTALL_opts = '--force-biarch')
}

mm_pkgs <- readLines("https://svn.r-project.org/R-dev-web/trunk/CRAN/QA/Uwe/make/config/MergeMultiarch")
for(pkg in mm_pkgs){
	install.packages(pkg, INSTALL_opts = '--merge-multiarch')
}
