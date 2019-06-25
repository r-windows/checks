#!/bin/sh
outfile="readme.md"
echo '# Check results' > $outfile
echo "Last update: $(date)" > $outfile
echo "" > $outfile

# Build failures
echo '## Install failures' >> $outfile
echo '```' >> $outfile
grep "Installation failed" */00check.log >> $outfile
echo '```' >> $outfile

# Check failures
echo "## Check failures" >> $outfile
echo '```' >> $outfile
grep "Status: [0-9] ERROR" $(grep -L "Installation failed" */00check.log) >> $outfile
echo '```' >> $outfile

# Warnings
echo "## Warnings" >> $outfile
echo '```' >> $outfile
grep "Status: [0-9] WARN" */00check.log >> $outfile
echo '```' >> $outfile

# Delete OK
grep -E "Status: (OK|[0-9]+ NOTE)" */00check.log | grep -o .*.Rcheck
