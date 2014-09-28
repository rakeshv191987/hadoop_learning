#!/usr/bin/env python

import sys

current_key = None
running_total = 0

for line in sys.stdin:
    line = line.strip()
    key, value = line.split("\t")

    try:
        key = int(key)
        value = float(value)
    except ValueError:
        continue

    if current_key == key:
        running_total += 1
    else:
        if current_key:
            print "%s\t%s" %(current_key, running_total)
        current_key = key
        running_total = 1

if current_key == key:
    print "%s\t%s" %(current_key, running_total)
