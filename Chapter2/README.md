

```python
import nltk
from nltk.corpus import gutenberg
import re
```


```python
from nltk.corpus import gutenberg
nltk.corpus.gutenberg.fileids()
```

# 1.1raw类型的用法，raw是原始文本，包含空格和换行等空字符 


```python
a = gutenberg.raw( fileids =['austen-emma.txt','chesterton-ball.txt'])
b = gutenberg.raw('austen-emma.txt')
c = gutenberg.raw('chesterton-ball.txt')
print('b:',len(b),'\tc:',len(c),'\ta:',len(a))
print('raw的类型为：',type(b))
```

# 1.2 sents的用法


```python
macbeth_sentences = gutenberg.sents('shakespeare-macbeth.txt')
print('第1116个句子:',macbeth_sentences[1116])
print('################分隔线###################')
longest_len = max(len(s) for s in macbeth_sentences)
print('最长句子长度:',longest_len)
print('################分隔线###################')
longest =  [s for s in macbeth_sentences if len(s) == longest_len]
print('最长的句子：',longest)
```

# 1.3 raw,words,sents的区别


```python
raw = gutenberg.raw("burgess-busterbrown.txt")
print('输出前20个字符：',raw[1:20])
print('################分隔线###################')
words = gutenberg.words("burgess-busterbrown.txt")
print('输出前20个单词：',words[1:20])
print('################分隔线###################')
sents = gutenberg.sents("burgess-busterbrown.txt")
print('输出前5个句子：',sents[1:5])
```

# 1.4 计算平均词长（总字符数/单词个数），平均句子长度（总单词数/句子个数），文本中每个词出现的平均次数（总单词数 /不同单词的个数）,通过平均句子长度和词汇的多样性查看作者个人的特点


```python
for fileid in gutenberg.fileids():
    num_chars = len(gutenberg.raw(fileid)) #总字符数
    num_words = len(gutenberg.words(fileid)) #总单词个数
    num_sents = len(gutenberg.sents(fileid)) #总句子个数
    num_vocab = len(set(w.lower() for w in gutenberg.words(fileid))) #不同单词个数
    print(round(num_chars/num_words),
          round(num_words/num_sents), round(num_words/num_vocab), fileid)
```

# 1.5 布朗预料库使用方法简介


```python
from nltk.corpus import brown
brown_c = brown.categories()
print('语料库的种类:', brown_c)
print('################语料库中新闻类别中的文件名称###################')
brown_f = brown.fileids(categories='news')
print('语料库中新闻类别中的文件名称：',brown_f)
print('################新闻类别的总词数###################')
brown_w = brown.words(categories='news')
print('新闻类别的总词数:',len(brown_w))
print('################计算单词的出现频率#################################')
fdist = nltk.FreqDist(w.lower() for w in brown_w)
modals = ['can', 'could', 'may', 'might', 'must', 'will']
for m in modals:
    print(m + ':', fdist[m], end=' ')
```

# 1.6 fileids()和categories()的用法，以路透社语料库为例


```python
from nltk.corpus import reuters
#cate用法
cate = reuters.categories()
cate_fileid = reuters.categories('training/9865') 
cate_fileids = reuters.categories(['training/9865', 'training/9880'])
print('语料库的全部分类：',cate)
print('<training/9865>语料的分类：',cate_fileid)
print('<training/9865>、<training/9880>语料的分类：',cate_fileids)

#fileids用法
fileis_cate = reuters.fileids('barley')
fileid_cates = reuters.fileids(['barley', 'corn'])
print('barley类别中的语料:',fileis_cate)
print('################分隔符#################################')
print('barley,corn类别的语料：',fileid_cates)

```

# 1.7 udhr语料库简介



```python
 from nltk.corpus import udhr
 print('ubdhr语料的语言种类:',udhr.fileids())
 print('ubdhr语料库的中文版本:',udhr.words('Chinese_Mandarin-GB2312'))
 
```

# 1.8 加载自己的语料库：第一种方法：可以利用NLTK 中的PlaintextCorpusReader进行加载，文件名参数可以使用list的文件列表，也可以使用正则表达式


```python
from nltk.corpus import PlaintextCorpusReader
corpus_root = r'E:\python\TensorFlow\nlp' 
file_pattern = r"三 体.txt"
wordlists = PlaintextCorpusReader(corpus_root, file_pattern) 
wordlists.fileids()
print(wordlists.words("三 体.txt"),wordlists.sents("三 体.txt"))
```

# 第二种方法：BracketParseCorpusReader更适合已解析过的语料库，以加载搜狗文本分类语料为例


```python
from nltk.corpus import BracketParseCorpusReader
corpus_root =r"E:\野猪的苞米地\4.语料\SogouC.reduced.20061127\SogouC.reduced\Reduced"  # r"" 防止转义
file_pattern = r".*/.*\.txt"    #匹配corpus_root目录下的所有子目录下的txt文件
sougou = BracketParseCorpusReader(corpus_root, file_pattern)   #初始化读取器：语料库目录和要加载文件的格式，默认utf8格式的编码
#至此，可以看到目录下的所有文件名，例如'互联网/10.txt'则成功了
sougou .fileids() 
```

# '互联网/11.txt'的全部文本,但因为没有分词显示word和sents为空


```python
# 如果'互联网/11.txt'编码格式和ptb格式一致，则看到内容
print(sougou.raw('互联网/11.txt'))
print(sougou.words('互联网/11.txt'),sougou.sents('互联网/11.txt'))
```

# 处理自己的中文语料，使其能够使用nltk功能


```python
import jieba
from nltk.text import Text
word_cut_list = jieba.lcut(wordlists.raw("三 体.txt"))
text = Text(word_cut_list)
#三体的上下文，打印宽度20字符，共10行上下文
print(text.concordance(word='三体', width=20, lines=10))
#word = 文明在上下文找到最相思的10个词
print(text.similar(word='文明', num=10))
#统计词语频数
print(text.count(word='三体'))
```


```python
#如果不转换为text类无法调用nltk相关函数
san_ti  = wordlists.words("三 体.txt")
san_ti.concordance(word='三体', width=20, lines=10)

```


```python
#转换为text类后使用成功
san_ti_text = Text(san_ti)
san_ti_text.concordance(word='三体', width=20, lines=10)
```

# 2 条件频率分布

# 2.2 按文体计数词汇


```python
from nltk.corpus import brown
# cfd = nltk.ConditionalFreqDist()
cfd = [(genre, word)for genre in brown.categories()
    for word in brown.words(categories=genre)]
```


```python
len(cfd)
```

# 2.2.1 以新闻和言情文体为例，遍历这两个类的每个文体和每个词，以产生文体与词配对的二元组，最后保存为list


```python
from nltk.corpus import brown
genre_word = [(genre, word)for genre in ['news', 'romance']
              for word in brown.words(categories=genre)] 
print(len(genre_word),genre_word[:4],genre_word[-4:])

```

# 2.2.2 我们可以使用此配对列表创建一个ConditionalFreqDist，并将它保存在一个变量cfd中。


```python
from nltk.corpus import brown
cfd = nltk.ConditionalFreqDist((genre, word)
                               for genre in brown.categories()
                               for word in brown.words(categories=genre))
#查看‘news’中的频率情况，其中samples为不同含有不同单词的个数
# （可以理解为set），outcomes为 单词的总数。
print(cfd['news'], '\n', cfd['romance'])
#查看'romance'中出现频率前20的词和某个词的频率
print('romance中出现频率前20的词:', cfd['romance'].most_common(20))
print('Romance中could的频率:', cfd['romance']['could'])
```

# 2.3 绘制分布图和分布表

# 2.3.1 遍历所有文件的所有词判断其中是否有目标词target，如果为真就将目标词和文本名中的年代（即文本名前四位）输出为二元组('america', '1865')


```python
from nltk.corpus import inaugural
cfd =  nltk.ConditionalFreqDist((target, fileid[:4])
       for target in ['america', 'citizen']
       for fileid in inaugural.fileids()
       
       for w in inaugural.words(fileid)       
       if w.lower().startswith(target))

```


```python
cfd
```

# 2.3.2基于各种语言的词长，绘出词长条件概率图


```python
from nltk.corpus import udhr
languages = ['Chickasaw', 'English', 'German_Deutsch',
             'Greenlandic_Inuktikut', 'Hungarian_Magyar', 'Ibibio_Efik']
cfd = nltk.ConditionalFreqDist((lang, len(word))
                               for lang in languages
#Latin1是ISO-8859-1的别名,ISO-8859-1编码是单字节编码，向下兼容ASCII。
                               for word in udhr.words(lang + '-Latin1'))
cfd.plot(cumulative=True)
```


```python
cfd
```

# 2.3.3 利用tabulate，设定条件和取值范围，显示统计结果。以下是将英语和德语中某词长的数量列表统计。以9为例，其含义是英文文本中9 个或少于9 个字符长的词有1,638 个


```python
#conditions：指定条件
# samples：迭代器类型，指定取值范围
# cumulative：设置为True可以查看累积值
cfd.tabulate(conditions=['English', 'German_Deutsch'],
             samples=range(10), cumulative=True)
```

# 2.4.1 使用双连词生成随机文本：我们可以使用条件频率分布创建一个双连词表（词对）。bigrams()函数接受一个单词列表，并建立一个连续的词对列表。


```python
sent = ['In', 'the', 'beginning', 'God', 'created', 'the', 'heaven',
        'and', 'the', 'earth', '.']
list(nltk.bigrams(sent))
```

# 2.4.2 跟据单词出现概率定义函数生成随机文本。


```python
def generate_model(cfdist, word, num=15):
    for i in range(num):
        print(word, end=' ')
        word = cfdist[word].max()

text = nltk.corpus.genesis.words('english-kjv.txt')
bigrams = list(nltk.bigrams(text))
cfd = nltk.ConditionalFreqDist(bigrams)

```


```python
living_tuple = [a for a in bigrams if  a[0] == 'living']
print(living_tuple,'\n')
cfd['living']
```


```python
cfd['that']['he']
```


```python
generate_model(cfd, 'living')
```


```python
cfd['creature']
```


```python
cfd['that'].most_common(5)
```

# 3.1 模块加载：pycharm将项目所在路径作为默认路径，否则需要用以下代码将自定义模块路径添加到系统sys.path.append("E:\python\TensorFlow")


```python
from nlp.text_proc import plural
plural('wish')
```

# 3.2自定义函数：


```python
#函数1 计算不同词数与总词数比值，函数体内变量为局部变量
#函数体外不能调用，除非在函数体内将其定义成全局变量
from __future__ import division
def lexical_diversity(my_text_data):
        word_count = len(my_text_data)
        vocab_size = len(set(my_text_data))
        diversity_score = vocab_size / word_count
        return diversity_score
#调用此函数
from nltk.corpus import genesis
kjv = genesis.words('english-kjv.txt')
lexical_diversity(kjv)

```

# 4 词汇资源 

# 4.1 词汇列表语料库：NLTK 包括一些仅仅包含词汇列表的语料库。词汇语料库是C:\Users\UP\AppData\Roaming\nltk_data\corpora\words.我们可以用它来寻找文本语料中不寻常的或拼写错误的词汇.


```python
def unusual_words(text):
     #isalpha判断w是不是英文如果是的返回非零值，否则返回0
    text_vocab = set(w.lower() for w in text if w.isalpha())   
    #将nltk中的英文单词列表赋值给english_vocab
    english_vocab = set(w.lower() for w in nltk.corpus.words.words())
    #将english_vocab中的词从text_vocab中移除
    unusual = text_vocab.difference(english_vocab)
    return sorted(unusual)
#返回'austen-sense.txt'的非常用词汇或拼写错误词汇
un = unusual_words(nltk.corpus.gutenberg.words('austen-sense.txt'))
print('austen-sense.txt中的词汇数：',len(set(nltk.corpus.gutenberg.words('austen-sense.txt'))),
          '\nnltk英文词表总数：',len(nltk.corpus.words.words()),
      '\n不常见单词或拼写错误词数：',len(un))
```


```python
#查看即时聊天语料库的非常用词汇
unusual_words(nltk.corpus.nps_chat.words())
```

# 4.2.1 处理停用词:有些高频词汇，如the，to和also，并无实际语义，由于其词频过高对分类等操作会产生噪声， 在实际操作过程中通常将其从文档中过滤掉。


```python
from nltk.corpus import stopwords
stopwords.words('english')
```

# 定义一个函数来计算文本中没有在停用词列表中的词的比例


```python
def content_fraction(text):
    stopwords = nltk.corpus.stopwords.words('english')
    content = [w for w in text if w.lower() not in stopwords]
    return len(content) / len(text)
content_fraction(nltk.corpus.reuters.words())
```

# 4.2.2 利用词汇列表解决谜题


```python
#思路：1.遍历英文单词列表
#2.只查找6个以上的单词（按题目要求四个以上词表的词太多了）
#3.必须包含中心词r
#4.检查每个字母在候选词中的频率是否小于或等于相应的字母在拼词谜题中的频率
puzzle_letters = nltk.FreqDist('egivrvonl') #计算各字母出现的频率
obligatory = 'r' #中心字母为r
wordlist = nltk.corpus.words.words() #加载单词列表
output = [w for w in wordlist if len(w) >= 6 
          and obligatory in w 
          and nltk.FreqDist(w) <= puzzle_letters]
output
```

# 4.2.3 名字语料库：包括8000个按性别分类的名字。男性和女性的名字存储在单独的文件中。


```python
#from nltk.corpus import names
names = nltk.corpus.names
print(names.fileids())
male_names = names.words('male.txt')
female_names = names.words('female.txt')
#显示即在male也在female文件中出现的名字
[w for w in male_names if w in female_names]

```

# 4.2.4  统计发现男女名字特点，条件频率分布：此图显示男性和女性名字的结尾字母；大多数以a，e或i结尾的名字是女性；以h和l结尾的男性和女性同样多；以k, o, r, s和t结尾的更可能是男性。


```python
cfd = nltk.ConditionalFreqDist(
    (fileid, name[-1])
    for fileid in names.fileids()
    for name in names.words(fileid))
cfd.plot()
```


```python
cfd
```

# 4.2.5 发音的词典：NLTK 中包括美国英语的CMU 发音词典，它是为语音合成器使用而设计的。


```python
entries = nltk.corpus.cmudict.entries()
len(entries)
for entry in entries[42371:42379]:
    print(entry)
```


```python
#挑选出音素为三个，第一个发p的音，第三个发t音的词
for word, pron in entries:
    if len(pron) == 3:
        ph1, ph2, ph3 = pron
        if ph1 == 'P' and ph3 == 'T':
            print(word, ph2, end=' ')
```


```python
#这段程序找到所有发音结尾与nicks相似的词汇。
# 你可以使用此方法来找到押韵的词。
syllable = ['N', 'IH0', 'K', 'S']
[word for word, pron in entries if pron[-4:] == syllable]
```


```python
#单词尾字母为n却发M音的单词
[w for w, pron in entries if pron[-1] == 'M' and w[-1] == 'n']
```


```python
#首字母不为n却发N音的单词首两个字母
sorted(set(w[:2] for w, pron in entries if pron[0] == 'N' and w[0] != 'n'))
```


```python
#定义一个函数来提取重音数字，然后扫描我们的词典，找到具有特定重音模式的词汇
#isdigit函数为判断char是否是数字
def stress(pron):
    return [char for phone in pron for char in phone if char.isdigit()]
[w for w, pron in entries if stress(pron) == ['0', '1', '0', '2', '0']]
```

# 使用条件频率分布来帮助我们找到词汇的最小受限集合，找到所有p开头的三音素词，并按照它们的第一个和最后一个音素来分组。


```python
#如果首音素为p且长度为3，将首音素和尾音素连接成字符串和word存为二元组
p3 = [(pron[0]+'-'+pron[2], word)
      for (word, pron) in entries
      if pron[0] == 'P' and len(pron) == 3]
#以首音素和尾音素进行条件概率计算
cfd = nltk.ConditionalFreqDist(p3)
#cfd.conditions()将条件按字母排序，如果某条件的单词数大于10
# 将词连接成字符串进行输出
for template in sorted(cfd.conditions()):
    if len(cfd[template]) > 10:
        words = sorted(cfd[template])
        wordstring = ' '.join(words)
        print(template, wordstring[:70] + "...")
```


```python
#字典数据类型使用简介（就是python中dict数据类型使用方法）
prondict = nltk.corpus.cmudict.dict()
prondict['fire']
prondict['blog']
prondict['blog'] = [['B', 'L', 'AA1', 'G']]
prondict['blog']

```

# 4.3 比较词表：NLTK 中包含了所谓的斯瓦迪士核心词列表，几种语言中约200个常用词的列表。语言标识符使用ISO639 双字母码。
    


```python
from nltk.corpus import swadesh
print(swadesh.fileids())
for ca in swadesh.fileids():
    print(ca,':',swadesh.words(ca)[:3])
#通过在entries()方法中指定一个语言链表来访问多语言中的同源词。
fr2en = swadesh.entries(['fr', 'en'])
print('法语和英语中的同源词：',fr2en[:8])
#通过dict命令将list转化为dict
translate = dict(fr2en)
print(type(translate),translate['chien'])
```

# 让我们使用dict()函数把德语-英语和西班牙语-英语对相互转换成一个词典，然后用这些添加的映射更新我们原来的翻译词典


```python
de2en = swadesh.entries(['de', 'en'])    # German-English
es2en = swadesh.entries(['es', 'en'])    # Spanish-English
translate.update(dict(de2en))
translate.update(dict(es2en))
print(translate['Hund'],translate['perro'])
```


```python
#我们可以比较日尔曼语族和拉丁语族的不同：
languages = ['en', 'de', 'nl', 'es', 'fr', 'pt', 'la']
for i in [139, 140, 141, 142]:
    print(swadesh.entries(languages)[i])

```


```python
#下面是一个罗托卡特语的词典,罗托卡特语是巴布亚新几内亚的布干维尔岛上使用
# 的一种语言。
# ('ps', 'V')表示词性是'V'(动词)，('ge', 'gag')表示英文注释是''gag'。
# 最后的3 个配对包含一个罗托卡特语例句和它的巴布亚皮钦语及英语翻译。
from nltk.corpus import toolbox
toolbox.entries('rotokas.dic')[0]

```

# 5 WordNet:WordNet是面向语义的英语词典，类似与传统辞典，但具有更丰富的结构。
    

# 5.1利用wordnet查找某些词的同义词


```python
from nltk.corpus import wordnet as wn
#查看单词motorcar的含义
wn.synsets('motorcar')
```


```python
#含'car.n.01'的同义词词集（该例由5个词条组成，car.n.01.automobile即为一个词条）
#lemmas = wn.lemmas('car')
lemmas = wn.synset('car.n.01').lemmas()
#'car.n.01'的同义词词条名字
lemma_names = wn.synset('car.n.01').lemma_names()
#'car.n.01'的定义(词条解释)
defin = wn.synset('car.n.01').definition()
#'car.n.01'的例句
ex = wn.synset('car.n.01').examples()
print(lemmas)
print(lemma_names)
print(defin)
print(ex)

```

# 5.2 WordNet的层次结构：包含树形的上下位以及部分-整体结构，将所有词汇联系起来便于查询操作，以下主要是上下位关系


```python
#将'car.n.01'赋值给motorcar相当于在car所属网络中进行定位
motorcar = wn.synset('car.n.01')
#查找'car.n.01'的下位词
types_of_motorcar = motorcar.hyponyms()
#将'car.n.01'下位词的所有词条名进行输出
sorted(lemma.name() for synset in 
       types_of_motorcar for lemma in synset.lemmas())
#'car.n.01'的上位词 
motorcar.hypernyms()
#到'car.n.01'上位词的路径
paths = motorcar.hypernym_paths()
len(paths)
#查看两个路径的内容
[synset.name() for synset in paths[0]]
[synset.name() for synset in paths[1]]
#得到根上位
motorcar.root_hypernyms()

```

# 5.3 更多的词汇关系  上位词和下位词被称为词汇关系，WordNet 网络另一个重要的漫游方式是从元素到它们的部件（部分）或到它们被包含其中的东西（整体）。例如，一棵树的部分是它的树干，树冠等


```python
#除上下位关系外还可以查看词汇的部分-整体的关系：例如部件（part_meronyms()）
# 、材质（substance_meronyms()、成员（member_holonyms()）等其他关系
print('结构：',wn.synset('tree.n.01').part_meronyms())
print('材质：',wn.synset('tree.n.01').substance_meronyms())
print('成员：',wn.synset('tree.n.01').member_holonyms())
```


```python
sorted(lemma.name() for synset in 
       types_of_motorcar for lemma in synset.lemmas())
```


```python
#输出mint名词词性的定义
for synset in wn.synsets('mint', wn.NOUN):
    print(synset.name() + ':', synset.definition())
#mint.n.04是mint.n.02的一部分
print(wn.synset('mint.n.04').part_holonyms())
#mint.n.04是组成mint.n.05的材质
print(wn.synset('mint.n.04').substance_holonyms())
```


```python
#动词之间也有关系
print('走路(walk)先抬脚：',wn.synset('walk.v.01').entailments())
print('吃要咀嚼和咽下：',wn.synset('eat.v.01').entailments())
print('取笑包含引发+失望：',wn.synset('tease.v.03').entailments())
```


```python
#利用同样的方法可以查询反义词
wn.lemma('supply.n.02.supply').antonyms()
wn.lemma('staccato.r.01.staccato').antonyms()
#利用dir（）查看词汇关系和同义词集上定义的其它方法
dir(wn.synset('harmony.n.02'))
```

# 5.3 更多的词汇关系：上位词和下位词被称为词汇关系，WordNet 网络另一个重要的漫游方式是从元素到它们的部件（部分）或到它们被包含其中的东西（整体）。例如，一棵树的部分是它的树干，树冠等。


```python
#露脊鲸
right = wn.synset('right_whale.n.01')
#逆戟鲸
orca = wn.synset('orca.n.01')
#小须鲸
minke = wn.synset('minke_whale.n.01')
#乌龟
tortoise = wn.synset('tortoise.n.01')
#小说
novel = wn.synset('novel.n.01')
print('露脊鲸与小须鲸的最小共同上级:',right.lowest_common_hypernyms(minke))
print('露脊鲸与逆戟鲸的最小共同上级:',right.lowest_common_hypernyms(orca))
print('露脊鲸与乌龟的最小共同上级:',right.lowest_common_hypernyms(tortoise))
print('露脊鲸与小说的最小共同上级:',right.lowest_common_hypernyms(novel))
#鲸鱼是非常具体的（须鲸更是如此），脊椎动物高级抽象，而实体则是最高级的抽象
#我们可以通过查找每个同义词集深度量化比较其量级
print('须鲸的词集深度：',wn.synset('baleen_whale.n.01').min_depth())
print('鲸鱼的词集深度：',wn.synset('whale.n.02').min_depth())
print('脊椎动物的词集深度：',wn.synset('vertebrate.n.01').min_depth())
print('实体的词集深度：',wn.synset('entity.n.01').min_depth())
```

# WordNet 同义词集的集合上定义了类似的函数能够深入的观察。例如：tyassigns 是基于上位词层次结构中相互连接的概念之间的最短路径在0-1 范围的打分（两者之间没有路径就返回-1）。同义词集与自身比较将返回1。考虑以下的相似度：露脊鲸与小须鲸、逆戟鲸、乌龟以及小说。


```python
print(right.path_similarity(minke))
print(right.path_similarity(orca))
print(right.path_similarity(tortoise))
print(right.path_similarity(novel))

```
