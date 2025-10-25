### Q1 : What word appears exactly 1,732 times in this text ?
```
cat RADIOS.txt | tr ' ' '\n'|sort|uniq -c|sort -n -r| grep 1732
```
### Q2 : How many times does the word "orange" appear in this text ?
```
cat RADIOS.txt | tr ' ' '\n'|sort|uniq -c|sort -n -r| grep orange
```