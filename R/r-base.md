# R语言编程（Base）

## 目录

- [1 向量](#1-向量)
  - [1.1 标量、向量、数组、矩阵](#11-标量向量数组矩阵)
    - [1.1.1 添加或删除向量元素](#111-添加或删除向量元素)
    - [1.1.2 获取向量长度](#112-获取向量长度)
    - [1.1.3 作为向量的矩阵和数值](#113-作为向量的矩阵和数值)
  - [1.2 声明](#12-声明)
  - [1.3 循环补齐](#13-循环补齐)
  - [1.4 常用的向量运算](#14-常用的向量运算)
    - [1.4.1 向量运算和逻辑运算](#141-向量运算和逻辑运算)
    - [1.4.2 向量索引](#142-向量索引)
    - [1.4.3 用:运算符创建向量](#143-用运算符创建向量)
    - [1.4.4 使用seq()创建向量](#144-使用seq创建向量)
    - [1.4.5 使用rep()重复向量常数](#145-使用rep重复向量常数)
  - [1.5 使用all()与any()](#15-使用all与any)
  - [1.6 向量化运算](#16-向量化运算)
    - [1.6.1 向量输入，向量输入](#161-向量输入向量输入)
    - [1.6.2 向量输入，矩阵输出](#162-向量输入矩阵输出)
  - [1.7 NA与NULL值](#17-NA与NULL值)
    - [1.7.1 NA的使用](#171-NA的使用)
    - [1.7.2 NULL的使用](#172-NULL的使用)
  - [1.8 筛选](#18-筛选)
    - [1.8.1 生成筛选索引](#181-生成筛选索引)
    - [1.8.2 使用subset()函数筛选](#182-使用subset函数筛选)
    - [1.8.3 选择函数which()](#183-选择函数which)
  - [1.9 向量化的ifelse()函数](#19-向量化的ifelse函数)
  - [1.10 测试向量相等](#110-测试向量相等)
  - [1.11 向量元素的名称](#111-向量元素的名称)
  - [1.12 关于c()的更多内容](#112-关于c的更多内容)
- [2 矩阵和数组](#2-矩阵和数组)
  - [2.1 创建矩阵](#21-创建矩阵)
  - [2.2 一般矩阵运算](#22-一般矩阵运算)
  - [2.3 对矩阵的行和列调用函数](#23-对矩阵的行和列调用函数)
  - [2.4 增加或删除矩阵的行或列](#24-增加或删除矩阵的行或列)
  - [2.5 向量与矩阵的差异](#25-向量与矩阵的差异)
  - [2.6 避免意外降维](#26-避免意外降维)
  - [2.7 矩阵的行和列的命名问题](#27-矩阵的行和列的命名问题)
  - [2.8 高维数组](#28-高维数组)
- [3 列表](#3-列表)
  - [3.1 创建列表](#31-创建列表)
  - [3.2 列表的常规操作](#32-列表的常规操作)
  - [3.3 访问列表元素和值](#33-访问列表元素和值)
  - [3.4 在列表上使用apply系列函数](#34-在列表上使用apply系列函数)
  - [3.5 递归型列表](#35-递归型列表)
- [4 数据框](#4-数据框)
  - [4.1 创建数据框](#41-创建数据框)
  - [4.2 其他矩阵式操作](#42-其他矩阵式操作)
  - [4.3 合并数据框](#43-合并数据框)
  - [4.4 应用于数据框的函数](#44-应用于数据框的函数)
- [5 因子和表](#5-因子和表)
  - [5.1 因子的水平](#51-因子的水平)
  - [5.2 因子的常用函数](#52-因子的常用函数)
  - [5.3 表的操作](#53-表的操作)
  - [5.4 其他与因子和表有关的函数](#54-其他与因子和表有关的函数)
- [6 R语言编程结构](#6-R语言编程结构)
  - [6.1 控制语句](#61-控制语句)
  - [6.2 算术的逻辑运算符和数值](#62-算术的逻辑运算符和数值)
  - [6.3 参数的默认值](#63-参数的默认值)
  - [6.4 返回值](#64-返回值)
  - [6.5 函数都是对象](#65-函数都是对象)
  - [6.6 环境和变量作用域的问题](#66-环境和变量作用域的问题)
  - [6.7 R语言中没有指针](#67-R语言中没有指针)
  - [6.8 向上级层次进行写操作](#68-向上级层次进行写操作)
  - [6.9 什么时候使用全局变量](#69-什么时候使用全局变量)
  - [6.10 闭包](#610-闭包)
- [7 数学运算与模拟](#7-数学运算与模拟)
  - [7.1 数学函数](#71-数学函数)
  - [7.2 统计分布函数](#72-统计分布函数)
  - [7.3 排序](#73-排序)
  - [7.4 向量和矩阵的线性代数运算](#74-向量和矩阵的线性代数运算)
  - [7.5 集合运算](#75-集合运算)
  - [7.6 用R做模拟](#76-用R做模拟)
- [8 面向对象的编程](#8-面向对象的编程)
  - [8.1 S3类](#81-S3类)
    - [8.1.1 S3泛型函数](#811-S3泛型函数)
    - [8.1.2 寻找泛型函数的实现方法](#812-寻找泛型函数的实现方法)
    - [8.1.3 编写S3类](#813-编写S3类)
    - [8.1.4 使用继承](#814-使用继承)
  - [8.2 S4类](#82-S4类)
    - [8.2.1 编写S4类](#821-编写S4类)
    - [8.2.2 在S4类上实现泛型函数](#822-在S4类上实现泛型函数)
  - [8.3 S3类和S4类的对比](#83-S3类和S4类的对比)
  - [8.4 对象的管理](#84-对象的管理)
    - [8.4.1 使用ls()函数列出所有对象](#841-使用ls函数列出所有对象)
    - [8.4.2 使用rm()函数删除特定对象](#842-使用rm函数删除特定对象)
    - [8.4.3 使用save()函数保存对象集合](#843-使用save函数保存对象集合)
    - [8.4.4 查看对象内部结构](#844-查看对象内部结构)
    - [8.4.5 exists()函数](#845-exists函数)
- [9 输入与输出](#9-输入与输出)
  - [9.1 连接键盘与显示器](#91-连接键盘与显示器)
    - [9.1.1 使用scan()函数](#911-使用scan函数)
    - [9.1.2 使用readline()函数](#912-使用readline函数)
    - [9.1.3 输出到显示器](#913-输出到显示器)
  - [9.2 读写文件](#92-读写文件)
    - [9.2.1 从文件中读取数据框或矩阵](#921-从文件中读取数据框或矩阵)
    - [9.2.2 读取文本文件](#922-读取文本文件)
    - [9.2.3 连接的介绍](#923-连接的介绍)
    - [9.2.4 写文件](#924-写文件)
    - [9.2.5 获取文件和目录信息](#925-获取文件和目录信息)
  - [9.3 访问互联网](#93-访问互联网)
- [10 字符串操作](#10-字符串操作)
  - [10.1 字符串操作函数概述](#101-字符串操作函数概述)
    - [10.1.1 grep()](#1011-grep)
    - [10.1.2 nchar()](#1012-nchar)
    - [10.1.3 paste()](#1013-paste)
    - [10.1.4 sprintf()](#1014-sprintf)
    - [10.1.5 substr()](#1015-substr)
    - [10.1.6 strsplit()](#1016-strsplit)
    - [10.1.7 regexpr()](#1017-regexpr)
    - [10.1.8 gregexpr()](#1018-gregexpr)
  - [10.2 正则表达式](#102-正则表达式)
- [11 绘图](#11-绘图)
- [12 调试](#12-调试)
- [13 性能提升：速度与内存](#13-性能提升速度与内存)
- [14 R语言并行计算](#14-R语言并行计算)

## 1 向量

> R语言中最基本的数据类型是向量(vector)，单个数值（标量）没有单独的数据类型，只不过是向量的一种特例。另一方面R语言中的矩阵是向量的一种特例。

> R语言中变量类型称为模式(mode)。同一向量中的所有元素必须是相同的模式（整型、数值型、字符型、逻辑型、复数型等等）。如果在程序中查看变量x的类型，可以调用函数typeof(x)进行查询。

### 1.1 标量、向量、数组、矩阵

#### 1.1.1 添加或删除向量元素

R中向量是连续存储的，因此不能插入或删除元素。向量在创建时已经确定，如果想要添加或删除元素，需要重新给向量赋值。

```r
> x <- c(88,5,12,13)
> x <- c(x[1:3],168,x[4])
> x
[1]  88   5  12 168  13
```

x本质上时一个指针（注意：R中没有指针的概念），重新赋值时通过将x指向新向量的方式实现的。但是这种方式实际上有一些潜在的副作用，当数据量庞大之后，会影响R的执行速度。

#### 1.1.2 获取向量长度

使用length()获取向量的长度。

```r
> x <- c(1,2,4)
> length(x)
[1] 3
```

#### 1.1.3 作为向量的矩阵和数值

### 1.2 声明

### 1.3 循环补齐

### 1.4 常用的向量运算

#### 1.4.1 向量运算和逻辑运算

#### 1.4.2 向量索引

#### 1.4.3 用:运算符创建向量

#### 1.4.4 使用seq()创建向量

#### 1.4.5 使用rep()重复向量常数

### 1.5 使用all()与any()

### 1.6 向量化运算

#### 1.6.1 向量输入，向量输入

#### 1.6.2 向量输入，矩阵输出

### 1.7 NA与NULL值

#### 1.7.1 NA的使用

#### 1.7.2 NULL的使用

### 1.8 筛选

#### 1.8.1 生成筛选索引

#### 1.8.2 使用subset()函数筛选

#### 1.8.3 选择函数which()

### 1.9 向量化的ifelse()函数

### 1.10 测试向量相等

### 1.11 向量元素的名称

### 1.12 关于c()的更多内容

## 2 矩阵和数组

### 2.1 创建矩阵

### 2.2 一般矩阵运算

### 2.3 对矩阵的行和列调用函数

### 2.4 增加或删除矩阵的行或列

### 2.5 向量与矩阵的差异

### 2.6 避免意外降维

### 2.7 矩阵的行和列的命名问题

### 2.8 高维数组

## 3 列表

### 3.1 创建列表

### 3.2 列表的常规操作

### 3.3 访问列表元素和值

### 3.4 在列表上使用apply系列函数

### 3.5 递归型列表

## 4 数据框

### 4.1 创建数据框

### 4.2 其他矩阵式操作

### 4.3 合并数据框

### 4.4 应用于数据框的函数

## 5 因子和表

### 5.1 因子的水平

### 5.2 因子的常用函数

### 5.3 表的操作

### 5.4 其他与因子和表有关的函数

## 6 R语言编程结构

### 6.1 控制语句

### 6.2 算术的逻辑运算符和数值

### 6.3 参数的默认值

### 6.4 返回值

### 6.5 函数都是对象

### 6.6 环境和变量作用域的问题

### 6.7 R语言中没有指针

### 6.8 向上级层次进行写操作

### 6.9 什么时候使用全局变量

### 6.10 闭包

## 7 数学运算与模拟

### 7.1 数学函数

### 7.2 统计分布函数

### 7.3 排序

### 7.4 向量和矩阵的线性代数运算

### 7.5 集合运算

### 7.6 用R做模拟

## 8 面向对象的编程

> 面向对象编程（Obejct-Oriented Programming):一切皆是对象。
>
> 1. 封装(encapsulation)：把独立但相关的数据项目打包为一个类的实例。
> 2. 多态(polymorphic)：相同的函数使用不同类的对象时可以调用不同的操作。
> 3. 继承(inheritance)：允许把一个给定的类的性质自动赋予为其下属的更特殊化的类。

### 8.1 S3类

大多数R中内置的类都是S3类：一个S3类包含一个列表，再附加上一个类名属性和调度的功能。

#### 8.1.1 S3泛型函数

具有多态性的函数，如plot()和print()，称为泛型函数。在调用一个泛型函数时，R会把该调用调度到适当的类方法，也就是把对泛型函数的调用重新定向到针对该对象的类所定义的函数上。

```r
x <- c(1,2,3)
y <- c(1,3,8)
lmout <- lm(y~x)
class(lmout)
print(lmout)
```

```r
> print

function (x, ...) 
UseMethod("print")
<bytecode: 0x000001bdd66ef688>
<environment: namespace:base>
```

print()函数仅仅由一个对UseMethod()的调用构成。实际上这是一个调度函数，因此将print()视为一个泛型函数，实际上调用的是lm类型中的print.lm()函数。

#### 8.1.2 寻找泛型函数的实现方法

可以调用methods()来找到给定泛型函数的所有实现方法。

```r
methods(generic.function, class)
```

```r
> methods(print)
  [1] print.acf*                                          
  [2] print.activeConcordance*                            
  [3] print.anova*                                        
  [4] print.aov*                                          
  [5] print.aovlist*                                      
  [6] print.ar*                                           
  [7] print.Arima*                                        
  [8] print.arima0*                                       
  [9] print.AsIs*                                         
 [10] print.aspell*                                       
 ...
```

```r
methods(, "lm")
 [1] add1           alias          anova          case.names     coerce        
 [6] confint        cooks.distance deviance       dfbeta         dfbetas       
[11] drop1          dummy.coef     effects        extractAIC     family        
[16] formula        hatvalues      influence      initialize     kappa         
[21] labels         logLik         model.frame    model.matrix   nobs          
[26] plot           predict        print          proj           qr            
[31] residuals      rstandard      rstudent       show           simulate      
[36] slotsFromS3    summary        variable.names vcov          
see '?methods' for accessing help and source code
```

星号标准的是不可见函数，即不在默认命名空间中的函数。可以通过getAnywhere()找到这些函数，然后使用命名空间限定符访问它们。

```r
> getAnywhere(print.lm)
A single object matching ‘print.lm’ was found
It was found in the following places
  registered S3 method for print from namespace stats
  namespace:stats
with value

function (x, digits = max(3L, getOption("digits") - 3L), ...) 
{
    cat("\nCall:\n", paste(deparse(x$call), sep = "\n", collapse = "\n"), 
        "\n\n", sep = "")
    if (length(coef(x))) {
        cat("Coefficients:\n")
        print.default(format(coef(x), digits = digits), print.gap = 2L, 
            quote = FALSE)
    }
    else cat("No coefficients\n")
    cat("\n")
    invisible(x)
}
<bytecode: 0x000001bdd63f6ed8>
<environment: namespace:stats>
```

#### 8.1.3 编写S3类

S3类中一个类的实例时用过构建一个列表的方式来创建的，这个列表的组件时该类的成员变量。

“类”属性通过attr()或者class()函数手动设置，然后再定义各种泛型函数的实现方法。

```r
> lm
function (formula, data, subset, weights, na.action, method = "qr", 
    model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, 
    contrasts = NULL, offset, ...) 
{
   ...
        z <- list(coefficients = if (mlm) matrix(NA_real_, 0, 
            ncol(y)) else numeric(), residuals = y, fitted.values = 0 * 
            y, weights = w, rank = 0L, df.residual = if (!is.null(w)) sum(w != 
            0) else ny)
   ...
    class(z) <- c(if (mlm) "mlm", "lm")
    z$na.action <- attr(mf, "na.action")
    z$offset <- offset
    z$contrasts <- attr(x, "contrasts")
    z$xlevels <- .getXlevels(mt, mf)
    z$call <- cl
    z$terms <- mt

    z
}
```

代码中有基本类创建的过程。创建一个列表并赋值为z，z在这里充当的时“lm”类实例的框架的功能（并最终变为函数的返回值）。这个列表的一些组件，例如residuals在列表创建时已经赋值。此外，将类属性设定为“lm”。

#### 8.1.4 使用继承

继承的思想时在已有类的基础上创建新的类。创建一个员工数据的例子：

```r
j <- list(name="joe",salary=55000, union=T)
class(j) <- "employee"

print.employee <- function(wrkr){
  cat(wrkr$name, "\n")
  cat("salary", wrkr$salary, "\n")
  cat("union member",wrkr$union, "\n")
}
methods(, "employee")
print(j)

```

船舰一个针对小时工的新类“hrlyemployee"作为“employee”的子类。

```r
k <- list(name="kate", salary=6800, union=F, hrsthismonth=2)
class(k) <- c("hrlyemployee", "employee")
class(k)
print(k)

```

新的类多了一个变量：hrsthismonth。新类的名称包含两个字符串，分别代表新类和类原有的类。新类继承了原有类的方法。

子类调用print()的逻辑是：首选调用print()函数中的UseMethod()，去查找“hrlyemployee"类的打印方法，这是因为“hrlyemployee"是子类的两个类名称的第一个。结果没有找到对应的方法，所以UseMethod()尝试去找另一个类“employee”对应的打印方法，找到print.employee()，然后执行该函数。

### 8.2 S4类

S3类不具有面向对象编程固有的安全性。

| 操作        | S3类             | S4类          |
| --------- | --------------- | ------------ |
| 定义类       | 在构造函数的代码中隐式定义   | setClass()   |
| 创建对象      | 船舰列表，设置类属性      | new()        |
| 引用成员变量    | \$              | @            |
| 实现泛型函数f() | 定义f.classname() | setMethod()  |
| 申明泛型函数    | UseMethod()     | setGeneric() |

#### 8.2.1 编写S4类

调用setClass()来定义一个S4类，同时定义类的成员变量，每个成员都有明确的类型。然后使用构造函数new()为此类创建一个实例。

```r
setClass("employee",representation(
  name="character",
  salary="numeric",
  union="logical"
  )
)

joe <- new("employee", name="Joe", salary=5500, union=T)
```

可以通过@符号访问类的属性，也可以通过slot()函数访问。

S4类的优点在于安全性，即使将类的属性拼写错误也不会添加新的属性，因为S3类仅仅是一个列表形式，可以随时添加新的组件。

#### 8.2.2 在S4类上实现泛型函数

在S4类中show()充当S3类的泛型函数print()功能。在“employee”类中添加一个泛型函数show()的调用方法。

```r
setMethod("show", "employee",
          function(object){
            inorout <- ifelse(object@union, "is", "is not")
            cat(object@name,"has a salary of", object@salary, "and", inorout, "in the union", "\n")
          })
show(joe)

Joe has a salary of 5500 and is in the union 

```

使用setMethod()函数实现，第一个参数设定了将要定义的给定类方法的泛型函数名，第二个参数则设定了类的名称。

### 8.3 S3类和S4类的对比

S3更便捷，S4更安全。

但目前该使用哪种类一直是R语言程序员争论的主题。

### 8.4 对象的管理

#### 8.4.1 使用ls()函数列出所有对象

ls()命令可以用来列出现存的所有对象。其中一个有用的参数是pattern，可以支持通配符列出具有特定模式的对象。

```r
> ls()
[1] "j"              "joe"            "k"              "lmout"          "print.employee"
[6] "wrds"           "x"              "y"             

> ls(pattern = "j")
[1] "j"   "joe"
```

#### 8.4.2 使用rm()函数删除特定对象

rm()函数可以删除掉不再使用的对象。有一个有用的参数是list，可以删除多个对象。

```r
rm(j,x,y)
rm(list=ls())
rm(list=ls(pattern="j"))
```

#### 8.4.3 使用save()函数保存对象集合

save()函数将指定对象写入硬盘中保存，然后可以使用load()函数重新读入到命名空间。

#### 8.4.4 查看对象内部结构

class(), mode()

names(), attributes()

unclass(), str()

edit()

#### 8.4.5 exists()函数

exists()函数根据其参数是否存在返回TRUE或者FALSE。需要注意的是需要把参数放在引号里面。

```r
> exists("acc")

[1] TRUE
```

## 9 输入与输出

### 9.1 连接键盘与显示器

#### 9.1.1 使用scan()函数

使用scan()函数从文件中读取或用键盘输入一个向量，可以是数值型或字符型向量。

#### 9.1.2 使用readline()函数

#### 9.1.3 输出到显示器

### 9.2 读写文件

#### 9.2.1 从文件中读取数据框或矩阵

#### 9.2.2 读取文本文件

#### 9.2.3 连接的介绍

#### 9.2.4 写文件

#### 9.2.5 获取文件和目录信息

file.info(): 参数是表示文件名称的字符串向量，函数会给出每个文件的大小、创建时间、是否为目录等信息。

dir(): 返回一个字符向量，列出在其第一个参数指定的目录中所有文件的名称。如果指定可选参数recursive=TRUE，结果将把第一个参数下面整个目录树都显示出来。

file.exists(): 返回一个布尔向量，表示作为第一个参数的字符串向量中给定的每个文件名是否存在。

getwd()和setwd(): 用于确定或改变当前工作目录。

### 9.3 访问互联网

## 10 字符串操作

### 10.1 字符串操作函数概述

#### 10.1.1 grep()

grep(pattern,x)语句在字符串向量x里收缩给定子字符串pattern。如果x有n个元素，即包含n个字符串，则grep(pattern, x)会返回一个长度不超过n的向量。这个向量的每个元素是x的索引，表示在索引对应的元素x\[i]中有与pattern匹配的子字符串。

```r
> grep("pole", c("equator", "north pole", "south pole"))
[1] 2 3

> grep("Pole", c("equator", "north pole", "south pole"))
integer(0)
```

#### 10.1.2 nchar()

nchar(x)函数返回字符串x的长度。

```r
> nchar("south pole")
[1] 10
```

如果x不是字符形式，nchar()函数会得到不可预料的结果。例如nchar(NA)的结果是2，nchar(factor("abc"))得到1。

#### 10.1.3 paste()

paste(...)函数把若干个字符串（向量）拼接起来，返回一个长字符串。

可选参数sep可以用除了空格以外的其他符号把各个字符串组件连接起来。如果指定sep为空字符串，则字符串之间没有任何字符。

```r
> paste("north","pole")
[1] "north pole"

> paste("north","pole",sep="")
[1] "northpole"

> paste("north","pole",sep=".")
[1] "north.pole"

> paste("a", c(1,2,3),sep="")
[1] "a1" "a2" "a3"

> paste("a", c(1,2,3), ".pdf",sep="")
[1] "a1.pdf" "a2.pdf" "a3.pdf"
```

collapse参数指定符号将元素之间连接起来。

```r
> paste("a", c(1,2,3), ".pdf",sep="", collapse=" + ")
[1] "a1.pdf + a2.pdf + a3.pdf"

> paste(1:3, collapse="+")
[1] "1+2+3"
```

paste0()函数与paste()函数唯一的区别是：默认sep=""，以空字符串连接字符。

#### 10.1.4 sprintf()

sprintf(...)按照一定格式把若干个组件组合成字符串。表示“打印”到字符串里(string print)，而不是打印到屏幕上。

```r
> sprintf("the square of %d is %d", 4, 16)
[1] "the square of 4 is 16"

```

#### 10.1.5 substr()

substr(x,start, stop)函数返回给定字符串x中指定位置范围start:stop上的子字符串。

```php
> substr("equator",3,5)
[1] "uat"

```

#### 10.1.6 strsplit()

strsplit(x,split)函数根据x中的字符串split把字符串x拆分成若干子字符串，返回字写子字符串组成的R列表。

```r
> strsplit("6-16-2011",split="-")
[[1]]
[1] "6"    "16"   "2011"
```

#### 10.1.7 regexpr()

regexpr(pattern, text)在字符串text中寻找pattern，返回与pattern匹配的第一个子字符串的起始字符位置。

```r
> regexpr("uat", "equator")
[1] 3

```

#### 10.1.8 gregexpr()

gregexpr(pattern,text)的功能与regexpr()一样，不过它会寻找与pattern匹配的全部子字符串的起始位置。

```r
> gregexpr("iss","Mississippi")
[[1]]
[1] 2 5
```

### 10.2 正则表达式

当使用字符串函数grep(),grepl(),regexpr(),gregexpr(),sub(),gsub(),strsplit()时，会涉及到正则表达式的概念。

正则表达式是一种通配符，他是用来描述一系列字符串的简略表达式。

```r
> grep("[au]",c("equator","north pole","south pole"))
[1] 1 3

> grep("o.e",c("equator","north pole","south pole"))
[1] 2 3

> grep("n..t",c("equator","north pole","south pole"))
[1] 2

> grep("\\.", c("abc", "de", "f.g"))
[1] 3

```

## 11 绘图

## 12 调试

## 13 性能提升：速度与内存

## 14 R语言并行计算
