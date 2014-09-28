#!/usr/bin/env python
import sys

current_word = None
current_count = 0
word = None

for line in sys.stdin:
    line = line.strip()

    word, count = line.split('\t')

    try:
        count = int(count)
    except ValueError:
        continue

    if current_word == word:
        current_count += count
    else:
        print '%s\t%s' %(current_word, current_count)
        current_word = word
        current_count = 1

if current_word == word:
    print '%s\t%s' %(current_word, current_count)