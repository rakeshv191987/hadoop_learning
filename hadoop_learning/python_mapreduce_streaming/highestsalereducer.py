#!/usr/bin/env python

import sys

current_store = None
current_max = None

for line in sys.stdin:
    line = line.strip()
    store, sale = line.split("\t")

    try:
        sale = float(sale)
    except ValueError:
        continue

    if store == current_store and sale > current_max:
        current_max = sale
    else:
        if current_store:
            print "%s\t%s" %(current_store, current_max)
        current_store = store
        current_max = sale

if store == current_store and sale > current_max:
    print "%s\t%s" %(store, sale)