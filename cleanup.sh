#!/bin/sh

# Delete OK / NOTE
rm -Rf $(grep -E "Status: (OK|[0-9]+ NOTE)" */00check.log | grep -o .*.Rcheck)
