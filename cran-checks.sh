#!/bin/bash
#set -e

# Update all the packages!!
pacman -Syu --noconfirm
pacman -S --needed --noconfirm $(pacman -Slq | grep mingw-w64-)

# Make Latex, Pandoc available
source setpath.sh
pdflatex --version || exit 2
pandoc --version || exit 2
gswin64c --version || exit 2

mkdir -p "$R_LIBS"

# Install "special" packages 
Rscript --no-save workarounds.R

# Check packages in order of number of revdeps
Rscript --no-save list-packages.R | sed 's/\r//' > pkg_names.txt
while read -r PKG; do
	LOGFILE="$PKG.Rcheck/00check.log"
	if [ -e "$LOGFILE" ]; then
		LOGLINE=$(grep "Status: " $LOGFILE)
		echo "Previous result for $PKG: $LOGLINE"
		if echo $LOGLINE | grep -Pq 'Status: (OK|[0-9]+ (NOTE|WARN))'; then
			echo "SKIPPING $PKG"
			continue
			#echo "Retrying..."
		fi
	fi
	if [ $(grep "^$PKG\\W*$" DoNotCheck) ] || [ $(grep "^$PKG\\W*$" DoNotCompile) ]; then
		echo "Package $PKG is blacklisted. Skipping."
		rm -Rf "$PKG.Rcheck"
		continue
	fi
	ARGS=""
	OPTS=""
	if [ $(grep "^$PKG\\W*$" DoNotCheckVignette) ]; then
	VIGNETTE_ARG="--ignore-vignettes"
	else
	VIGNETTE_ARG="--no-build-vignettes"
	fi
	if [ $(grep "^$PKG\\W*$" ForceBiarch) ]; then
		ARGS="--install-args='--force-biarch'"
		OPTS=", INSTALL_opts='--force-biarch'"
	fi
	if [ $(grep "^$PKG\\W*$" MergeMultiarch) ]; then
		ARGS="--install-args='--merge-multiarch'"
		OPTS=", INSTALL_opts='--merge-multiarch'"
	fi
	echo "INSTALLING: $PKG $ARGS"
	R --no-save -e "source('repos.R'); install.packages('$PKG', dependencies=TRUE, type = 'source' $OPTS )"
    TARBBALL=$(Rscript --no-save -e "source('repos.R'); cat(download.packages('$PKG', '.')[1,2])")
	echo "CHECKING: $TARBBALL"
	R CMD check $TARBBALL --no-manual $VIGNETTE_ARG #--ignore-vignettes #$ARGS --no-build-vignettes
done < pkg_names.txt
