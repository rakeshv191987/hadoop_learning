__author__ = 'Rakesh_Viswanathan'

line = "This is learning. Take this seriously. Beware."

line = line.strip()
words = line.split()

new_list = []
for i in range(0, len(words)):
    new_list.append(words.pop())

print new_list

str = "This one"
word, words = str.split()
print word, words

temp = "1965\t58"
key, val = temp.split('\t')
print key
print val
