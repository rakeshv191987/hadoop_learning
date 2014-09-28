#!/usr/bin/env python

import sys

current_key = None
total_size = 0

for line in sys.stdin:

    line = line.strip()
    key, val = line.split('\t')

    if current_key == key:
        total_size += 1
    else:
        if current_key:
            print "%s\t%s" %(current_key, total_size)
        current_key = key
        total_size = 1

if current_key == key:
    print "%s\t%s" %(current_key, total_size)

