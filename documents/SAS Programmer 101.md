# SAS-Programmer-101

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [SAS-Programmer-101](#sas-programmer-101)
  - [数据集选项执行顺序](#数据集选项执行顺序)
    - [选项执行顺序](#选项执行顺序)
    - [常见数据集选项](#常见数据集选项)
  - [SAS EG设置自动查log的方法](#sas-eg设置自动查log的方法)
  - [处理特殊字符与输出特殊符号](#处理特殊字符与输出特殊符号)
    - [上/下标：`super`/`sub`](#上下标supersub)
    - [含特殊意义的字符：`raw`](#含特殊意义的字符raw)
    - [其他特殊字符：`unicode`](#其他特殊字符unicode)
    - [使用unicode删除特殊字符](#使用unicode删除特殊字符)
  - [有用的系统选项](#有用的系统选项)
    - [修改变量名命名规则](#修改变量名命名规则)
    - [宏里面使用`in`语句的系统选项](#宏里面使用in语句的系统选项)
    - [解决footnote太长的warning](#解决footnote太长的warning)
  - [sas数据集/逻辑库/excel的交互](#sas数据集逻辑库excel的交互)
    - [sas数据集导出到excel](#sas数据集导出到excel)
      - [使用`ods excel`](#使用ods-excel)
      - [使用`ods` 导出带有template的excel](#使用ods-导出带有template的excel)
      - [使用`proc export`](#使用proc-export)
    - [excel导入为sas数据集](#excel导入为sas数据集)
      - [使用`proc import`](#使用proc-import)
  - [删除宏变量的额外空格](#删除宏变量的额外空格)
    - [方法：`separated by ''`](#方法separated-by-)
    - [方法：`trimmed`](#方法trimmed)
    - [方法：`%let`](#方法let)
  - [掩码宏函数](#掩码宏函数)
    - [`%str`与`%nrstr`](#str与nrstr)
    - [`%quote`和`%nrquote`](#quote和nrquote)
    - [`%bquote`和`%nrbquote`](#bquote和nrbquote)
    - [`%superq`](#superq)
    - [`%unquote`](#unquote)
    - [具有掩码作用的宏函数](#具有掩码作用的宏函数)
  - [`attrib`语句](#attrib语句)
  - [`length`语句](#length语句)
    - [使用说明](#使用说明)
    - [注意事项](#注意事项)
  - [`retain`语句](#retain语句)
    - [`retain`使用说明](#retain使用说明)
    - [`retain`注意事项](#retain注意事项)
    - [案例：使用`retain`前向填充缺失值](#案例使用retain前向填充缺失值)
    - [案例：使用`retain`给数据加序号](#案例使用retain给数据加序号)
    - [案例：`set`语句自动`retain`变量](#案例set语句自动retain变量)
  - [`set`语句](#set语句)
    - [`set`使用说明](#set使用说明)
    - [一个`set`语句中多个数据集](#一个set语句中多个数据集)
    - [多个`set`语句中一个数据集](#多个set语句中一个数据集)
    - [选项：`point=Variable`](#选项pointvariable)
    - [选项：`nobs=Variable`](#选项nobsvariable)
    - [选项：`end=Variable`](#选项endvariable)
  - [`merge`语句](#merge语句)
    - [没有`by`语句的`merge`](#没有by语句的merge)
    - [使用`by`语句的`merge`](#使用by语句的merge)
    - [多表查询](#多表查询)
      - [笛卡尔积：两个表所有可能的](#笛卡尔积两个表所有可能的)
      - [内联接：两个表共有的数据](#内联接两个表共有的数据)
      - [左连接：匹配后保留左表所有数据，左表顺序保持不变](#左连接匹配后保留左表所有数据左表顺序保持不变)
      - [左连接：只保留左表独有的数据](#左连接只保留左表独有的数据)
      - [右连接：匹配后保留右表所有数据，右表顺序保持不变](#右连接匹配后保留右表所有数据右表顺序保持不变)
      - [右连接：只保留右表独有的数据](#右连接只保留右表独有的数据)
      - [全连接：两个表的匹配数据及未匹配的数据](#全连接两个表的匹配数据及未匹配的数据)
      - [全连接：两个表各自的独有数据](#全连接两个表各自的独有数据)
  - [`array`语句](#array语句)
    - [`array`使用说明](#array使用说明)
    - [通过下标引用数组元素](#通过下标引用数组元素)
    - [使用`do`循环遍历数组元素](#使用do循环遍历数组元素)
    - [使用`of`运算符处理所有元素](#使用of运算符处理所有元素)
    - [`in`运算符访问数组元素的值](#in运算符访问数组元素的值)
    - [不同数组间的判断](#不同数组间的判断)
  - [`select-when`语句](#select-when语句)
    - [`select-when`使用说明](#select-when使用说明)
    - [案例: 简单的单变量判断](#案例-简单的单变量判断)
    - [案例: 使用`do-end`执行复杂语句组](#案例-使用do-end执行复杂语句组)
    - [案例: 在`when`中使用复合表达式](#案例-在when中使用复合表达式)
  - [`continue`与`leave`语句](#continue与leave语句)
    - [`continue`与`leave`使用说明](#continue与leave使用说明)
    - [案例：使用`continue`跳过当前循环](#案例使用continue跳过当前循环)
    - [案例：使用leave跳出整个循环](#案例使用leave跳出整个循环)
  - [`link`与`goto`语句](#link与goto语句)
    - [`link`与`goto`使用说明](#link与goto使用说明)
    - [案例：使用`goto`转到指定语句](#案例使用goto转到指定语句)
    - [案例：使用带return语句的`link`](#案例使用带return语句的link)
  - [`output`与`return`语句](#output与return语句)
    - [`output`与`return`使用说明](#output与return使用说明)
    - [案例：使用`return`停止后续语句](#案例使用return停止后续语句)
    - [案例：使用将不同的观测数据输出到同一行](#案例使用将不同的观测数据输出到同一行)
  - [`proc sort`过程](#proc-sort过程)
    - [`proc sort`使用说明](#proc-sort使用说明)
    - [只保留没有重复的观测](#只保留没有重复的观测)
    - [对数据集进行去重](#对数据集进行去重)
    - [获取数据集中重复的观测](#获取数据集中重复的观测)
    - [使用`key`语句对整体变量设置倒序](#使用key语句对整体变量设置倒序)
  - [`proc format`过程](#proc-format过程)
    - [`proc format`使用说明](#proc-format使用说明)
    - [设置format的范围值](#设置format的范围值)
    - [使用`(default=n)`选项处理format截断](#使用defaultn选项处理format截断)
    - [使用`(fuzz=.n)`选项设置模糊format](#使用fuzzn选项设置模糊format)
    - [定义`picure`的数值模板](#定义picure的数值模板)
    - [对`picture`数值模板保留小数](#对picture数值模板保留小数)
    - [定义描述统计的输出模板](#定义描述统计的输出模板)
    - [`picuture`进行`round`的Bug处理](#picuture进行round的bug处理)
    - [`format`与数据集的传输](#format与数据集的传输)
      - [数据集转为`format`](#数据集转为format)
      - [`format`转为数据集](#format转为数据集)
        - [常规`format`转为数据集](#常规format转为数据集)
        - [带有端点值和无限范围的`format`转为数据集](#带有端点值和无限范围的format转为数据集)
  - [`proc report`过程](#proc-report过程)
    - [基本语句](#基本语句)
    - [`ods`语句相关说明](#ods语句相关说明)
    - [过程步options](#过程步options)
    - [`column`语句](#column语句)
      - [基本原则](#基本原则)
      - [多层表头](#多层表头)
    - [`where`语句](#where语句)
    - [`define`语句](#define语句)
    - [`by`语句](#by语句)
    - [`#byvar`的使用](#byvar的使用)
    - [`break`与`rbreak`语句](#break与rbreak语句)
    - [`compute`语句](#compute语句)
      - [`line`语句](#line语句)
      - [`call define`语句](#call-define语句)
    - [footnote显示在第一页](#footnote显示在第一页)

<!-- /code_chunk_output -->

## 数据集选项执行顺序

### 选项执行顺序

- data步语句：
  - `where`语句→其他执行语句→`keep`/`drop`语句→`rename`语句
- 数据集选项：
  - `keep`/`drop`选项→`rename`选项→`where`选项

### 常见数据集选项

| 选项             | 可用值                  | 作用                                 |
| -------------- | -------------------- | ---------------------------------- |
| `read=`      | 字符串                  | 设置读取数据集的秘密                         |
| `write=`     | 字符串                  | 设置改写数据集的秘密                         |
| `alter=`     | 字符串                  | 设置替换和删除数据集的秘密                      |
| `pw=`        | 字符串                  | 设置`read`，`write`，`alter`的密码  |
| `compress=`  | `YES`\|`NO`      | 是否压缩数据集                            |
| `encrypt=`   | `YES`\|`NO`      | 是否加密数据集                            |
| `label=`     | 字符串                  | 指定数据集标签                            |
| `replace=`   | `YES`\|`NO`      | 是否允许被替代                            |
| `repempty=`  | `YES`\|`NO`      | 指定新的空数据集是否可以覆盖同名非空数据集              |
| `firstobs=`  | 数值                   | 指定第一条观测                            |
| `obs=`       | 数值                   | 指定最后一条观测                           |
| `where=`     | 逻辑判断                 | 指定数据筛选条件                           |
| `in=`        | 新变量                  | 创建一个逻辑变量用来标识观测的来源                  |
| `drop=`      | 变量组                  | 排除指定变量                             |
| `keep=`      | 变量组                  | 保留指定变量                             |
| `rename=`    | `oldname=newname`  | 变量重命名                              |

## SAS EG设置自动查log的方法

1. 打开SAS EG的`tools`中的`options`
2. 选中`SAS Programs`中的Additional SAS Code，并勾选上下面两个选项：
   > Insert custom SAS code before submitted code
   > Insert custom SAS code after submitted code
3. 在`before`选项的`edit`中插入如下代码：

   ```sas
   %macro egautoexec;
       %if "&_SASPROGRAMFILE." ne "" %then %do;
           %let egfileref=%SYSFUNC(REVERSE(sas.cexeotua%SUBSTR( %SYSFUNC(COMPRESS(%SYSFUNC(TRANSLATE(%QUOTE(%SYSFUNC(REVERSE(&_sasprogramfile.))),'-',',')),'"')),%EVAL(%INDEX(%SYSFUNC(REVERSE(&_sasprogramfile.)),/)-1))));
           %if %sysfunc(fileexist(&egfileref.)) %then %do;
               %if %symexist(_project) %then %do;
                   %if &_project ne %scan(&_sasprogramfile.,3,"/") %then %do;
                       %INC "&egfileref.";
                   %end;
               %end;
               %else %INC "&egfileref.";
           %end;

           %else %put NOTE:[PXL] The file &egfileref. does not exist.;
           %end;

           %else %do;
               %put NOTE:[PXL] SAS code is not saved on the server. Study autoexec has not been executed.;
       %end;
   %mend egautoexec;
   %egautoexec;

   filename LogFile temp;
   Proc printto log=LogFile new;
   run;

   ```

4. 在`after`选项的`edit`中插入如下代码：

   ```sas
   %macro egcheck(notechk=);
       proc printto log=log;
       run;
       data _null_;
           infile logfile truncover lrecl=30000;
           input;
           length content $30000;
           content=_infile_;
           /* Change ERROR \d-\d to ERROR: */
           content = prxchange('s/ERROR( +\d+-\d+: +)/ERROR:\1/o', 1,content);
           /* Replace special notes with warning */
           pattern = prxparse("/(?<=^(NOTE:|INFO:)) .*\b(&notechk)\b/i");
           if prxmatch(pattern, content) and ^index(content,"VARCHAR data type is not supported by the V9 engine.") and ^index(content,"Run the study autoexec or assign _PROJECT macro variable") then do;
               content = prxchange('s/^(NOTE:|INFO:) /WARNING: /', 1, strip(content));
           end;
           /* output the log */
           len=length(content);
           putlog content $varying200. len;
       run;
   %mend egcheck;

   %egcheck(notechk=converted|uninitialized|invalid|truncation|missing values|Invalid|overwritten|MERGE statement has more than one)

   %let GMPXLERR=0;

   ```

5. 保存退出即可。

## 处理特殊字符与输出特殊符号

### 上/下标：`super`/`sub`

直接在字符串中替换使用`(ESC){super XXXXX}`,`(ESC){sub XXXXX}`即可：

```sas
data rep1;
    item = "S01001^{super *}";
    col1 = 2.528;
    col2 = 163.725;
run;

ods escapechar="^";
proc report data=rep1 nowindows headline headskip spacing=0;
    column item col1-col2;
    define item / display flow " 受试者";
    define col1 / display flow " T^{sub max}";
    define col2 / display flow " C^{sub max}" ;
run;
```

### 含特殊意义的字符：`raw`

`%`、`&`、`^(转义字符)`等在SAS中有其特定的含义，直接显示在字符串中会出现异常。  可以使用`(ESC){raw XXXXX}`的语法。

```sas
ods escapechar="^";
%let n1=10;
%let n2=8;

data rep1;
    item = "S01001";
    col1 = 0.81;
    col2 = 0.72;
run;

proc report data=rep1 nowindows headline headskip spacing=0;
    column item col1-col2;
    define item / display flow " 受试者";
    define col1 / display flow " 受试制剂（0.05^{raw %}剂量） N=&n1";
    define col2 / display flow " 受试制剂（0.15^{raw %}剂量） N=&n2";
run;
```

### 其他特殊字符：`unicode`

在其他语法中可能使用`\u`前缀，在SAS中是用`(ESC){unicode XXXXX}`为前缀。

unicode速查：[Unicode - Compart](https://www.compart.com/en/unicode/ "Unicode - Compart")。常用的unicode编码：

| 符号                    | Unicode  |
| --------------------- | -------- |
| ≤                     | U+2264   |
| ≥                     | U+2265   |
| 换行符（Carriage Return）  | U+0D     |
| 软回车符（End of Line）     | U+0A     |
| Form Feed             | U+0C     |
| 制表符（Tab）              | U+09     |

```sas
ods escapechar="^";
data rep1;
    /* 添加一个 &（unicode 十六进制=26）*/
    item="S01001^{unicode 26}S01002";
    col1 = 2.528;
    col2 = 163.725;
run;

proc report data=rep1 nowindows headline headskip spacing=0;
    column item col1-col2;
    define item / display flow " 受试者";
    /* 可以嵌套使用：字母a（unicode 十六进制=61）*/
    define col1 / display flow " T^{sub m^{unicode 61}x}";
    define col2 / display flow " C^{sub max}" ;
run;

```

### 使用unicode删除特殊字符

有时在导入外部数据文件时，可能在字符串中存在一些“不可见”的字符，比如换行符、制表符tab、软回车等等。可以使用unicode来删除：`compress(str,'0a'x)`

```sas
data rep1;
    length type str $200;

    type = "无特殊字符";
    str  = "我是一名程序员";
    klength=klength(str);
    output;

    type = "包含特殊字符";
    /* 换行符的unicode，十进制=10，十六进制=0a */
    str  = "我是一名程序员"||byte(10);
    klength=klength(str);
    output;

    type = "删除特殊字符";
    /* 换行符的unicode，十进制=10，十六进制=0a */
    str  = compress(str,'0a'x);
    klength=klength(str);
    output;
run;

/*
|type|str|klength|
|-|-|-|
|无特殊字符|我是一名程序员|7|
|包含特殊字符|我是一名程序员|8|
|删除特殊字符|我是一名程序员|7|
*/
```

## 有用的系统选项

### 修改变量名命名规则

```sas
options validvarname=v7|any|upcase;
```

- 默认为`v7`：系统使用一般意义下的命名规则：下划线跟英文字母开头，英文字母、数字、下划线组成，且总长度不超过32个英文字符长度。
- `any`：表示可以使用特殊字符命名，包括中文命名。
- `upcase`：表示所有数据集中最终变量都采用大写。

### 宏里面使用`in`语句的系统选项

```sas
options minoperator=',';
```

- 控制宏处理器是否识别和计算`IN`(`#`)逻辑运算符（在宏语言中`#`就代表`in`）。
- 需要注意列表需要以空格分隔，不能以逗号分隔，但是在DATA步中两种都可以。
- 但是我们自己可以指定分隔符，通过`options mindelimiter=',';`。如果需要恢复空格，直接`options mindelimiter='';`就可以了。

### 解决footnote太长的warning

```sas
options noquotelenmax;
```

- 这个选项可以规避因为footnote太长导致的log issue：
  > NOTE: The quoted string currently being processed has become more than 262 bytes long. You might have unbalanced quotation marks.

## sas数据集/逻辑库/excel的交互

### sas数据集导出到excel

#### 使用`ods excel`

```sas
ods listing close;
ods excel file="./DS Compliance New Listing.xlsx"
    options(sheet_name="Listing" frozen_headers="Yes" autofilter="Yes");
    proc report data=qc_dem.l_adex_ae_sv001;
        column col:;
    run;
ods excel close;

```

#### 使用`ods` 导出带有template的excel

```sas
/* output for EXCEL */
ods listing close;
ods tagsets.excelxp
    file="&_odsur.&TFLNAME..xls"
    style=global.rtf
    options(EMBEDDED_TITLES       = "yes"
            EMBEDDED_FOOTNOTES    = "yes"
            EMBED_TITLES_ONCE     = "yes"
            AUTOFIT_HEIGHT        = "yes"
            ORIENTATION           = "landscape"
            FROZEN_HEADERS        = "4"
            CENTER_HORIZONTAL     = "yes"
            AUTOFILTER            = "all");
ods tagsets.ExcelXP options(sheet_name="&TFLNAME." ABSOLUTE_COLUMN_WIDTH ="20.");
ods escapechar="~";
%loadtf_dsur(tabout=&TFLNAME., prg=&PGMNAME., filetype=excel);

proc print data=dsur.&TFLNAME. label noobs;
        var  COL:  /  style (data)={tagattr='format:@'};
run;
ods tagsets.excelxp close;
ods listing;

```

注意：

- %loadtf\_dsur为footnote相关的宏。
- 需要修改header中的页码，不需要显示。
- 导出的excel文件中会携带换行符，如果不需要对records进行换行需要额外处理。
- 如果需要导出BYVAR需要检查是否设置label。

#### 使用`proc export`

### excel导入为sas数据集

#### 使用`proc import`

## 删除宏变量的额外空格

如果在sas中直接使用`proc sql into`语法生成的宏变量值，当输出的output中可能会遇到额外的空格。有以下几种解决方法。

### 方法：`separated by ''`

```sas
proc sql;
    select count(name) into : pop separated by "" from sashelp.class;
quit;
```

### 方法：`trimmed`

```sas
proc sql;
    select count(name) into : pop trimmed from sashelp.class;
quit;

```

### 方法：`%let`

```sas
proc sql;
    select count(name) into : pop from sashelp.class;
quit;
%LET pop=&pop.;
```

## 掩码宏函数

Macro Quoting就是将具有特殊功能字符及字母组合的特殊功能隐藏掉。例如：让分号（`;`）不再表示一个语句的结束，而就是一个普普通通的字符；让`GE`不再表示大于等于的比较符，而就是两个普普通通的字母。

### `%str`与`%nrstr`

这两个函数都用来隐藏下面这些字符的特殊作用。如果在文本中出现不匹配的单引号、双引号、或者括号，则需要在其前面加一个`%`用来标注该符号是不匹配的字符。`%`的意义类似于其他语言中的转义字符：斜杠（`\`）

| +   | -  | \*  | /  | <  | >  | =     |
| --- | -- | --- | -- | -- | -- | ----- |
| ﹁   | ^  | \~  | ;  | ,  | #  | blank |
| AND | OR | NOT | EQ | NE | LE | LT    |
| GE  | GT | IN  | '  | '' | (  | )     |

> `%nr`前缀的掩码函数还能隐藏`%`和`&`两个Macro Trigger的功能，使其跟普通字符一样。NR为Not Resolved的简写，即不解析宏变量和宏程序（有NR的掩码函数都是此意义）

```sas
data test;
x = "xxx%";
y = "xxx(%)";
z = "zzz(&)";
z2 = %str("zzz(%)");
z3 = %nrstr("zzz(%S)");
run;

/*
| x | y | z | z2 | z3 |
| - | - | - | - | - |
| xxx% | xxx(%) | xx(&) | xxx() | xxx(%S) |
*/
```

### `%quote`和`%nrquote`

`%str`（包括`%nrstr`）只在程序编译的阶段起作用；在程序执行阶段是不起作用的。而`%quote`函数（相对应的还有`%nrquote`），是在程序执行阶段生效的。

`%quote`与`%nrquote`两个函数的功能与`%str`和`%nrstr`两个函数的功能是一样的，只不过前两者是在程序执行阶段生效，而后两者是在程序编译阶段生效。

### `%bquote`和`%nrbquote`

`%bquote`与`%quote`，`%nrbquote`与`%``nrquote`的生效阶段是一样的，都是在程序执行阶段生效。但是`%bquote`和`%nrbquote`，在`%bquote`与`%quote`的基础上多了一个功能，即对于不匹配的引号或括号不需要使用多增加一个`%`（无论是`%str`、`%nrstr`、`%quote`、`%nrquote`如果有不匹配的引号，则必须要在不匹配的引号前添加`%`。`%`类似于转义字符的功能）

建议：一般情况下，都会使用`%``bquote`和`%``nrbquote`，基本不使用`%``quote`和`%``nrquote`

### `%superq`

`%``superq`宏函数比较特殊，其参数必须是宏变量的名字，而且不用`&`符号。该函数可以隐藏`%``nrbquote`函数可隐藏的特殊字符及字母组合。

但`%``nrbquote`如果参数为宏变量的引用，会在隐藏特殊字符功能前，先尝试解析其宏变量值中的宏引用或者宏变量的引用；而`%``superq`函数则不会解析其参数宏变量值中的宏引用或者宏变量的引用

### `%unquote`

`%``unquote`顾名思义，就是将之前隐藏掉的功能重新激活，去除Quoting的作用

### 具有掩码作用的宏函数

具有Quoting功能的函数：`%qsacn`、`%qsubstr`、`%qsysfunc`、`%qupcase`。这些具有Quoting功能的函数，能够隐藏返回结果中的特殊字符的功能。

| +   | -  | \*  | /  | <  | >  | =     | & |
| --- | -- | --- | -- | -- | -- | ----- | - |
| ﹁   | ^  | \~  | ;  | ,  | #  | blank | % |
| AND | OR | NOT | EQ | NE | LE | LT    |   |
| GE  | GT | IN  | '  | '' | (  | )     |   |

## `attrib`语句

1. 利用`attrib`删去所有`label`

   ```c-like
   data want;
       set have;
       attrib _all_ label="";
   run;

   ```

2. 设置多个变量的多个属性

   ```sas
   attrib x y length=$4 label='TEST VARIABLE';
   attrib x length=$4 label='TEST VARIABLE' y length=$2 label='RESPONSE';
   attrib month1-month12 label='MONTHLY SALES';
   ```

## `length`语句

### 使用说明

- 指定变量的长度（储存长度，而不一定等于我们看到的长度）。
- 数值变量的长度默认为8个字符；
- 字符变量的长度默认由它的第一个观测值决定；
- 字符型变量需要在长度前面加上`$`符号。

### 注意事项

1. `length`语句应该使用在data步的第一句。否则可能出现这样的warning。
   > WARNING: Length of character variable x1 has already been set.
   > Use the LENGTH statement as the very first statement in the DATA STEP to declare the length of a character variable.
2. 变量会按照`length`语句中的顺序展示，并默认放在数据集最前面。
3. 可以同时对多个变量指定同一个长度。多个变量都默认为后面第一个指定的类型长度。
4. `length`为申明语句，所以其中的变量必须要使用在后续的执行语句中。否则会出现这样的log issue：
   > NOTE: Variable x1 is uninitialized.

## `retain`语句

### `retain`使用说明

- 不使用`retain`：在每次循环执行时会把PDV中的变量值清空，即置为缺失值（`.`）。
- 使用`retain`：在每次循环执行时保留上一次PDV中的变量值。
- `sum`语句和`set`语句会自动`retain`变量。

### `retain`注意事项

- 在DATA步刚开始执行的时候：
  - 自动生成变量会被附上初始值：`_n_=1`、 `_error_=0`、`first.var=1`、 `last.var=1`等；
  - 如果`retain`语句对某变量设置了的初始值，则对应的变量被设为指定的值；
  - `sum`语句的变量会被初始化为0；
  - 其他的变量(`新建变量`和`set的数据集`)都会被设为缺失值。
- SAS执行过程中再次回到DATA语句时：
  - 自动生成变量的值会被保留；
  - 来自`retain`语句、`sum`语句、或数据集中的变量值会被保留；
  - 其他的变量会被设为缺失值（`.`）。

### 案例：使用`retain`前向填充缺失值

```sas
/* 用该缺失值的前一个非缺失值来填补该缺失值 */
data ex1;
    retain old_x;
    input x @@;
    if x ne . THEN old_x = x;
    else x = old_x;
    cards;
    1 2 . 3
;

/*
old_x    x
    1    1
    2    2
    2    2
    3    3
*/
```

### 案例：使用`retain`给数据加序号

```sas
/* 使用retain语句 */
data ex2;
    retain subject 0;
    input x @@;
    subject = subject + 1;
    datalines;
    1 3 5
;

/* 利用sum语句简化 */
data ex2;
    input x @@;
    subject + 1;
    datalines;
    1 3 5
;

/* 利用PDV中自动变量_n_进一步简化 */
data ex2;
    input x @@;
    n = _n_;
    datalines;
    1 3 5
;

```

### 案例：`set`语句自动`retain`变量

```sas
data one;
    input x y;
    datalines;
    1 2
;

data two;
    if _n_ = 1 then set one;
    input new;
    datalines;
    3
    4
    5
;

/*
x   y    new
1   2    3
1   2    4
1   2    5
*/
```

## `set`语句

### `set`使用说明

- 一个DATA步中可以有多个`set`语句，一个`set`语句中可以有任意个SAS数据集。
- 每一个`set`语句执行时，SAS就会读一个观测到PDV中，多个`set`语句含有多个数据指针。
- `set`语句默认会对数据集中的变量进行`retain`处理。

### 一个`set`语句中多个数据集

- 其执行顺序为：先读取`data1`直至最后一条数据，然后后再读取`data2`，并将其纵向合并。
- 变量类型按照第一个数据集中的变量格式来定义所有变量；

```sas
data ex1;
    set data1 data2;
run;
/*
x   y
a1  .
a2  .
a3  .
.   b1
.   b2
*/
```

### 多个`set`语句中一个数据集

- 读取的观测是以少的观测的数据集为主。
- 编译后内存出现两条数据指针分别指向`data1`，`data2`，同时产生一个PDV；
- 同时读取`data1`的第一条观测与`data2`的第一条观测进入同一条PDV，然后输出，再返回DATA步开头。
- 重复进行，当读入`data1`的第三行时，`data2`中的指针已经指向了文件尾部，所以跳出DATA步。

```sas
data data1;
  input x;
  cards;
  a1
  a2
  a3
run;
data data2;
  input y;
  cards;
  b1
  b2
run;
data ex2;
    set data1;
    set data2;
run;
/*
x  y
a1 b1
a2 b2
*/
```

### 选项：`point=Variable`

- 规定一个临时变量控制`set`语句读入的观测序号，使用选项`point=`时，经常要用`stop`语句来终止data步的执行
- `Point=Variable`对应的是变量，不能直接赋值数字；省略`stop`后会让程序进入死循环，不用`stop`语句sas无法判断该数据指针是否指向了最后一条观测，从而会陷入死循环。如果不用`output`，会得不到数据集，`point`和`stop`一般是连在一起使用；

```sas
/* 利用Point=选项读取指定观测 */
data a;
  set account ;
  obs=_n_;

data b;
  do i=3,5,7,4;
    set a point=i; /*读入数据集a中的第3,5,7,4观测*/
    if _error_=1 then abort;
    output;
  end;
  stop;
run;

```

### 选项：`nobs=Variable`

- 规定一个临时变量，记录读入数据集的观测总数。此变量不含在新产生的数据集中；

```sas
/* 利用NOBS=选项获取观测总数 */
data acc;
  set account ;
  obs=_n_;

data a;
  do i=1 to last by 2; /*临时变量为last */
    set acc point=i nobs=last;
    output;
  end;
  stop;
run;

```

### 选项：`end=Variable`

- 规定一个临时变量，作为文件结束的标识。文件结束时取值1，其它观测取0。

```sas
/* 利用END=选项获取最后一个观测 */
data acc;
  set account ;
  obs=_n_;

data a;
  set acc end=last_obs;
  if last_obs=1;
run;

```

## `merge`语句

### 没有`by`语句的`merge`

- 对应行数的观测依次进行合并（不是笛卡儿积）。
- 若数据集中存在相同变量，则用后面数据集中变量的值覆盖前面数据集中变量的值。

```sas
data one;
  input no a b;
  cards;
  1  1  11
  2  2  22
  3  3  33
  ;
run;
data two;
  input no c d;
  cards;
  4  44  444
  5  55  555
  ;
run;
data total;
  merge one two;
run;

/*
no a b c d
4  1  11  44  555
5  2  22  55  555
3  3  33   .  .
*/
```

### 使用`by`语句的`merge`

- 按照`by`变量的取值进行匹配合并，只有当`by`变量的值相同时才合并。
- 有相同变量时，后面的值会覆盖前面的值，并报出一个`warning`。

```sas
data one;
  input no a b;
  cards;
  1  1  11
  2  2  22
  3  3  33
  ;
run;
data two;
  input no c d;
  cards;
  4  44  444
  5  55  555
  ;
run;
proc sort data=one;by no;
proc sort data=two;by no;
data total;
  merge one two;
  by no;
run;

/*
no a b c d
4  1  11  .   .
5  2  22  44  444
3  3  33   .  .
5  .  .   55  555
*/
```

### 多表查询

#### 笛卡尔积：两个表所有可能的

```sas
data table2;
   set t1;
   do i=1 to n;
      set table1 point=i nobs=n;
      output;
   end;
run;

proc sort data=table2;
   by usubjid;
run;
```

#### 内联接：两个表共有的数据

```sas
/* data merge */
proc sort data=tablea;  by id;
proc sort data=tableb;  by id;
data tablef;
  merge tablea(in=a) tableb(in=b);
  by id;
  if a and b;
run;

```

#### 左连接：匹配后保留左表所有数据，左表顺序保持不变

```sas
/* data merge */
proc sort data=tableA;  by id;
proc sort data=tableB;  by id;
data tableF;
  merge tablea(in=a) tableb;
  by id;
  if a;
run;

```

#### 左连接：只保留左表独有的数据

```sas
/* data merge */
proc sort data=tablea;  by id;
proc sort data=tableb;  by id;
data tablef;
  merge tablea(in=a) tableb(in=b);
  by id;
  if a and not b;
run;

```

#### 右连接：匹配后保留右表所有数据，右表顺序保持不变

```sas
/* data merge */
proc sort data=tablea;  by id;
proc sort data=tableb;  by id;
data tablef;
  merge tablea tableB(in=b);
  by id;
  if b;
run;

```

#### 右连接：只保留右表独有的数据

```sas
/* data merge */
proc sort data=tablea;  by id;
proc sort data=tableb;  by id;
data tablef;
  merge tablea(in=a) tableb(in=b);
  by id;
  if not a and b;
run;

```

#### 全连接：两个表的匹配数据及未匹配的数据

```sas
/* data merge */
proc sort data=tablea;  by id;
proc sort data=tableb;  by id;
data tablef;
  merge tablea tableb;
  by id;
run;

```

#### 全连接：两个表各自的独有数据

```sas
/* data merge */
proc sort data=tablea;  by id;
proc sort data=tableb;  by id;
data tablef;
  merge tablea(in=a) tableb(b);
  by id;
  if not a or not b;
run;

```

## `array`语句

### `array`使用说明

```sas
ARRAY  数组名{下标}  <$><长度>  <<数组元素> <(初始值)>>;

```

1. `数组名{下标}`：下标表示元素的个数和排列的范围，下标括号建议使用`{}`，有以下几种指定方式。
   - 显示下标：给定一个数字，下标数字应该等于变量元素个数。
   - 隐式下标：在声明数组时没有给出下标值，使用一个新变量替代。
   - `*`：使用`*`会自动定义为元素个数。
2. `<$><长度>`：定义数组元素中新变量的长度。`<$>`定义为字符数组（适用于数组元素为新变量情形）。
3. `<数组元素>`：有以下几种指定方式。
   - 数据集中的类型相同的若干个变量名。
   - `_character_`：定义为数据集中所有字符型变量的数组。
   - `_numeric_`：定义为数据集中所有数值型型变量的数组。
   - `_temporary_`：定义为临时数组，它的元素是具体的数值或字符串。引用时必须用数组名和下标，且不能用`*`下标来引用所有元素；
   - 如果不指定则为缺失值的数值/字符型(`$`)数组。
4. `<(初始值)>`：数组元素的初始值，数组元素和初值通过对应位置来确定。

```sas
data arrya;
    set test;
    array ary_1 (2) name sex;         /*数组ary_1中包含name sex两个元素*/
    array ary_2 (3) age height weight;/*数组ary_2中包含age height weight三个元素*/
    array ary_3 (2) _character_ ;     /*数组ary_3元素为class中所有字符型变量*/
    array ary_4 (3) _numeric_ ;       /*数组ary_4元素为class中所有数值型变量*/
    array ary_5 (3) $;                /*数组ary_5元素三个为缺失值的字符型变量*/
    array ary_6 (3) ;                 /*数组ary_6元素三个为缺失值的数值型变量*/

    array x{3} red greeny ellow;      /* 定义一维 */
    array x{5,3} scorel-score15;      /* 定义二维: 15个变量按顺序从左上角开始逐行放入这个二维数组 */
    array x{1:5,1:3} scorel-score15;  /* 定义二维（另一种定义方式）: 当用1作为数组下界时可以省略 */

    array t{3} (5,10,15);              /* 会产生新变量t1,t2,t3; */
    array t{3} _temporary_ (5,10,15);  /* 若用临时数组，则不会产生新变量 */

    /* 隐式下标定义方式 */
    array testa{i} $ 12 x1-x10;

    /* 数组元素的个数与初值的个数相同，把初值90,80和70依次赋给变量t1，t1和t3。*/
    array testb{3} t1 t2 t3 (90 80 70);

    /* 分配5给ab1，4给ab2，3给ab3，因数组元素比给出的初始值多，多余的变量ab4和ab5为缺失值，SAS系统将发布一条警告信息。 */
    array ab{5} (5 4 3);
run;
```

### 通过下标引用数组元素

```sas
data new;
  input x1-x5;
  array test{5} x1-x5;
  put test{4}= test{2}=;
  cards;
  1 2 3 4 5
;
/* 输出x4和x2的值，即数组元素test(4)引用x4,数组元素test(2)引用x2. */
```

### 使用`do`循环遍历数组元素

- 方法1：使用`do over`

  ```sas
   array _num _numeric_;
   do over _num;
      _num=_num*100;
   end;

  ```

- 方法2：使用`dim`函数

  ```sas
  /* dim函数得到数组中元素的个数 */
  array day{*} d1-d4;
  do i=1 to dim(day);
    day{i} = day{i} + 10;
  end;

  ```

- 方法3：指定范围

  ```sas
  /* day(i)则只引用数组中选定的特殊元素 */
  array day{7} d1-d7;
  do i=2 to 4;
  do i=1 to 7 by 2;
  do i=1,3;

  ```

### 使用`of`运算符处理所有元素

```sas
data array_example_of;
    input a1 a2 a3 a4;
    array a(4) a1-a4;
    a_sum=sum(of a(*));
    a_mean=mean(of a(*));
    a_min=min(of a(*));
    datalines;
    21 4 52 11
    96 25 42 6
    ;
run;

```

### `in`运算符访问数组元素的值

可以使用`in`运算符访问数组中的值，该运算符检查数组行中是否存在值。

```sas
data array_in_example;
    input a1 $ a2 $ a3 $ a4 $;
    array colours(4) a1-a4;
    if 'yellow' in colours then available='yes';
    else available='no';
    datalines;
    orange pink violet yellow
    ;
run;

```

### 不同数组间的判断

```sas
/* 用临时数组保存5科考试的及格分数，读取学生成绩，然后与这些及格分数进行比较，统计学生的及格科目数。*/
data passing;
     array Pass[5] _TEMPORARY_ (65 70 65 80 75);
     array Score[5];
     input ID $ Score[*];
     Pass_Num = 0;
     do i=1 to 5;
        if Score[i] >= Pass[i] then Pass_Num + 1;
     end;
     drop i;
    datalines;
    001 64 69 68 82 74
    002 80 80 80 60 80
    ;
run;
```

## `select-when`语句

### `select-when`使用说明

- 当一个特殊条件为真时，执行对应`when`语句，如果所有`when`条件均不成立，选择执行`otherwise`语句，用`end`结束。
- 知道明确的离散选择项时使用，允许SAS去执行几个语句或者语句组中的一个。

### 案例: 简单的单变量判断

```sas
select (a);
   when (1) x=x*10;
   when (2);
   when (3,4,5) x=x*100;
   otherwise;
end;
```

### 案例: 使用`do-end`执行复杂语句组

```sas
select (payclass);
   when ('monthly') amt=salary;
   when ('hourly')
      do;
         amt=hrlywage*min(hrs,40);
         if hrs>40 then put 'CHECK TIMECARD';
      end;         /* end of do     */
   otherwise put 'PROBLEM OBSERVATION';
end;               /* end of select */
```

### 案例: 在`when`中使用复合表达式

```sas
select;
   when (mon in ('JUN', 'JUL', 'AUG') and temp>70) put 'SUMMER ' mon=;
   when (mon in ('MAR', 'APR', 'MAY')) put 'SPRING ' mon=;
   otherwise put 'FALL OR WINTER ' mon=;
end;
```

## `continue`与`leave`语句

### `continue`与`leave`使用说明

- `continue`语句：停止当前这次循环过程，并继续进行下一次循环过程。
- `Leave`语句：停止当前整个`do`组循环或`select`组的处理过程，并用跟在`do`组或`select`组后面的下一个语句继续执行data步。

### 案例：使用`continue`跳过当前循环

```sas
data zzz;
    drop i;
    do i=1 to 5;
        input name $ idno  status $;
        if  status='PT' then continue ;
        input benefits $10.;
        output;
    end;
    cards;
Jones     9011   PT
Thomas    876    PT
Richards  1002   FT
Eye/Dental
Kelly     85111  PT
Smith     433    FT
HMO
;
/*
i  name    idno  status  benefits
3 Richards 1002    FT    Eye/Dental
5 Smith     433    FT    HMO
*/

```

### 案例：使用leave跳出整个循环

```sas
data week;
    input name $ idno  start;
    bonus=0;
    /* from start to year add 50 every year */
    do year=start to 1991;
        if bonus ge 500 then leave;
        /* 如果在do循环里是类似累加，循环进行到exit+1 */
        bonus+50;
    end;
    cards;
    Jones     9011  1990
    Thomas    876   1976
    Barnes    7899  1991
    Harrell   1250  1975
    Richards  1002  1990
    Kelly     85    1981
    Stone     091   1990
;

/*
name      idno  start  bonus  year
Jones     9011  1990    100   1992
Thomas    876   1976    500   1986
Barnes    7899  1991     50   1992
Harrell   1250  1975    500   1985
Richards  1002  1990    100   1992
Kelly     85    1981    500   1991
Stone     091   1990    100   1992
*/
```

## `link`与`goto`语句

### `link`与`goto`使用说明

- `goto label`语句：
  - 立即转到所指示的语句，并从那个语句开始执行后面的语句。
  - `label`规定语句标号来指示`goto`的目标。
- `link label`语句：
  - 立即转到由`label`语句指示的位置，并从那里开始继续执行语句。
  - 标签内的`return`语句让SAS立即返回到`link`语句后面的那个语句并从那里继续执行。

### 案例：使用`goto`转到指定语句

```SAS
data info;
    input x @@;
    file print;
    if 1 <= x <= 5 then goto ok;
    /* 不属于if的执行 */
    put x;
    /* 不属于if的执行 */
    count + 1;
    /* 这句一直要执行 */
    ok: y + x;
    cards;
    7 2 16 5 323 1 11
    ;
run;
/*
x   count  y
7    1     7
2    1     9
16   2    25
5    2    30
323  3   353
1    3   354
11   4   365

put:
7
16
323
11
*/

```

### 案例：使用带return语句的`link`

```sas
data demo;
    input type $ wd station $ ;
        elev=.;
        if type='ALUV' then link calcu;

        year=1985;
        return; /* 返回到data步开头 */

        calcu:
        if station='SITE_1' then elev=6650-wd;
        if station='SITE_2' then elev=5500-wd;
        return; /* 返回到link语句的下面 */

    cards;
    ALUV  523  SITE_1
    UPPA  234  SITE_2
    ALUY  666   SITE_2
    ;
run;
/*
type  wd  station  elev   year
ALUV  523  SITE_1  6127  1985
UPPA  234  SITE_2     .  1985
ALUY  666  SITE_2     .  1985
*/
```

## `output`与`return`语句

### `output`与`return`使用说明

- data步的隐式输出：
  - 每个data步最后都执行一个隐式的输出语句将PDV中的数据写入数据集。
- data步的显示输出：
  - `output`语句：将当前观测值写入正在建立的数据集中，继续执行后续语句，但整个data步隐式循环不再执行最后的隐式输出，只会清空PDV的变量为缺失。
  - `return`语句：不执行后续的语句，输出当前PDV观测，然后返回到data步开头继续进行下一轮data步循环。

### 案例：使用`return`停止后续语句

```sas
/* return 不再执行后续语句，但下一轮data步循环会执行隐式输出 */
data survey1;
   input x y z;
   if x=y then return;
   x=y+z ;
   a=x**2;
   cards;
   1  1   3
   2  3   3
;
run;
/*
x  y  z  a
1  1  3  .
6  3  3 36
*/

/* output会继续执行后续语句，整个data步隐式循环不在执行隐式输出 */
data survey2;
   input x y z;
   if x=y then output;
   x=y+z ;
   a=x**2;
   cards;
   1  1   3
   2  3   3
;
run;
/*
x  y  z  a
1  1  3  .
*/

```

### 案例：使用将不同的观测数据输出到同一行

```sas
data a;
    input x y@@;
    cards;
    1  10
    1  20
    1  200
    2  30
    2  40
    3  50
    3  60
    3  80
    4  70
    4  400
    ;
run;

proc sort data=a; by x; run;
data res;
    set a;
    by x;
    /* 如不用retain，下面的put能输出正确的值，但是运行到run后会自动清空，这样output的结果集中rt都会为缺失值 */
    retain rt;
    if first.x then rt=0;
    if last.x then output;
    rt = y;
    put rt=;
run;
/*
x    y  rt
1  200  20
2   40  30
3   80  60
4  400  70
*/
```

## `proc sort`过程

### `proc sort`使用说明

- `descending`表示该选项之后的一个变量按降序对记录排序；若省略引选项，则按默认升序对记录排序。
- 可在过程不中添加其他通用语句(`where`)。
- 如果原数据集已经排序，则不会重复执行 `proc sort`操作。
- 数据集比较大的时候该条语句排序剔重比用 `distinct`更快。
- 其他DATA步或PROC步只用了`by`语句，则必须提前进行排序。

### 只保留没有重复的观测

- `uniqueout=`：输出关于by变量的观测数据唯一的部分，即没有重复的数据。

### 对数据集进行去重

- `nodupkey`：删除重复的`by`变量记录。
- `noduprecs/nodup`：发生在排序后，所有变量进行比对，将完全相同的记录删除。
- `dupout=`：指定一个去重后的数据集。

```sas
proc sort data=sashelp.class out=res1 nodupkey;
    by sex;
run;
proc sort data=sashelp.class out=res2 nodup;
    by sex;
run;
```

### 获取数据集中重复的观测

- `nouniquekey`：保留对于`by`变量有多条观测的数据。

### 使用`key`语句对整体变量设置倒序

- 在语法上`key`和`by`是互相替代的语句。

```SAS
/* by语句必须逐个变量指定倒序，key语句可以整体统一设置 */
proc sort data=sortVar out=sortedOutput;
    key x1 x2 / descending;
run;

/* key语句可以设定正序, by语句不可 */
proc sort data=sortVar out=sortedOutput;
    key x1 / ascending;
run;

/* key可以多重使用，排序是按照key出现的顺序排变量的 */
proc sort data=sortKeys out=sortedOutput;
    key x2;
    key x3;
run;

/* 无论是by还是key，都可以使用简写变量的方式 */
proc sort data=sortKeys out=sortedOutput;
    key x1 x2-x4;
run;
```

## `proc format`过程

### `proc format`使用说明

- `value`语句
  - 其他类型转换为**字符型**，且字符→字符，则需要用`$`。
  - 主要与`put(x,format)`连用。
- `invalue`语句
  - 其他类型转换为**数值型**，且字符→数字，则需要用`$`。
  - 主要与`input(x,informat)`连用。
- `picture`语句
  - 将值映射到一种具体的数值模板上。
- 在format过程步中使用选项时，要将选项放置到括号`(options)`中。

### 设置format的范围值

1. 若要赋值的range是不止一个具体的值，用逗号（字符型）将他们隔开，字符型变量的值必须放在引号内；
2. 范围端点为有限值，且包含有限值：用短横线`-`表示连续的范围，也可表示字符；
举例：0-1，1-100，-1-6；
3. 范围端点包含无限值（正无穷或负无穷）：关键词`low`和`high`表示变量的最大值和最小值；
举例：0-high, low-0, low-high；
4. 范围端点为有限值，但不包含有限值：用`<-`  `-<`来表示不包括范围的结尾值，`<`在哪边表示不包括哪边的界限；
举例：0<-1, 1-<100, -1<-<6；
5. 可用关键词`other`给未分配的值分配格式；
6. 用`.`表示缺失：无论数值还是字符都只能使用`.` ，不能使用`""`
7. 用`_same_`表示给的值保持原始值不变；

```SAS
proc format;
    value gender /*数值型*/
        1='Male'
        2='Female';
    value $sexf /*字符型 加$符号,*/
        F="女性"
        M="男性";
    value agegroup /*数值范围*/
        0-18 = '0 to 18'
        19-25= '19 to 25'
        26-49 ='26 to 49'
        50-high= '50+';
    value agegrp /*数值范围,<在哪边就是不包括哪边*/
        13-<20='Teen'
        20<-65='Adult'
        65-high='Senior';
    value $ color /*字符型变量加$符号*/
        'W'='Moon White'
        'B'='SKy Blue'
        'Y'='Sunburst Yellow'
        'G'='Rain cloud Gray';
    value  $ typ  /*多选项*/
        'bio','non','ref'='Non-Fiction'
        'fic','mys','sci'='Fiction';
run;
```

### 使用`(default=n)`选项处理format截断

- 以系统内定值为最长的描述格式或数值标签的长度。n为指定的变量长度，一般为200；

```sas
proc format;
    /* 如果不设置format的长度，则会自动取当前的format value的最大值:'Cycle1 Day 28'，14个字符 */
    value $avtx
        'week 1'='cycle 1 day 1'
        'week 2'='cycle 1 day 8'
        'week 3'='cycle 1 day 15'
        'week 4'='cycle 1 day 28';
    /* 定义了format长度，就不会存在截断的情况 */
    value $avtxd (default=200)
        'week 1'='cycle 1 day 1'
        'week 2'='cycle 1 day 8'
        'week 3'='cycle 1 day 15'
        'week 4'='cycle 1 day 28';
run;
data avt2;
    set avt;
    if avisit='week 11' then avisit='cycle 3 day 15 pre-dose';
    length avisit2 $200;
    avisit2=put(avisit, $avtx.);
    avisit2d=put(avisit, $avtxd.);
run;

/*
avisit                   avisitn       avisit2                      avisit2d
week 1                      1        cycle 1 day 1                cycle 1 day 1
week 2                      2        cycle 1 day 8                cycle 1 day 8
week 3                      3        cycle 1 day 15              cycle 1 day 15
week 4                      4        cycle 1 day 28              cycle 1 day 28
cycle 3 day 15 pre-dose     5        cycle 3 day 15     cycle 3 day 15 pre-dose
*/
```

### 使用`(fuzz=.n)`选项设置模糊format

- 数字中的小数部分小于等于.n，则匹配相应的format。
- 如果小数部分大于.n，则只能输出数字的四舍五入整数结果。

```SAS
proc format;
    value levelsa (fuzz=.2)
        1='A'
        2='B'
        3='C'
    value levelsb (fuzz=.5)
        1='A'
        2='B'
        3='C'
run;
data test3;
    input x;
    cards;
        1.2
        2.3
        3.1
        1.03
        2.15
    ;
run;
data res;
    set test3;
    y = put(x, levelsa.);
    z = put(x, levelsb.);
run;
/* 3.1，小数部分为 0.1 < 0.2，因此匹配上 fuzz=.2，整数部分为 3，所以最后输出为 C */
/* 2.3，小数部分为 0.3 > 0.2，因此没有匹配上 fuzz=.2，此时不能匹配为 B，只能输出 2.3 的整数部分 2 */
/*
  x     y   z
 1.2    A   A
 2.3    2   B
 3.1    C   C
1.03    A   A
2.15    B   B
*/
```

### 定义`picure`的数值模板

1. 数值选择符：
   - 用于定义数值位置的0-9的字符，1个选择符代表1位数字，通常用数字9来表示非0字符。
   - 如果是非0选择符在最左侧，不足位的数值将会用0补位。
   - 如果是0选择符在最左侧，不足位的数值将不会用0补位。
2. 信息字符：
     - 是指非数字字符，直接输出字符串的内容，类似于`value`语句生成的格式。
     - 可以同时包括数值选择符和信息字符，不过数值字符必须在模板的开头，这样数值选择符的格式才能正常显示。
3. 指令：是一些特殊字符，可以用来格式化日期、时间或日期时间值。

```SAS
proc format;
    /* 数值选择符 */
    picture fmta
        1-5 = '009.9'
        5<-10 = '999.9' ;
    /* 信息字符 */
    picture fmtb
        1-5 = 'ha'
        5<-10 = 'hei' ;
    /* 数值选择符和信息字符连用 */
    picture fmtc
        1-5 = '000.00 ha'
        5 <- 10 = '999.9 hei' ;
run;
data tmp;
    /* 对于1到5之间的数值，保留1位小数；对于5到10之间的数据值，保留1位小数，如果小数点左侧位数小于3位，则用0补位 */
    a = 1;
    b1 = put(a, fmta.);
    b2 = put(a, fmtb.);
    b3 = put(a, fmtc.);
    output;
    a = 10;
    b1 = put(a, fmta.);
    b2 = put(a, fmtb.);
    b3 = put(a, fmtc.);
    output;
run;
/*
a     b1  b2        b3
1    1.0  ha      1.00 ha
10 010.0 hei    010.0 hei
*/
```

### 对`picture`数值模板保留小数

- `(round)`对数值进行保留小数位数的操作。
  - 未使用`Round`选项时，对数值进行保留两位小数的操作，会直接取小数位的后两位，不管小数点后第3位数值的大小。
  - 使用`Round`选项后，对数值进行保留两位小数的操作，会根据小数点后第3位数值的大小进行四舍五入。

```SAS
**With Round option;
proc format;
  picture fmt (round)
    1-5 = '000.00'
    5<-10 = '999.99 '
  ;
run;
data tmp2;
  a = 1.444; b = put(a, fmt.); output;
  a = 1.445; b = put(a, fmt.); output;
  a = 9.444; b = put(a, fmt.); output;
  a = 9.445; b = put(a, fmt.); output;
run;
/*
  a        b
1.444   1.44
1.445   1.45
9.444 009.44
9.445 009.45
*/
```

### 定义描述统计的输出模板

- 通常在输出频数汇总时，频数和频率的输出都是以n (xx.x)的形式输出。
  1. `min =`选项指定格式的最小长度。如果不指定长度的话，默认长度是第一条记录format值的长度，这可能造成后续值的截断。
  2. `round`选项：对数值进行四色五入。
  3. `(Prefix="string")`选项：指定一个字符作为格式化模板的前缀。开头的左括号可以通过`prefix="( "`选项来实现。
  4. 特定范围的数值可以使用数值选择符设置特定的格式，后面添加信息字符右括号`)`。

```SAS
proc format;
  picture fmt (round min = 10)
    0-<99.95 = '009.9 )'  (prefix = "( ")
    99.95-100 = '999.9 )'  (prefix = "( ")
  ;
run;
data tmp1;
    /* 使用Picture格式的输出：左括号始终距离数字1个空格 */
    /* 手动输出括号的结果：左括号的位置始终固定 */
    a = 0.15; b = put(a, fmt.);  c = "( " || put(a, 5.1) || " ) "; output;
    a = 10.15; b = put(a, fmt.); c = "( " || put(a, 5.1) || " ) "; output;
    a = 99.92; b = put(a, fmt.); c = "( " || put(a, 5.1) || " ) "; output;
    a = 99.96; b = put(a, fmt.); c = "( " || put(a, 5.1) || " ) "; output;
run;
/*
a       b(length=10)   c
0.15      ( 0.2 )  (   0.2 )
10.15    ( 10.2 )  (  10.2 )
99.92    ( 99.9 )  (  99.9 )
99.96   ( 100.0 )  ( 100.0 )
*/

```

### `picuture`进行`round`的Bug处理

- 当percent=9.96时，`put(percent,pcta.)`结果为0的问题。
- 用额外的data步操作进行手动处理。

```SAS
proc format;
    picture pcta(round)
        0-<10   ='9.9)' (prefix=' (  ')
        10-<100='99.9)' (prefix=' ( ')
        100   ='999  )' (prefix=' (') ;
run;

if 9.95 <= percent < 10 or 99.95 <= percent < 100 then percent = round(percent, 2);
```

### `format`与数据集的传输

- 表中字段要有`FMTNAME`,`START`,`END`,`LABEL`。
  - `FMTNAME`变量：指定创建的格式名称。如果以`$`开始，将自动创建character format。
  - `START`变量：格式范围起始值。
  - `END`变量：格式范围结束值。
  - `LABEL`变量：使用format后将会显示的值。
  - `TYPE`变量：设置informat和format。
    - J：character informat.
    - I：numeric informat.
    - C：character format.
    - N：numeric format.
    - P：picture format.
  - `HLO`变量：在数据集中表示上下限，`HLO`变量的可选值范围：F、H、I、L、N、O、R、S。
    - L表示本条的`START`变量值是LOW。
    - H表示本条的`END`变量值是HIGH。
  - `SEXCL`变量：在数据集中表示排除起始值，其值可以是Y或N。
  - `EEXCL`变量：在数据集中表示排除终点值，其值可以是Y或N。

#### 数据集转为`format`

- `cntlin=SAS表名`选项允许我们读入SAS数据集并创建新格式。

```SAS
/* 建立了名为scale的数据集，它指定了数值范围和相应的格式 */
data scale;
    input begin: $char2. end: $char2. amount: $char4.;
    datalines;
        0   3    0%
        4   6    3%
        7   8    6%
        9   10   8%
        11  16   10%
    ;
run;

/* 添加一些其他需要的格式控制变量设置：加入了other条件的标签值：当数据不取在上面的范围内时，显示格式为"***ERROR***" */
data ctrl;
    length label $11;
    set scale(rename= (begin= start amount= label)) end= last;
    retain fmtname "PercentageFormat" type "n";
    output;
    if last then do;
        hlo= "O";
        label= "***ERROR***";
        output;
    end;
run;

/* 将创建的格式存储在目录 Work.Formats 中，并指定格式的来源 */
proc format library= work cntlin= ctrl;
run;

/* 显示percentageformat的格式情况 */
proc format lib= work fmtlib;
    select percentageformat;
run;
```

#### `format`转为数据集

- `cntlout=sas表名`将formats文件可以转化为SAS数据集的形式存储；
- 导出的数据集变量含义：
  - `HLO`变量：在输出数据集中表示上下限，`L`表示本条的start变量值是LOW；`H`表示本条的end变量值是HIGH。
    - `HLO`变量的可选值范围：F、H、I、L、N、O、R、S。
  - `SEXCL`变量：在输出文件中表示排除起始值，其值可以是Y或N。
  - `EEXCL`变量：在输出文件中表示排除终点值，其值可以是Y或N。

##### 常规`format`转为数据集

```sas
proc format library=work cntlout=psn(keep=fmtname start end label);
    value person 0-2='baby'
                3-12='child'
                13-19='teen'
                20-64='adult'
                65-100='senior' ;
run;

/*
fmtname  start  end   label
person    0      2    baby
person    3     12    child
person    13    19    teen
person    20    64    adult
person    65   100    senior
*/
```

##### 带有端点值和无限范围的`format`转为数据集

```sas
proc format library=work cntlout=psn (keep=fmtname start end label sexcl eexcl hlo);
    value person
        low-2='baby'
        3-<13='child'
        13-19='teen'
        20-64='adult'
        64<-high='senior' ;
run;

/*
fmtname  start  end   label   sexcl   eexcl  hlo
person    LOW    2    baby     N        N     L
person    3     12    child    N        Y
person    13    19    teen     N        N
person    20    64    adult    N        N
person    65   HIGH    senior  Y        N     H
*/
```

## `proc report`过程

### 基本语句

```sas
ods escapechar="~";
ods listing close;
ods rtf file="/home/pic0xxd/test.rtf" style=global.rtf operator="~{\dntblnsbdb}";

title6 j=l "#byval2";
proc sort data=sashelp.class out=class; by sex; run;
proc report data=class nowd split="~" headline headskip missing spacing=1
        style(report) = [protectspecialchars = off asis = on]
        style(header) = [just=l protectspecialchars=off asis=on]
        style(column) = [just=l protectspecialchars=off asis=on]
        style(lines)  = [outputwidth=100% protectspecialchars=off asis=on];
    column sex name age height weight;
        by sex;
    define sex / order flow style(column)=[cellwidth=20%];
    define name / display flow style(column)=[cellwidth=20%];
    define age / display flow style(column)=[cellwidth=20%];
    define height / display flow style(column)=[cellwidth=20%];
    define weight / display flow style(column)=[cellwidth=19%];

    break after sex / page;
    compute before sex;
        line @1 " ";
    endcomp;
run;
ods rtf close;
ods listing;
```

### `ods`语句相关说明

- 指定转义字符

  `ods escapechar="~";`
- 先开后关，后开先关

  ```sql
  ods listing close;
  ods rtf file="xxx.rtf";


  ods rtf close;
  ods listing;
  ```

- output对齐的ods选项

  ```sql
  ods rtf file="test.rtf" operator="{\jexpand\dntblnsbdb}";
  ```

### 过程步options

| 常用选项                 | 选项的作用                                                                                                                                                                         | 默认值                    |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------- |
| `nowd`(nowindows)    | 将结果显示到输出窗口和结果查看器窗口，如果不加该选项，绝大多数情况下加上该选项。                                                                                                                                      | 无，默认输出到一个新的报表窗口，不方便查看。 |
| `headline`           | 在表头下方显示一条分割线，使表头与下方数值分隔开。                                                                                                                                                     | 无                      |
| `headskip`           | 在所有列标题下面或横线(HEADSKIP)下面写一个空行。                                                                                                                                                 | 无                      |
| `split=`             | 指定label的分隔符，与ods escapechar无关。                                                                                                                                                | /                      |
| `box`                | 生成的表格包含所有的横竖框线。                                                                                                                                                               | 无，没有任何框线               |
| `showall`            | 强制所有column中出现的列都输出，即使define后面的选项是noprint! 据说这是一个debug的好工具，便于查看有时候group和order的变量为什么不起作用。但是工作中不常用。                                                                              |                        |
| `center`\|`nocenter` | center: 输出的列都是居中。&#xA;nocenter:输出的列都是左对齐。                                                                                                                                     | center                 |
| `list`               | 输出proc report输出报告时对各列配置的属性，包括宽度，对齐方式等。一般到后面我们会手动给各列设置长度。                                                                                                                      |                        |
| `noheader`           | 不输出列标题，一般在用两个proc report的时候，不想输出第二个report的标题就可以加这个选项，但是工作中输出listing每页都得输出列标题。所以不常用。                                                                                           |                        |
| `missing`            | 对于变量值中有缺失值的，也当作一个值输出（只对order,group,across选项的值有效），这个必须添加，因为工作中肯定会遇到缺失值。如果某个变量全部是缺失值，会报这个warning。`Warning: A GROUP, ORDER, or ACROSS variable is missing on every observation.` | 不显示缺失值&#xD;            |

### `column`语句

#### 基本原则

- 指定输出的一个或多个变量，控制变量在输出中的顺序。
- 当指定的变量均为字符型时，会输出所有指定变量的每一条观测；
- 当指定的变量均为数值型时，仅输出指定数值变量的总和，而不是每一条观测；
- 当指定的变量既有数值变量又有字符变量时，输出指定变量的每一条观测；

#### 多层表头

- 方法一：中间会连接到一起
    其中的"`^`"通过`ods escapechar`指定，不能与`proc report`中`split=`选项指定的符号相同。

```sas
column sex name age
        ("^S={borderleftcolor=white
            borderrightcolor=white
            borderbottomcolor=black
            borderbottomwidth=.05} BMI info"
        height weight);
```

- 方法二：中间不会连接到一起
    其中的"`^`"通过`proc report`中`split=`选项指定。

```sas
%let line1=%sysfunc(repeat(_,39));
column sex name age ("BMI info~&line1." height weight);
```

### `where`语句

用于筛选数据

```sql
proc report data=sashelp.class;
    where sex='F' and weight > 70;
run;
```

### `define`语句

为单个变量指定特定的options。

```sas
DEFINE variable / <option(s)>  <'column-heading'> ;
```

| 常用选项                                             | 选项的作用                                                              |
| ------------------------------------------------ | ------------------------------------------------------------------ |
| `format=`                                        | 指定数值型变量的显示格式                                                       |
| `n,mean`,`std`,`median`,&#xA;`q1`,`min`,`max`... | 各种统计量                                                              |
| `width=`                                         | 指定列宽，默认宽度：字符-变量长度，数值-9                                             |
| `spacing=`                                       | 指定选定列和紧接其左侧的列之间的空白字符。默认为2                                          |
| `center`,`left`,`right`                          | 表格中数据对齐方式；默认：数值-右对齐，字符-左对齐。如果在`style(column)={}`中定义了居中等格式，此选项不起作用。 |
| `id`                                             | 指定变量将会在每一个显示出来。可以实现同一个subject折页显示不同变量。                             |
| `page`                                           | 用于在指定的列开始新的页面。可以配合`id`选项实现折页。                                      |
| `flow`                                           | 变量长度超过定义的宽带之后，自动换行显示。                                              |
| 'column-heading'                                 | 指定列标题的标签，超过列宽会自动换行，也可通过`split=`指定的分隔符。                             |
| 变量的显示方式                                          | 变量的显示方式有6种。                                                        |

- 6种变量显示方式
  1. `display`
     - 显示每一条观测，字符变量默认用法。
  2. `analysis`
     - 指定变量为分析变量，并指定统计量（默认`sum`），数值型变量的默认用法。
  3. `order`
     - 指定变量为顺序变量，相同变量值，只显示一个，显示每一条观测。
     - 并且这些行按顺序(升序)排列，`descending`(降序)。生成listing  report。
     - 可以在`order`中定义选项：
       - `order=data`: 排序规则为数据集中所有观测值的出现顺序。
       - `order=interval`: 排序规则为数据集中原本的顺序。
  4. `group`
     - (汇总)指定变量为分组变量，为变量的每个唯一值创建一行。生成summary report。
     - column中所有字符变量均为分组变量时，默认生成column中其他数值型变量的统计量（默认SUM）。
     - 如果需要显示其他统计量，可以使用define语句对数值型变量进行指定。
  5. `across`
     - (频数)为变量的每个唯一值创建一列，产生列分组。
     - ACROSS的变量生成频数值（COUNT），其他数值型变量则显示sum统计量。
  6. `computed`
     - 输出中添加计算变量。
     - 通过计算创建新变量`new_var`，`new_var`需要在`column`语句中。
     - 如果计算中使用到了其他变量`other_var`，那么在`column`语句中`other_var`要写在`new_var`的前面。

     ```sas
     /*输出中添加计算变量的格式*/
     DEFINE new_var_name / COMPUTED;    /*计算块中的新变量，必须添加computed选项*/
     COMPUTE new_var_name / options;
         statements;                    /*可以是：赋值语句、IF语句、DO循环语句*/
     ENDCOMP;


     /*
     ***计算数值变量***
     ！！！在COMPUTE语句中定义其变量名
     ！！！如果用到分析(ANALYSIS)角色变量，则必须将其对应的统计量(默认SUM)放在变量名后。
     下面语句生成一个数值计算变量Income，其值为Salary和Bonus的总和。
     */
     DEFINE Income / COMPUTED;
     COMPUTE Income;
         Income = Salary.SUM + Bonus.SUM;
     ENDCOMP;


     /*
     ***计算字符变量***
     ！！！在COMPUTE语句中添加“CHAR”选项和“LENGTH”选项指定字符变量长度（1~200，默认8）。
     下面语句生成一个字符计算变量JobType。
     */
     DEFINE JobType / COMPUTED;
     COMPUTE JobType / CHAR LENGTH = 10;
         IF Title = 'Programmer' THEN  JobType = 'Technical';
         ELSE JobType = 'Other';
     ENDCOMP;

     ```

### `by`语句

按指定的变量分多个表显示(使用前需要先排序)。

### `#byvar`的使用

- 用法：在proc report制作报表时，按指定变量的分类显示。

  ```typescript
  #byval(variable-name)
  #byval1
  #byval2
  ...
  ```

- 可以用来添加output的subtitle。
  - 首先用`proc sort`进行排序。
  - 排序后`#byvar`就可以你用`proc sort`的~~by~~变量，因此也也可以写成`#byvar(variablename)`。
  - 在`proc report`中同样使用目标分类显示变量。

  ```sas
  proc sort data=sashelp.class out=temp;
  by sex;
  run;
  title1 "Listing of Subject Characteristics";
  title2 "Sex=#byval(sex)";
  proc report nowd data=temp;
      by sex;
      column name height weight;
      define name / "Patient Name" width=30;
      define height / "Height" width=15;
      define weight / "Weight" width=15;
  run;

  ```

- 多个`by`变量的处理
  - 实际上多个 `By` 变量不影响，按需使用就行。
  - `#byval1 #byval2` 这个等价于`#byval(origin) #byval(make) ,1,2...`是 `proc sort` 里 `by` 变量的顺序。
  - `"Brand #byval2 From #byval1";` 这里面的写法很自由，就相当于我们日常造句，只是使用`#byval` 语法来动态替代分类变量名。

  ```sas
  proc sort data=sashelp.cars out=cars;
      by origin make;
  run;

  title1 "The weight of Cars By Origin and Make";
  title2 "Brand #byval2 From #byval1";

  proc report nowd data=cars;
      by origin make;
      column weight;
      define weight / "Weight" width=15;
  run;
  ```

### `break`与`rbreak`语句

- `break`：可在指定变量的上方(before) 或下方(after) 插入一条分割线， 并显示统计量。
- `rbreak`：指定在表格最下方或最上方插入一条分割线， 并显示统计量。

```batch
BREAK after variable/options;
RBREAK before /options;
```

variable：必须是分组(`group`)变量或者排序(`order`)变量。

| 常用选项(options) | 选项的作用                                                                      |
| ------------- | -------------------------------------------------------------------------- |
| ol            | 在指定的变量（或表格）上方显示一条单横线作为分割线                                                  |
| ul            | 在指定的变量（或表格）下方显示一条单横线作为分割线                                                  |
| dol           | 在指定的变量（或表格）上方显示一条双横线作为分割线                                                  |
| dul           | 在指定的变量（或表格）下方显示一条双横线作为分割线                                                  |
| page          | 开始新的一页                                                                     |
| summarize     | 在指定的变量（或表格）上方或下方显示指定变量的综合统计量，如break after gender/summarize;，可分别显示男性和女性的统计量 |
| suppress      | 当输出指定变量的综合统计量时，不显示该变量的类别名                                                  |

### `compute`语句

`compute`语句有两个， 一个与跟`line`语句合用， 另一个是与`call define`语句合用。

#### `line`语句

- 与`line`语句合用时， 创建自定义行。

1. 创建自定义行： LINE语句允许您在报告中插入自定义的文本行，这些行可以包含静态文本、变量值或计算结果。
2. 位置灵活： LINE语句可以在COMPUTE块内使用，因此可以在报告的开始、结束或特定列的计算中插入行。
3. 格式控制： 您可以使用LINE语句控制文本的对齐方式（左对齐、居中、右对齐）和样式。
4. 条件输出： 结合IF-THEN语句，LINE可以根据特定条件输出不同的文本行。
5. 多行输出： 您可以使用多个LINE语句来创建多行输出。
6. 变量引用： 在LINE语句中，您可以引用报告中的列、计算值或其他SAS变量。

```sas
line @1 "total: " @10 (put(total, dollar12.2));
if status = 'completed' then line @1 "status: completed";
else line @1 "status: in progress";

line @1 "customer: " @15 (upcase(customer_name));
```

#### `call define`语句

- 与`call define`语句合用时，可以对表格进行修饰。

```sas
compute height;
    if height>175 then
    call define
endcomp;
```

### footnote显示在第一页

```sas
data page_final;
    set listings.&TFLNAME.;
    GRPX0 = 1; /* determine page by grouping */
run;
/* footnote: refer to the first page */
proc sql noprint;
    insert into page_final(BYVAR, GRPXPAG, GRPX0) values("^n", 0, 0);
    create table final_all as
        select *
        from page_final
        order by GRPX0, GRPX1, GRPX2, GRPX3, GRPX4, GRPX5, GRPX6, GRPX7;
quit;

ods escapechar="~";
ods listing close;
ods rtf file="&_olistings.&TFLNAME..rtf" style=global.rtf operator="~{\dntblnsbdb}";
%do i=0 %to 1;
    data final_out;
        set final_all;
        where GRPX0=&i.;
    run;
    %if &i = 1 %then %do;
        title6 j=c " ";
        title7 j=l "#byval3";
    %end;
    proc report data=final_out nowd split="~" headline headskip missing spacing=1
            style(report) = [protectspecialchars = off asis = on]
            style(header) = [just=l protectspecialchars=off asis=on]
            style(column) = [just=l protectspecialchars=off asis=on]
            style(lines)  = [outputwidth=100% protectspecialchars=off asis=on];
        %if &i = 0 %then %do;
            column GRPXPAG GRPX0 GRPX1 GRPX2 GRPX3;
            define GRPXPAG / order noprint;
            define GRPX0 / order noprint;
            define GRPX1 / order noprint;
            define GRPX2 / order noprint;
            define GRPX3 / order noprint;
        %end;
        %else %do;
            column GRPXPAG GRPX1 GRPX2 BYVAR GRPX3 COL1-COL5;
                by GRPX1 GRPX2 BYVAR;
            define GRPXPAG / order noprint;
            define BYVAR / order noprint;
            define GRPX1 / order noprint;
            define GRPX2 / order noprint;
            define GRPX3 / order noprint;
            define COL1 / order flow style(column)=[cellwidth=20%];
            define COL2 / display flow style(column)=[cellwidth=20%];
            define COL3 / display flow style(column)=[cellwidth=20%];
            define COL4 / display flow style(column)=[cellwidth=20%];
            define COL5 / display flow style(column)=[cellwidth=19%];
        %end;
        break after GRPXPAG / page;
        %if &i.=0 %then %do;
            compute before GRPX3/style={just=l};
                line @1 " ";
                line @1 "ADJ=adjudication, AE=adverse event, AESI=adverse event of special interest, Disc=discontinuation, F=female, M=male,";
                line @1 "N=no, Rel=related, SAE=serious adverse event, SEV=severity, TEAE=treatment-emergent adverse event, Y=yes, yrs=years.";
            endcomp;
        %end;
        %else %do;
            compute before GRPX3;
                line @1 " ";
            endcomp;
        %end;
    run;
%end;
ods rtf close;
ods listing;
```
