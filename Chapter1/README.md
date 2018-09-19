
# 运用NLTK包来对文本进行基本操作
1.通过 pip install nltk 安装python nltk包
2.python的NLTK是一个开源的项目，全称natural language toolkit,在项目中包含了Python模块，数据集和教程，主要用于NLP的研究和开发。
3.其中基本的内置函数有：
4.关键词搜索：concordance 查找词出现位置
5.相关词索引：similar 查找哪些词出现在相似的上下文中
6.相同上下文查找：common_contexts
7.检测词出现位置：dispersion_plot
8.获取长度：len()
9.词表排序：sorted()
10.扩充词表：append()
11.索引列表：index()（链表从0开始计数）（索引过大会造成超界）
12.切片操作：list[a:b] 获得a到b之间的数组
13.#在定义变量是切记不能与保留字冲突#
14.字符串可以进行乘法和加法操作，但不能进行减法和除法操作
15.使用FreqDist可以生成字典
16.可以通过循环和特征语句来根据特征选择词，也可以通过多个特征选择词
17.在ipython中可通过Tab+Shift查看自带的函数命令
18.通过数值比较运算符和词汇比较运算发可以起到决策和控制的作用


# 自然语言处理在实际应用中的例子：

## 词意消歧
意义：分析上下文中的词被赋予的是哪个意思
特征：需要使用上下文并利用相邻词汇的相近含义
方法1：基于词典的词义消歧方法
    基于词典的词义消歧始于利用词典中词义(亦称“义项”)解释或定义来指导歧义词的词义判断目。该方法简单易行，只需计算歧义词的各个词义在词典中的定义与歧义词上下文词语的定义之间的覆盖度，选择覆盖度最大的作为正确的词义。词典对词义的定义语句力求简单明了，这样使得很多歧义词的各个词义解释与上下文词语的覆盖度几乎为零，造成消歧失败。
方法2：基于语料库的词义消歧
    基于语料库的统计方法通过计算给定文本中词汇语义在多义词上下文中的概率权重，选择具有最大概率权重的语义作为最佳结果输出，该方法根据训练语料事先是否经过人工标注又可以分为两类：有指导的词义消歧和无指导的的词义消歧幽。

## 指代消解
意义：检测动词的主语和宾语
例如：The thieves stole the paintings.They were subsequently sold(caught/found)
存在歧义寻找they的先行词：
    指代消解：解决确定代词或名词短语指的是什么
    语义角色标注：确定名词短语如何与动词相关联

## 语义角色标注和语义依存分析
引用自：https://www.ltp-cloud.com/intro/ 更多相关语言分析可从上面找到
意义：语义角色标注 (Semantic Role Labeling, SRL) 是一种浅层的语义分析技术，标注句子中某些短语为给定谓词的论元 (语义角色) ，如施事、受事、时间和地点等。其能够对问答系统、信息抽取和机器翻译等应用产生推动作用。 
核心的语义角色为 A0-5 六种，A0 通常表示动作的施事，A1通常表示动作的影响等，A2-5 根据谓语动词不同会有不同的语义含义。其余的15个语义角色为附加语义角色，如LOC 表示地点，TMP 表示时间等。附加语义角色列表如下：
标记	说明
ADV	adverbial, default tag ( 附加的，默认标记 )
BNE	beneﬁciary ( 受益人 )
CND	condition ( 条件 )
DIR	direction ( 方向 )
DGR	degree ( 程度 )
EXT	extent ( 扩展 )
FRQ	frequency ( 频率 )
LOC	locative ( 地点 )
MNR	manner ( 方式 )
PRP	purpose or reason ( 目的或原因 )
TMP	temporal ( 时间 )
TPC	topic ( 主题 )
CRD	coordinated arguments ( 并列参数 )
PRD	predicate ( 谓语动词 )
PSR	possessor ( 持有者 )
PSE	possessee ( 被持有 )

意义：语义依存分析 (Semantic Dependency Parsing, SDP)，分析句子各个语言单位之间的语义关联，并将语义关联以依存结构呈现。 使用语义依存刻画句子语义，好处在于不需要去抽象词汇本身，而是通过词汇所承受的语义框架来描述该词汇，而论元的数目相对词汇来说数量总是少了很多的。语义依存分析目标是跨越句子表层句法结构的束缚，直接获取深层的语义信息。
语义依存分析不受句法结构的影响，将具有直接语义关联的语言单元直接连接依存弧并标记上相应的语义关系。这也是语义依存分析与句法依存分析的重要区别。
语义依存与语义角色标注之间也存在关联，语义角色标注只关注句子主要谓词的论元及谓词与论元之间的关系，而语义依存不仅关注谓词与论元的关系，还关注谓词与谓词之间、论元与论元之间、论元内部的语义关系。语义依存对句子语义信息的刻画更加完整全面。

语义依存关系分为三类，分别是主要语义角色，每一种语义角色对应存在一个嵌套关系和反关系；事件关系，描述两个事件间的关系；语义依附标记，标记说话者语气等依附性信息。

关系类型	Tag	Description	Example
施事关系	Agt	Agent	我送她一束花 (我 <-- 送)
当事关系	Exp	Experiencer	我跑得快 (跑 --> 我)
感事关系	Aft	Affection	我思念家乡 (思念 --> 我)
领事关系	Poss	Possessor	他有一本好读 (他 <-- 有)
受事关系	Pat	Patient	他打了小明 (打 --> 小明)
客事关系	Cont	Content	他听到鞭炮声 (听 --> 鞭炮声)
成事关系	Prod	Product	他写了本小说 (写 --> 小说)
源事关系	Orig	Origin	我军缴获敌人四辆坦克 (缴获 --> 坦克)
涉事关系	Datv	Dative	他告诉我个秘密 ( 告诉 --> 我 )
比较角色	Comp	Comitative	他成绩比我好 (他 --> 我)
属事角色	Belg	Belongings	老赵有俩女儿 (老赵 <-- 有)
类事角色	Clas	Classification	他是中学生 (是 --> 中学生)
依据角色	Accd	According	本庭依法宣判 (依法 <-- 宣判)
缘故角色	Reas	Reason	他在愁女儿婚事 (愁 --> 婚事)
意图角色	Int	Intention	为了金牌他拼命努力 (金牌 <-- 努力)
结局角色	Cons	Consequence	他跑了满头大汗 (跑 --> 满头大汗)
方式角色	Mann	Manner	球慢慢滚进空门 (慢慢 <-- 滚)
工具角色	Tool	Tool	她用砂锅熬粥 (砂锅 <-- 熬粥)
材料角色	Malt	Material	她用小米熬粥 (小米 <-- 熬粥)
时间角色	Time	Time	唐朝有个李白 (唐朝 <-- 有)
空间角色	Loc	Location	这房子朝南 (朝 --> 南)
历程角色	Proc	Process	火车正在过长江大桥 (过 --> 大桥)
趋向角色	Dir	Direction	部队奔向南方 (奔 --> 南)
范围角色	Sco	Scope	产品应该比质量 (比 --> 质量)
数量角色	Quan	Quantity	一年有365天 (有 --> 天)
数量数组	Qp	Quantity-phrase	三本书 (三 --> 本)
频率角色	Freq	Frequency	他每天看书 (每天 <-- 看)
顺序角色	Seq	Sequence	他跑第一 (跑 --> 第一)
描写角色	Desc(Feat)	Description	他长得胖 (长 --> 胖)
宿主角色	Host	Host	住房面积 (住房 <-- 面积)
名字修饰角色	Nmod	Name-modifier	果戈里大街 (果戈里 <-- 大街)
时间修饰角色	Tmod	Time-modifier	星期一上午 (星期一 <-- 上午)
反角色	r + main role		打篮球的小姑娘 (打篮球 <-- 姑娘)
嵌套角色	d + main role		爷爷看见孙子在跑 (看见 --> 跑)
并列关系	eCoo	event Coordination	我喜欢唱歌和跳舞 (唱歌 --> 跳舞)
选择关系	eSelt	event Selection	您是喝茶还是喝咖啡 (茶 --> 咖啡)
等同关系	eEqu	event Equivalent	他们三个人一起走 (他们 --> 三个人)
先行关系	ePrec	event Precedent	首先，先
顺承关系	eSucc	event Successor	随后，然后
递进关系	eProg	event Progression	况且，并且
转折关系	eAdvt	event adversative	却，然而
原因关系	eCau	event Cause	因为，既然
结果关系	eResu	event Result	因此，以致
推论关系	eInf	event Inference	才，则
条件关系	eCond	event Condition	只要，除非
假设关系	eSupp	event Supposition	如果，要是
让步关系	eConc	event Concession	纵使，哪怕
手段关系	eMetd	event Method	
目的关系	ePurp	event Purpose	为了，以便
割舍关系	eAban	event Abandonment	与其，也不
选取关系	ePref	event Preference	不如，宁愿
总括关系	eSum	event Summary	总而言之
分叙关系	eRect	event Recount	例如，比方说
连词标记	mConj	Recount Marker	和，或
的字标记	mAux	Auxiliary	的，地，得
介词标记	mPrep	Preposition	把，被
语气标记	mTone	Tone	吗，呢
时间标记	mTime	Time	才，曾经
范围标记	mRang	Range	都，到处
程度标记	mDegr	Degree	很，稍微
频率标记	mFreq	Frequency Marker	再，常常
趋向标记	mDir	Direction Marker	上去，下来
插入语标记	mPars	Parenthesis Marker	总的来说，众所周知
否定标记	mNeg	Negation Marker	不，没，未
情态标记	mMod	Modal Marker	幸亏，会，能
标点标记	mPunc	Punctuation Marker	，。！
重复标记	mPept	Repetition Marker	走啊走 (走 --> 走)
多数标记	mMaj	Majority Marker	们，等
实词虚化标记	mVain	Vain Marker	
离合标记	mSepa	Seperation Marker	吃了个饭 (吃 --> 饭) 洗了个澡 (洗 --> 澡)
根节点	Root	Root	全句核心节点

## 机器翻译
我们的翻译机器就是其中带有问号的黑箱，它的作用就是能够将一个语言的序列（如Economic growth has slowed down in recent years）转化成目标语言序列（如La croissance economique sest ralentie ces dernieres annees）。其中翻译机器在正式工作之前可以利用已有的语料库（Corpora）来进行学习和训练。所谓的神经网络机器翻译就是利用神经网络来实现上述的黑箱翻译机器。
编码解码框架（2014年中期提出）
注意力机制（2014年末提出）
外存（2015年新星）
残差网络（2015年新星）
其它辅助手段（2016年新技术

## 人机对话系统
人机对话系统
    闲聊系统：开放域
    知识问答：开放域知识获取
    任务执行：特定域完成任务或动作
    推荐：特定域信息推荐
实用技术：
    语言理解：序列标注----》深度学习
    对话管理：基于规则---》基于有指导学习---》强化学习
    对话生成：基于模板---》语言模型---》Seq2Seq
    多轮对话：重排序模型---》层次化模型---》DQN模型



```python
import nltk
nltk.download()
from nltk.book import *
text1#可以显示text1中的文本
text1.concordance("monstrous")
text1.similar("monstrous")
```


```python
text2.common_contexts(["monstrous","very"])
text4.dispersion_plot(["citizens","democracy","freedom","duties","America"])
len(text3)
sorted(set(text3))
len(text3)/len(set(text3))
```


```python
#定义函数
def divlen(text):
    return len(text)/len(set(text))
divlen(text3)
```


```python
#词表基本操作
let1=['you','shi','shui','?']
let2=['me','shi','sha','*','.']
let1+let2
let1.append(let2)
let1
text4[64]
text4.index('voice')
```


```python
#切片操作
let1[:2]
let1[1:]
let1[0:3]
#通过切片来替换元素
let3=['0','1','2','3','4','5','6','7']
let3[1:3]='x'
let3
num=let3[1:3]
```


```python
#字符串加法和乘法
name1='bili'
name2='tuoku'
name3=name1*2
name4=name1*2+' '+name2
```


```python
#词频绘图
fre=FreqDist(text1)
fre
fre.keys
fre.plot(50,cumulative=True)
```


```python
#根据特征选择词
V=set(text1)
long_words=[w for w in V if len(w)>15]
fred=FreqDist(text1)
long_fre_words=[w for w in V if len(w)>7 and fred[w]>7]
long_fre_words
fred.items
fred.items()
```


```python
#循环条件判断
for word in let2:
    if word.endswith('i'):
        print(word)
```
