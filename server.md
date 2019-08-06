## Extra Software

Software installed on the server besides R and Rtools40:

 - Java 32 bit
 - Java 64 bit
 - Pandoc
 - Miktex
 - Ghostscript
 - JAGS (needed for rjags, runjags)
 - OpenBugs (needed for BRugs)
 - InnoSetup
 - [Microsoft MPI SDK](https://docs.microsoft.com/en-us/message-passing-interface/microsoft-mpi#ms-mpi-downloads)

## Run

Open rtools40 shell and run the [cran-checks.sh](cran-checks.sh) script.

```
./cran-checks.sh
```

The [workarounds.R](workarounds.R) script has some temporary fixes for packages that need special treatment for now. 

