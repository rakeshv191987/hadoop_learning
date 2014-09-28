#!/usr/bin/env python

import sys

for line in sys.stdin:
    line = line.strip()
    words = line.split()
    value = 1
    for word in words:
        size = len(word)
        print "%s-%s\t%s" %(size, word, value)

