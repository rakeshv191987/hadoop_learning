#!/usr/bin/env python

import sys

for line in sys.stdin:
    line = line.strip()
    attr = line.split("\t")
    store = attr[2]
    sale = attr[4]
    print "%s\t%s" %(store, sale)