#!/usr/bin/env python

import sys

current_year = None
current_max = 0

for line in sys.stdin:
    line = line.strip()

    year, temp = line.split('\t')
    try:
        year = int(year)
        temp = int(temp)
    except ValueError:
        continue

    if current_year == year:
        if temp > current_max:
            current_max = temp
        else:
            pass
    else:
        if current_year:
            print "%s\t%s" %(current_year, current_max)
        else:
            pass
        current_year = year
        current_max = temp

if year == current_year:
    print "%s\t%s" %(current_year, current_max)
