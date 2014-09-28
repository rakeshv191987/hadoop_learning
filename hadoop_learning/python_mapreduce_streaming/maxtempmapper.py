#!/usr/bin/env python

import sys

for line in sys.stdin:
    line = line.strip()
    year, temp = line.split()

    print "%s\t%s" %(year, temp)

