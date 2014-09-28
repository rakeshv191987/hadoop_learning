#!/usr/bin/env python

import sys

for line in sys.stdin:
    line = line.strip()
    key, value = line.split(" ")

    print "%s\t%s" %(key, value)
