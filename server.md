## Extra Software

Software installed on the server besides R and Rtools40:

 - [Java 8 JDK: 32 bit AND 64-bit](https://github.com/portapps/untouched/releases/tag/oracle-jdk-8u231)
 - [Pandoc](https://github.com/jgm/pandoc/releases)
 - [Miktex](https://mirror.kumi.systems/ctan/systems/win32/miktex/setup/windows-x64/)
 - [Ghostscript](https://www.ghostscript.com/download/gsdnld.html)
 - [JAGS](https://sourceforge.net/projects/mcmc-jags/files/JAGS/4.x/Windows/) (needed for rjags, runjags)
 - [OpenBugs](http://www.openbugs.net/w/Downloads) (needed for BRugs)
 - [InnoSetup](http://www.jrsoftware.org/isdl.php#stable)
 - [Microsoft MPI SDK](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi#ms-mpi-downloads)
 - GTK+ 2.22 [win32](http://ftp.acc.umu.se/pub/gnome/binaries/win32/gtk+/2.22/gtk+-bundle_2.22.1-20101227_win32.zip) 
   and [win64](http://ftp.acc.umu.se/pub/gnome/binaries/win64/gtk+/2.22/gtk+-bundle_2.22.1-20101229_win64.zip) 
   (extract to `C:\GTK32` and `C:\GTK64`) 

## Run

Open rtools40 shell and run the [cran-checks.sh](cran-checks.sh) script.

```
./cran-checks.sh
```

The [workarounds.R](workarounds.R) script has some temporary fixes for packages that need special treatment for now. 

