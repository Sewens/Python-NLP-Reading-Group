
# 第三章：加工原料文本
解决：
1. 编写程序访问本地和网络文件，获得语料
2. 把文档分割成单独的词和标点符号，进行预料分析
3. 格式化输出，将结果保存到文件

## 3.1 从网络和硬盘访问文本

### 3.1.1 电子书


```python
import nltk, re, pprint
from nltk import word_tokenize
```


```python
#读取网络文件
from urllib import request
url = "http://www.gutenberg.org/files/2554/2554-0.txt"#原地址有变化，需根据网页调整
response = request.urlopen(url)
raw = response.read().decode('utf8')
print(type(raw))
print(len(raw))
raw[1:75]
```


```python
#使用NTLK分词
tokens = word_tokenize(raw[1:])#切片操作去除第一个字符，分词产生一个词汇和标点符号的链表
print(type(tokens))
print(len(tokens))
tokens[:10]
```


```python
#链表操作
text = nltk.Text(tokens)
print(type(text))
print(text[1021:1059])
print(text.collocations())#经常一起出现的词序列
```


```python
#正向查找find（）及反向查找rfind（）
print(raw.find("PART I"))
print(raw.rfind("End of Project Gutenberg's Crime"))
raw = raw[5336:1157741]
print(raw.find("PART I"))
```

### 3.1.2 处理 HTML


```python
#访问网址获取HTML的全部内容
url = "http://news.bbc.co.uk/2/hi/health/2284783.stm"
html = request.urlopen(url).read().decode('utf8')
html[:60]
```


```python
#提取原始文本
from bs4 import BeautifulSoup
raw = BeautifulSoup(html,'lxml').get_text()
tokens = word_tokenize(raw)
tokens
```


```python
#搜索单词gene在text 中出现的情况,强调上下文
tokens = tokens[110:390]
text = nltk.Text(tokens)
text.concordance('gene')
```

### 3.1.3 处理搜索引擎结果
网络可以被看作未经标注的巨大的语料库。  
优势：  
规模  
限制：  
搜索范围受到限制  
搜索引擎一般只允许搜索单个词或词串及使用通配符。  
搜索引擎给出的结果不一致，在不同的时间或区域给出不同结果  
搜索引擎返回的结果中的标记可能会不可预料的改变  

### 3.1.4 处理 RSS 订阅


```python
#Universal Feed Parser第三方Python库,访问博客的内容
import feedparser
llog = feedparser.parse("http://languagelog.ldc.upenn.edu/nll/?feed=atom")
print(llog['feed']['title'])
print(len(llog.entries))
```


```python
#访问第2个博客内容
post = llog.entries[1]
post.title
```


```python
#提取博客内容
content = post.content[0].value
content[:70]
```


```python
raw = BeautifulSoup(content,'lxml').get_text()
word_tokenize(raw)
```

### 3.1.5 读取本地文件


```python
import os
```


```python
#列出当前目录
os.listdir('.')
```


```python
#打开并读取文件
f = open('chg.txt')
f.read()
```


```python
#打开chg文件，按行读取，删除空白符
f = open('chg.txt', 'r')
for line in f:
    print(line.strip())
```

### 3.1.6 从PDF、MS Word及其他二进制文件中提取文本
PDF及MSword可以借助第三方函数库如pypdf、pywin32进行访问

### 3.1.7 捕获用户输入


```python
s = input("Enter some text: ")
```


```python
print("You typed", len(word_tokenize(s)), "words.")
```

## 3.2 字符串：最底层的文本处理

### 3.2.1 字符串的基本操作


```python
monty = 'Monty Python'
circus = "Monty Python's Flying Circus"
print(monty)
print(circus)
circus = 'Monty Python\'s Flying Circus'
print(circus)
```


```python
#反斜杠的作用
circus = 'Monty Python's Flying Circus'
print(circus)
```


```python
#输出显示换行
couplet1 = "Shall I compare thee to a Summer's day?"\
            "Thou are more lovely and more temperate:" 
couplet2 = ("Rough winds do shake the darling buds of May,"
            "And Summer's lease hath all too short a date:")
couplet3 = """Shall I compare thee to a Summer's day?
Thou are more lovely and more temperate:"""#换为单引号也可以
print(couplet1)
print(couplet2)
print(couplet3)
```


```python
#字符串的加乘操作
very_add = 'very' + 'very' + 'very'
print(very_add)
very_mul = 'very'*3
print(very_mul)
#字符串不能进行减和除的操作
```

### 3.2.2 输出字符串


```python
print(monty)
grail = 'Holy Grail'
print(monty + grail)
print(monty, grail)
print(monty, "and the", grail)
```

### 3.2.3 访问单个字符串


```python
print(monty[0])
print(monty[-1])
sent = 'colorless green ideas sleep furiously'
#循环遍历字符串
for char in sent:
    print(char, end=' ')
```


```python
# 规范化为小写，并过滤非字母的字符
from nltk.corpus import gutenberg
raw = gutenberg.raw('melville-moby_dick.txt')
fdist = nltk.FreqDist(ch.lower() for ch in raw if ch.isalpha())
#按照字符出现次数进行统计
print(fdist.most_common(5))
[char for (char, count) in fdist.most_common()]
```

### 3.2.4 访问子字符串


```python
print(monty[6:10])
print(monty[-12:-7])
print(monty[:5])
print(monty[6:])
```


```python
phrase = 'And now for something completely different'
#使用in可查询字符串
if 'thing' in phrase:
    print('found "thing"')
monty.find('Python')
```

### 3.2.5 更多的字符串操作


s.find(t) 字符串s 中包含t 的第一个索引（没找到返回-1）  
s.rfind(t) 字符串s 中包含t 的最后一个索引（没找到返回-1）  
s.index(t) 与s.find(t)功能类似，但没找到时引起ValueError  
s.rindex(t) 与s.rfind(t)功能类似，但没找到时引起ValueError  
s.join(text) 连接字符串s 与text 中的词汇  
s.split(t) 在所有找到t 的位置将s 分割成链表（默认为空白符）  
s.splitlines() 将s 按行分割成字符串链表  
s.lower() 将字符串s 小写  
s.upper() 将字符串s 大写   
s.titlecase() 将字符串s 首字母大写  
s.strip() 返回一个没有首尾空白字符的s 的拷贝  
s.replace(t, u) 用u 替换s 中的t   

### 3.2.6 链表与字符串的差异
字符串不可变  
链表是可变


```python
query = 'Who knows?'
beatles = ['John', 'Paul', 'George', 'Ringo']
print(query[2])
print(beatles[2])
print(query[:2])
print(beatles[:2])
print(query + " I don't")
```


```python
#字符串和链表间不能连接
beatles + 'Brian'
```


```python
beatles + ['Brian']
```

## 3.3 使用 Unicode 进行文字处理

### 3.3.1 什么是 Unicode
    Unicode是国际组织制定的可以容纳世界上所有文字和符号的字符编码方案。目前的Unicode字符分为17组编排，0x0000 至 0x10FFFF，每组称为平面（Plane），而每平面拥有65536个码位，共1114112个。  
    Unicode 支持超过一百万种字符。每个字符分配一个编号，称为编码点。在Python 中，编码点写作\uXXXX 的形式，其中XXXX 是四位十六进制形式数。  

### 3.3.2 从文件中提取已编码文本


```python
path = nltk.data.find('corpora/unicode_samples/polish-lat2.txt')
#用编码'latin2'打开波兰编码文件
f = open(path, encoding='latin2')
for line in f:
    line = line.strip()
    print(line)
```


```python
f = open(path, encoding='latin2')
for line in f:
    line = line.strip()
    print(line.encode('unicode_escape'))#将所有非ascii字符转换为它们的两位数\xXX和四位数字\uXXXX表示:
```


```python
ord('ń')
```


```python
nacute = '\u0144'
nacute
```


```python
nacute.encode('utf8')
```

### 3.3.3 在 Python中使用本地编码

需要在文件的第一行或第二行中包含字符串：'# -*- coding: <coding>-*-'

## 3.4 使用正则表达式检测词组搭配
正则表达式通常被用来检索、替换那些符合某个模式(规则)的文本   
需要使用import re 导入re 函数库

### 3.4.1使用基本的元字符


```python
import re,nltk
wordlist = [w for w in nltk.corpus.words.words('en') if w.islower()]
# 使用正则表达式«ed$»查找以ed 结尾的词汇
[w for w in wordlist if re.search('ed$', w)]
```


```python
#通配符“.”匹配任何单个字符
[w for w in wordlist if re.search('^..j..t..$', w)]
```

### 3.4.2 范围与闭包
re.search匹配整个字符串，直到找到一个匹配  
· 通配符，匹配所有字符  
^abc 匹配以abc 开始的字符串  
abc$ 匹配以abc 结尾的字符串  
[abc] 匹配字符集合中的一个  
[A-Z0-9] 匹配字符一个范围  
ed|ing|s 匹配指定的一个字符串（析取）  
“*” 前面的项目零个或多个，如a*, [a-z]* (也叫Kleene 闭包)  
“+” 前面的项目1 个或多个，如a+, [a-z]+  
“?” 前面的项目零个或1 个（即：可选）如：a?, [a-z]?  
{n} 重复n 次，n 为非负整数  
{n,} 至少重复n 次  
{,n} 重复不多于n 次  
{m,n} 至少重复m 次不多于n 次  
a(b|c)+ 括号表示操作符的范围  


```python
[w for w in wordlist if re.search('^[ghi][mno][jlk][def]$', w)]
```


```python
chat_words = sorted(set(w for w in nltk.corpus.nps_chat.words()))
[w for w in chat_words if re.search('^m+i+n+e+$', w)]
#“+”表示的是“前面字符的一个或多个实例
```


```python
[w for w in chat_words if re.search('^[ha]+$', w)]
```


```python
wsj = sorted(set(nltk.corpus.treebank.words()))
```


```python
[w for w in wsj if re.search('^[0-9]+\.[0-9]+$', w)]
```


```python
[w for w in wsj if re.search('^[A-Z]+\$$', w)]
```


```python
[w for w in wsj if re.search('^[0-9]{4}$', w)]
```


```python
[w for w in wsj if re.search('^[0-9]+-[a-z]{3,5}$', w)]
```


```python
[w for w in wsj if re.search('^[a-z]{5,}-[a-z]{2,3}-[a-z]{,6}$', w)]
```


```python
[w for w in wsj if re.search('(ed|ing)$', w)]
```

## 3.5 正则表达式的有益应用

### 3.5.1 提取字符块


```python
word = 'supercalifragilisticexpialidocious'
re.findall(r'[aeiou]', word)#找出一个词中的元音
```


```python
len(re.findall(r'[aeiou]', word))
```


```python
# 文本中的两个或两个以上的元音序列，并确定它们的相对频率
wsj = sorted(set(nltk.corpus.treebank.words()))
fd = nltk.FreqDist(vs for word in wsj
                   for vs in re.findall(r'[aeiou]{2,}', word))
fd.most_common(12)
```

### 3.5.2 在字符块上做更多事情


```python
# 英语文本是高度冗余的，当省略了单词内部的元音时，仍然很容易阅读。下例保留了任何初始或最终的元音序列。
def compress(word):
    pieces = re.findall(regexp, word)
    return ''.join(pieces)
english_udhr = nltk.corpus.udhr.words('English-Latin1')
print(nltk.tokenwrap(compress(w) for w in english_udhr[:75]))
```


```python
# 正则表达式与条件频率分布相结合，将每对频率制成表格
rotokas_words = nltk.corpus.toolbox.words('rotokas.dic')
cvs = [cv for w in rotokas_words for cv in re.findall(r'[ptksvr][aeiou]', w)]
cfd = nltk.ConditionalFreqDist(cvs)
cfd.tabulate()
```


```python
#查找单词列表
cv_word_pairs = [(cv, w) for w in rotokas_words
                 for cv in re.findall(r'[ptksvr][aeiou]', w)]
cv_index = nltk.Index(cv_word_pairs)
cv_index['su']

```

### 3.5.3 查找词干


```python
#去掉字符后缀
def stem(word):
    for suffix in ['ing', 'ly', 'ed', 'ious', 'ies', 'ive', 'es', 's', 'ment']:
        if word.endswith(suffix):
            return word[:-len(suffix)]
        return word
```


```python
re.findall(r'^.*(ing|ly|ed|ious|ies|ive|es|s|ment)$', 'processing')
```


```python
re.findall(r'^.*(?:ing|ly|ed|ious|ies|ive|es|s|ment)$', 'processing')
```


```python
re.findall(r'^(.*)(ing|ly|ed|ious|ies|ive|es|s|ment)$', 'processing')
```


```python
#  .*为贪婪模式
re.findall(r'^(.*)(ing|ly|ed|ious|ies|ive|es|s|ment)$', 'processes')
```


```python
#  .*?为非贪婪模式
re.findall(r'^(.*?)(ing|ly|ed|ious|ies|ive|es|s|ment)$', 'processes')
```


```python
re.findall(r'^(.*?)(ing|ly|ed|ious|ies|ive|es|s|ment)?$', 'language')
```


```python
#在文本中提取词干
import nltk
def stem(word):
    regexp = r'^(.*?)(ing|ly|ed|ious|ies|ive|es|s|ment)?$'
    stem, suffix = re.findall(regexp, word)[0]
    return stem
raw = """DENNIS: Listen, strange women lying in ponds distributing swords
is no basis for a system of government.  Supreme executive power derives from
a mandate from the masses, not from some farcical aquatic ceremony."""
tokens = nltk.word_tokenize(raw)
[stem(t) for t in tokens]
```

### 3.5.4 搜索已分词文本


```python
from nltk.corpus import gutenberg, nps_chat
moby = nltk.Text(gutenberg.words('melville-moby_dick.txt'))
moby.findall(r"<a> (<.*>) <man>")#只匹配词,不匹配短语
```


```python
chat = nltk.Text(nps_chat.words())
chat.findall(r"<.*> <.*> <bro>")#匹配短语
```


```python
from nltk.corpus import brown
hobbies_learned = nltk.Text(brown.words(categories=['hobbies', 'learned']))
hobbies_learned.findall(r"<\w*> <and> <other> <\w*s>")
```

## 3.6 规范化文本
例如：去掉所有的词缀以及提取词干的任务等

### 3.6.1 词干提取器


```python
raw = """DENNIS: Listen, strange women lying in ponds distributing swords
is no basis for a system of government.  Supreme executive power derives from
a mandate from the masses, not from some farcical aquatic ceremony."""
tokens = nltk.word_tokenize(raw)
```


```python
#porter词干提取器
porter = nltk.PorterStemmer()
[porter.stem(t) for t in tokens]
```


```python
##lancaster词干提取器
lancaster = nltk.LancasterStemmer()
[lancaster.stem(t) for t in tokens]
```


```python
# 使用词干提取器索引文本
class IndexedText(object):

    def __init__(self, stemmer, text):
        self._text = text
        self._stemmer = stemmer
        self._index = nltk.Index((self._stem(word), i)
                                 for (i, word) in enumerate(text))

    def concordance(self, word, width=40):
        key = self._stem(word)
        wc = int(width/4)                
        for i in self._index[key]:
            lcontext = ' '.join(self._text[i-wc:i])
            rcontext = ' '.join(self._text[i:i+wc])
            ldisplay = '{:>{width}}'.format(lcontext[-width:], width=width)
            rdisplay = '{:{width}}'.format(rcontext[:width], width=width)
            print(ldisplay, rdisplay)

    def _stem(self, word):
        return self._stemmer.stem(word).lower()
```


```python
porter = nltk.PorterStemmer()
grail = nltk.corpus.webtext.words('grail.txt')
text = IndexedText(porter, grail)
text.concordance('lie')
```

### 3.6.2 词形归并器


```python
# WordNetLemmatizer用于提取单词的主干
wnl = nltk.WordNetLemmatizer()
[wnl.lemmatize(t) for t in tokens]
```

## 3.7 用正则表达式为文本分词

### 3.7.1 分词的简单方法
符号 功能  
\b 词边界（零宽度）  
\d 任一十进制数字（相当于[0-9]）  
\D 任何非数字字符（等价于[^ 0-9]）  
\s 任何空白字符（相当于[ \t\n\r\f\v]）  
\S 任何非空白字符（相当于[^ \t\n\r\f\v]）  
\w 任何字母数字字符（相当于[a-zA-Z0-9_]）  
\W 任何非字母数字字符（相当于[^a-zA-Z0-9_]）  
\t 制表符  
\n 换行符  


```python
raw = """'When I'M a Duchess,' she said to herself, (not in a very hopeful tone
though), 'I won't have any pepper in my kitchen AT ALL. Soup does very
well without--Maybe it's always pepper that makes people hot-tempered,'..."""
```


```python
re.split(r' ', raw)
```


```python
re.split(r'[ \t\n]+', raw)#正则表达式«[ \t\n]+»匹配一个或多个空格、制表符（\t）或换行符（\n）
```


```python
re.split(r'\W+', raw)
```


```python
re.findall(r'\w+|\S\w*', raw)
```


```python
print(re.findall(r"\w+(?:[-']\w+)*|'|[-.(]+|\S\w*", raw))
```

### 3.7.2 NLTK 的正则表达式分词器
nltk.regexp_tokenize()分词效率更高，避免了括号的特殊处理的需要


```python
text = 'That U.S.A. poster-print costs $12.40...'
pattern = r'''(?x)    # set flag to allow verbose regexps
 (?:[A-Z]\.)+          
| \d+(?:\.\d+)?%?       
| \w+(?:[-']\w+)*  
| \.\.\.            
| (?:[.,;"'?():-_`])  
'''
nltk.regexp_tokenize(text, pattern)
```

### 3.7.3 分词的进一步问题

1、没有单一的解决方案能在所有领域都行之有效  
2、缩写，如“didn't”  
3、歧义  

## 3.8 分割
分词是一个更普遍的分割问题的一个实例

### 3.8.1 断句


```python
# Punkt 句子分割器：单词标点分割
import pprint
text = nltk.corpus.gutenberg.raw('chesterton-thursday.txt')
sents = nltk.sent_tokenize(text)
pprint.pprint(sents[79:89])
```

### 3.8.2 分词


```python
# 找到将文本字符串正确分割成词汇的字位串，进行分词
def segment(text, segs):
    words = []
    last = 0
    for i in range(len(segs)):
        if segs[i] == '1':
            words.append(text[last:i+1])
            last = i+1
    words.append(text[last:])
    return words
```


```python
text = "doyouseethekittyseethedoggydoyoulikethekittylikethedoggy"
seg1 = "0000000000000001000000000010000000000000000100000000000"
seg2 = "0100100100100001001001000010100100010010000100010010000"
segment(text, seg1)
```


```python
segment(text, seg2)
```


```python
#打分函数，基于词典的大小和从词典中重构源文本所需的信息量
def evaluate(text, segs):
    words = segment(text, segs)
    text_size = len(words)
    lexicon_size = sum(len(word) + 1 for word in set(words))
    return text_size + lexicon_size
text = "doyouseethekittyseethedoggydoyoulikethekittylikethedoggy"
seg1 = "0000000000000001000000000010000000000000000100000000000"
seg2 = "0100100100100001001001000010100100010010000100010010000"
seg3 = "0000100100000011001000000110000100010000001100010000001"
segment(text, seg3)
```


```python
print(evaluate(text, seg1))
print(evaluate(text, seg2))
print(evaluate(text, seg3))
```


```python
from random import randint
#使用模拟退火算法的非确定性搜索：一开始仅搜索短语分词；随机扰动0 和1，
# 它们与“温度”成比例；每次迭代温度都会降低，扰动边界会减少
def flip(segs, pos):
    return segs[:pos] + str(1-int(segs[pos])) + segs[pos+1:]

def flip_n(segs, n):
    for i in range(n):
        segs = flip(segs, randint(0, len(segs)-1))
    return segs

def anneal(text, segs, iterations, cooling_rate):
    temperature = float(len(segs))
    while temperature > 0.5:
        best_segs, best = segs, evaluate(text, segs)
        for i in range(iterations):
            guess = flip_n(segs, round(temperature))
            score = evaluate(text, guess)
            if score < best:
                best, best_segs = score, guess
        score, segs = best, best_segs
        temperature = temperature / cooling_rate
        print(evaluate(text, segs), segment(text, segs))
    print()
    return segs
```


```python
text = "doyouseethekittyseethedoggydoyoulikethekittylikethedoggy"
seg1 = "0000000000000001000000000010000000000000000100000000000"
anneal(text, seg1, 5000, 1.2)
```

## 3.9 格式化：从链表到字符串

### 3.9.1 从链表到字符串


```python
# join()方法只适用于一个字符串的链表
silly = ['We', 'called', 'him', 'Tortoise', 'because', 'he', 'taught', 'us', '.']
print(' '.join(silly))
print(';'.join(silly))
print(''.join(silly))
```

### 3.9.2 字符串与格式


```python
word = 'cat'
sentence = """hello
world"""
print(word)
print(sentence)
```


```python
fdist = nltk.FreqDist(['dog', 'cat', 'dog', 'cat', 'dog', 'snake', 'dog', 'cat'])
for word in sorted(fdist):
    print(word, '->', fdist[word], end='; ')
```


```python
for word in sorted(fdist):
    print('{}->{};'.format(word, fdist[word]), end=' ')
```


```python
'{} wants a {} {}'.format ('Lee', 'sandwich', 'for lunch')
```


```python
template = 'Lee wants a {} right now'
menu = ['sandwich', 'spam fritter', 'pancake']
for snack in menu:
    print(template.format(snack))
```

### 3.9.3 排列


```python
 '{:6}'.format('dog')#左对齐
```


```python
'{:>6}'.format('dog')#右对齐
```


```python
#布朗语料库的不同部分的频率模型
def tabulate(cfdist, words, categories):
    print('{:16}'.format('Category'), end=' ')                    # column headings
    for word in words:
        print('{:>6}'.format(word), end=' ')
    print()
    for category in categories:
        print('{:16}'.format(category), end=' ')                  # row heading
        for word in words:                                        # for each word
            print('{:6}'.format(cfdist[category][word]), end=' ') # print table cell
        print()                                                   # end the row

from nltk.corpus import brown
cfd = nltk.ConditionalFreqDist(
    (genre, word)
    for genre in brown.categories()
    for word in brown.words(categories=genre))
genres = ['news', 'religion', 'hobbies', 'science_fiction', 'romance', 'humor']
modals = ['can', 'could', 'may', 'might', 'must', 'will']
tabulate(cfd, modals, genres)
```

### 3.9.4 将结果写入文件


```python
output_file = open('output.txt', 'w')
words = set(nltk.corpus.genesis.words('english-kjv.txt'))
for word in sorted(words):
    print(word, file=output_file)
```


```python
print(str(len(words)), file=output_file)
```


```python
len(words)
```

### 3.9.5 文本换行


```python
saying = ['After', 'all', 'is', 'said', 'and', 'done', ',','more', 'is', 'said', 'than', 'done', '.']
for word in saying:
    print(word, '(' + str(len(word)) + '),', end=' ')
```


```python
#textwrap 模块的换行
from textwrap import fill
format = '%s (%d),'
pieces = [format % (word, len(word)) for word in saying]
output = ' '.join(pieces)
wrapped = fill(output)
print(wrapped)
```
