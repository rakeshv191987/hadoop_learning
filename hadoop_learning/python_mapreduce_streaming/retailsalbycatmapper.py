#!/usr/bin/env python

import sys

for line in sys.stdin:
    line = line.strip()
    values = line.split("\t")
    category = values[3]
    sale = values[4]
    print "%s\t%s" %(category, sale)