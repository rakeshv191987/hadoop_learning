#!/usr/bin/env python

import sys

current_category = None
total_sale = None

for line in sys.stdin:
    line = line.strip()
    category, sale = line.split("\t")

    try:
        sale = float(sale)
    except ValueError:
        continue

    if category == current_category:
        total_sale += sale
    else:
        if current_category:
            print "%s\t%s" %(current_category, total_sale)
        current_category = category
        total_sale = sale

if current_category == category:
    print "%s\t%s" %(current_category, total_sale)