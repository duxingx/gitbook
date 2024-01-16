# 1. PROC FORMAT

## 1.1. 功能描述

`proc format`是用来定义数值或字符的输出格式。

## 1.2. 语法概述

```sas
proc format <options>;
    exclude entry(s);
    invalue <$>name <(informat-options)> <value-range-set(s)>;
    picture name <(format-options)>
        <value-range-set-1 <(picture-1-options)>
        <value-range-set-2 <(picture-2-options)>> ...>;
    select entry(s);
    value <$>name <(format-options)> <value-range-set(s)>;
```

## 1.3. 过程步选项

- `library=libref` 可缩写为`lib=`存储formats文件的库名；

    ```sas
    libname save 'c:\lin';
    proc format library=save;
      value sexfmt
        1='男'
        2='女';
      value sexfmt
        1='男'
        2='女';
    run;
    ```

- `cntlout=sas表名`，将formats文件可以转化为SAS 表的形式存储；

    ```sas
    proc format Lib=work.Formats cntlout=work.Fmtport;
    run;
    ```

- `cntlin=SAS表名`,表中字段要有`fmtname`,`start`,`end`,`label`；

    如果是需要很多格式的程序 可以将相应的包含已设置好的固定字段的SAS表转化为formats，方便对格式进行增删（可在excel中设置好格式，导入SAS，作为format数据集调用）

    ```sas
    proc format lib=work.Fmtport cntlin=Work.fmtport;
    ```

## 1.4. 过程步语句

### 1.4.1. `value`语句

```sas
value <$>name <(format-options)> <value-range-set(s)>;
```

#### 1.4.1.1. `value`关键词

主要与`put(x,format)`连用，用于其他类型的数据转换为字符型的格式。

#### 1.4.1.2. `value`语句中`$`关键词

字符→字符，则需要用`$`；
数值→字符，则不需要用；

#### 1.4.1.3. `value`语句中`name`关键词

1. 不能超过32个字符（包括\$在内）；
2. 不能以数字开头或结尾；
3. 不能包含下划线以外的任何特殊字符；
4. 不能与已经存在的格式的名字重复。

#### 1.4.1.4. `value`语句中`format-options`关键词

在format过程步使用选项时，要将选项放置到括号`()`中。

1. `(min=n)`设定格式的最小宽度。n为指定的最小宽度；
2. `(max=n)`设定格式的最大宽度。n为指定的最大宽度；
3. `(default=n)`以系统内定值为最长的描述格式或数值标签的长度。n为指定的变量长度，一般为200；
4. `(fuzz=.n)`给予一个范围.n，只要数值未超出范围，程序仍能给定卷标，反之无法给定。

#### 1.4.1.5. `value`语句中`value-range-set(s)`关键词

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

### 1.4.2. `invalue` 语句

```sas
INVALUE <$>name <(informat-options)> <value-range-set(s)>;
```

#### 1.4.2.1. `invalue`关键词

主要与input(x,informat)连用，用于其他类型的数据转换为数值型的格式。

#### 1.4.2.2. `invalue`语句中的`$`关键词

字符→数字，则需要用`$`；
数值→数值，则不需要用；

#### 1.4.2.3. `invalue`语句中`name`关键词

1. 不能超过32个字符（包括\$在内）；
2. 不能以数字开头或结尾；
3. 不能包含下划线以外的任何特殊字符；
4. 不能与已经存在的格式的名字重复。

#### 1.4.2.4. `invalue`语句中的`format-options`关键词

在Format过程步使用选项时，要将选项放置到括号`()`中。

1. `(min=n)`设定格式的最小宽度。n为指定的最小宽度；
2. `(max=n)`设定格式的最大宽度。n为指定的最大宽度；
3. `(default=n)`以系统内定值为最长的描述格式或数值标签的长度。n为指定的变量长度，一般为200；
4. `(fuzz=.n)`给予一个范围.n，只要数值未超出范围，程序仍能给定卷标，反之无法给定。

#### 1.4.2.5. `invalue`语句中的`value-range-set(s)`关键词

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

### 1.4.3. `picture`语句

```sas
PICTURE name <(format-options)>
    <value-range-set-1 <(picture-1-options)>
    <value-range-set-2 <(picture-2-options)>> ...>;
```

#### 1.4.3.1. `Picture`关键词

用于创建输出数值的模板。

#### 1.4.3.2. `name`关键词

参考前文：`value`语句中的`name`关键词

#### 1.4.3.3. `format-options`关键词

1. `(Round)`选项的作用是，对数值进行格式化时，会将数值四舍五入到最近的整数。
2. `(default=n)`如果并非所有值都要通过format改变原来的取值，需要设置format的长度；n为指定的长度，一般为200；
3. `(fuzz=.n)`定义了数值匹配的一个模糊范围；.n为指定的模糊范围，例如.2, .3；

#### 1.4.3.4. `value-range-set(s)`关键词

- 等号左边：参考前文 `value`语句中的`value-range-set(s)`关键词
- 等号右边：可以理解成一种具体的数值模板，主要有3类：

1. 数值选择符 (digit selectors)；

    数值选择符，用于定义数值位置的0-9的字符，1个选择符代表1位数字。
    如果是非0选择符在最左侧，不足位的数值将会用0补位；
    如果是0选择符在最左侧，不足位的数值将不会用0补位；
    通常用数字9来表示非0字符。代码示例如下：

    ```sas
    proc format;
      picture fmt
        1-5 = '009.9'
        5<-10 = '999.9'
      ;
    run;
    data tmp;
        a = 1; b = put(a, fmt.); output;
        a = 10; b = put(a, fmt.); output;
    run;
    ```

    格式fmt的含义为，对于1到5之间的数值，保留1位小数；对于5到10之间的数据值，保留1位小数，如果小数点左侧位数小于3位，则用0补位。

    数值1的格式为0选择符在最左侧，整数位不足3位时，不需要用0补足位数；数值10的格式为非0选择符在最左侧，整数位不足3位时，需要用0补足位数。
2. 信息字符 (message characters)

    信息字符，是指非数字字符，直接输出字符串的内容，这类似于Value语句生成的格式。

    ```sas
    proc format;
      picture fmt
        1-5 = 'ha'
        5<-10 = 'hei'
      ;
    run;
    data tmp;
        a = 1; b = put(a, fmt.); output;
        a = 10; b = put(a, fmt.); output;
    run;
    ```

    Picture模板中，也可以同时包括数值选择符和信息字符，不过数值字符必须在模板的开头，这样数值选择符的格式才能正常显示。

    ```sas
    proc format;
      picture fmt
        1-5 = '000.00 ha'
        5<-10 = '999.9 hei'
      ;
    run;
    data tmp;
        a = 1; b = put(a, fmt.); output;
        a = 10; b = put(a, fmt.); output;
    run;
    ```

3. 指令 (directives)

    指令，是一些特殊字符，可以用来格式化日期、时间或日期时间值。

#### 1.4.3.5. `picture-options`关键词

1. `(noedit)`选项作用是，将Picture模板中的数值当做信息字符 (message characters)，而不是数值选择符 (digit selectors)。前面介绍到，模板中的数字都有对应的含义，`Noedit`选项会抹去模板中数字的含义，直接将数字当作纯粹的字符，与Value语句生成Format的作用完全相同。
2. `(Prefix="string")`选项的作用是，指定一个字符作为格式化值的前缀。
3. `(mult=.00001)`指定在格式化变量之前要将其值乘以的数字。

## 1.5. 案例

### 1.5.1. 案例：picture选项-`prefix="string"`

- 描述：

    ```sas
    **Prefix= option;
    proc format;
      picture fmt
        1-5 = '000.00' (prefix = "Haha - ")
        5<-10 = '999.99' (prefix = "Heihei - ")
      ;
    run;
    data tmp;
        a = 1; b = put(a, fmt.); output;
        a = 10; b = put(a, fmt.); output;
    run;
    ```

- 结果：

- 说明：

    输出结果中直接添加前缀中的内容。

### 1.5.2. 案例：picture选项-`mult=.n`

- 描述：

    ```sas
    data test5;
        input X;
        cards;
        160000
        1600000
        16000000
    run;
    proc format;
        picture fourc
            low-high='09.9M' (prefix='$' mult=.00001);
        picture fourd
            1ow-high='009.9M' (prefix='$' mult=.00001);
    run;

    data test5 1;
        set test5;
        length XC xd $200;
        xc=put(x, fourc.);
        xd=put(X, fourd.);
    run;
    ```

- 结果：

### 1.5.3. 案例：picture选项-`noedit`

- 描述：

    ```sas
    **Noedit option;
    proc format;
      picture fmt
        1-5 = '000.00 ha' (noedit)
        5<-10 = '999.9 hei'
      ;
    run;
    data tmp;
        a = 1; b = put(a, fmt.); output;
        a = 10; b = put(a, fmt.); output;
    run;
    ```

- 结果：

- 说明：

    数字1的Format，对应字符`000.00 ha`；数字10的Format，对应保留1位小数，并在数值后面添加字符"`hei`"。

### 1.5.4. 案例：format选项-`full=.n`

- 描述：

    ```sas
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
    ```

- 结果：
  - 例如 fuzz=.2，只要数字 x 中小数部分 <=0.2，则匹配为相对应的 ‘A’、‘B’、‘C’。
  - 例如 3.1，小数部分为 0.1 < 0.2，因此匹配上 fuzz=.2，整数部分为 3，所以最后输出为 C。
  - 例如 2.3，小数部分为 0.3 > 0.2，因此没有匹配上 fuzz=.2，此时不能匹配为 B，只能输出 2.3 的整数部分 2。（四舍五入，若输入为2.5，且未匹配上 fuzz=.2，则输出为 3）

### 1.5.5. 案例：format选项-`round`

- 描述：
  - 未使用`Round`选项时，对数值进行保留两位小数的操作，会直接取小数位的后两位，不管小数点后第3位数值的大小。

    ```sas
    /* Without Round option */
    proc format;
        picture fmt
        1-5 = '000.00'
        5<-10 = '999.99 '
        ;
    run;
    data tmp1;
        a = 1.444; b = put(a, fmt.); output;
        a = 1.445; b = put(a, fmt.); output;
        a = 9.444; b = put(a, fmt.); output;
        a = 9.445; b = put(a, fmt.); output;
    run;
    ```

- 结果：
  - 使用`Round`选项后，对数值进行保留两位小数的操作，会根据小数点后第3位数值的大小进行四舍五入。代码示例中，第3位为5时，会向前进一位。

    ```sas
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
    ```

### 1.5.6. 案例：format选项-`default=n`

- 描述：以下面的samplecode为例，若只想改变week1-week4的值，如果不设置format的长度，则会自动取当前的format value的最大值（’Cycle1 Day 28’，14个字符），那数据集里定义的Cycle 3 Day 15 Pre-Dose就会在新生成的变量中截断（见下图结果）；

    如果定义了format长度，就不会存在截断的情况（见下图结果）

    ```sas
    proc format;
      value $avtx (default=200)
      ‘Week 1’=’Cycle 1 Day 1’
      ‘Week 2’=’Cycle 1 Day 8’
      ‘Week 3’=’Cycle 1 Day 15’
      ‘Week 4’=’Cycle 1 Day 28’;
    Run;
    data avt2;
      set avt;
      if avisit=’Week 11’ then avisit=’Cycle 3 Day 15 Pre-Dose’;
      length avisit2 $200;
      avisit2=put(avisit,$avtx.);
    run;
    ```

- 结果：

### 1.5.7. 案例：实现P<0.05标红效果

- 描述：proc format 与foreground=P. 联合运用，设置不同p值得显示颜色。f= pvalue6.3 表示显示三位小数

    ```sas
    proc format;
        value P low-<0.05="red"
                0.05="blue"
                0.05<-high="black";
    run;
    options nodate papersize=letter ORIENTATION=LANDSCAPE missing='';
    ods rtf file="G:\output.rtf" style=journal3a;

    %macro v(data,table,jx);
        ods escapechar='^';
        title  font='Times New Roman'  bold "Table 1.&table &jx"  'Page ^{thispage} of ^{lastpage}';
        proc report data=&data nowd headskip
                    style(report)={cellspacing=0 cellpadding=2}
                    style(header)=[font_face='Times New Roman' just=center font_size=10pt]
                    style(column)=[font_face='Times New Roman' cellwidth=15% font_size=10pt just=center];
            column Effect FEV1 CL_FEV1 P_FEV1 FVC CL_FVC P_FVC FEV1_FVC CL_FEV1_FVC P_FEV1_FVC;
            define Effect/display "Effect" style={just=left cellwidth=220};
            define FEV1/display "FEV1" format=8.4 style={cellwidth=90 textalign=d};
            define CL_FEV1/display "CL(FEV1)" style={cellwidth=90 textalign=d} ;
            define P_FEV1/analysis "P" f=pvalue6.3 style={cellwidth=90 textalign=d foreground=P.} ;
            /*此处省略部分*/
        run;
    %mend v ;
    %v(ex_lung.ex_leiji,  visit>=1, 累积暴露 不校正不交互)
    ```

- 结果：

### 1.5.8. 案例：频率格式自带括号

- 描述：通常我们在输出频数汇总时，频数和频率的输出都是以n (xx.x)的形式输出。常规的做法是将数值Put出来后，与左右括号进行拼接。

    ```sas
    c1 = strip(put(_0, 5)) || " (" || strip(put(_0/&n_0.*100, 5.1)) ||")";
    ```

    通过Picture语句生成的频率格式也可以自带括号，这需要Prefix选项来实现。

    前面谈到，'Picture'模板，可以同时使用数值选择符和信息字符，但是数值选择符必须位于模板的开头。

    特定范围的数值可以使用数值选择符设置特定的格式，后面添加信息字符右括号`)`，而开头的左括号可以通过`prefix="( "`选项来实现。

    具体演示代码如下，Format选项中`min =`选项指定格式的最小长度。如果不指定长度的话，默认长度是第一条记录Format值的长度，这可能造成后续值的截断。

    代码中也展示了手动输出括号的结果，两者的显示略有区别。使用Picture格式的输出，左括号始终距离数字1个空格；而手动输出括号的方法，左括号的位置始终固定。

    ```sas
    proc format;
    picture fmt (round min = 10)
        0-<99.95 = '009.9 )'  (prefix = "( ")
        99.95-100 = '999.9 )'  (prefix = "( ")
    ;
    run;
    data tmp1;
        a = 0.15; b = put(a, fmt.); output;
        a = 10.15; b = put(a, fmt.); output;
        a = 99.92; b = put(a, fmt.); output;
        a = 99.96; b = put(a, fmt.); output;
    run;
    data tmp2;
        a = 0.15; b = "( " || put(a, 5.1) || " ) "; output;
        a = 10.15; b = "( " || put(a, 5.1) || " ) "; output;
        a = 99.92; b = "( " || put(a, 5.1) || " ) "; output;
        a = 99.96; b = "( " || put(a, 5.1) || " ) "; output;
    run;
    ```

- 结果：

- 说明：

### 1.5.9. 案例：频率输出演示

- 描述：频率百分比大于0且小于0.1，输出为<0.1；其他则输出保留1位小数。

    ```sas
    proc format;
    picture fmt (round min = 10)
        0<-<0.1 = '( <0.1 )'  (noedit)
        0, 0.1-high = '009.9 )'  (prefix = "( ")
    ;
    run;
    data tmp;
        a = 0.05; b = put(a, fmt.); output;
        a = 0; b = put(a, fmt.); output;
        a = 90.15; b = put(a, fmt.); output;
        a = 99.96; b = put(a, fmt.); output;
    run;
    ```

- 结果：

- 说明：

    取值为0与≥0.1的Format值相同，设置格式时可以使用,进行并列。Format选项round使保留小数位时，进行四舍五入。

### 1.5.10. 案例：p值输出演示

- 描述：一般对p值的输出有要求，例如：
    1. p > 0.1, p值保留2位小数；
    2. 0.1 > p ≥ 0.001，p值保留3位小数；
    3. p < 0.001，p值显示为"p < 0.001"。

    ```sas
    proc format;
    picture fmt (round min = 10)
        0-<0.001 = 'p < 0.001'  (noedit)
        0.001-<0.01 = '9.999'
        0.01-1 = '9.99'
    ;
    run;
    data tmp;
        a = 0.0005; b = put(a, fmt.); output;
        a = 0.0015; b = put(a, fmt.); output;
        a = 0.624; b = put(a, fmt.); output;
        a = 0.625; b = put(a, fmt.); output;
    run;
    ```

### 1.5.11. 案例：定义format

- 定义format

    ```sas
    /*定义一个新的FORMAT*/
    proc format;
        /*数值型*/
        value gender
            1='Male'
            2='Female';
        /*字符型 加$符号,*/
        value $sexf
            F="女性"
            M="男性";
        /*数值范围*/
        value agegroup
            0-18 = '0 to 18'
            19-25= '19 to 25'
            26-49 ='26 to 49'
            50-high= '50+';
        /*数值范围,<在哪边就是不包括哪边*/
        value agegrp
            13-<20='Teen'
            20<-65='Adult'
            65-high='Senior';
        /*字符型变量加$符号*/
        value $ color
            'W'='Moon White'
            'B'='SKy Blue'
            'Y'='Sunburst Yellow'
            'G'='Rain cloud Gray';
        /*多选项*/
        value  $ typ
            'bio','non','ref'='Non-Fiction'
            'fic','mys','sci'='Fiction';
    run;
    ```

- Value后面的Range的要求：

    ```sas
    "A"          = "Asia"
    1,2,3,4      = "odd"
    50000-high   = "not affordable"
    13-<20       = "teenager"
    other        = "bad data"
    /* 1-4保持原始值不变 99时为缺失值 */
    lxfmt 1-4    = _same_
           99    = .;
    /* 如果有两个区域1-3   3-5 那么3是包括在第一个区域中 */
    grade "a"-"g" = 1
          "0","u" = 2;
    ```

### 1.5.12. 案例：调用定义的format

- data步调用

    ```sas
    /*DATA步调用*/
    data survey;
         format sex gender. age agegroup. color $color. income dollar8.;
         input age sex income color$@@;
     cards;
    19 1 14000 Y
    45 1 65000 G
    72 2 35000 B
    31 1 44000 Y
    58 2 83000 W
    ;
    run;
    ```

- proc步调用

    ```sas
    /*PROC步调用*/
    proc print data=survey;
          format sex gender. age agegroup. color $color. income dollar8.;
    run;
    proc freq data=survey;
         tables sex * age / nopercent norow nocol;
         tables sex * color / nopercent norow nocol;
         /*引用自定义的格式*/
         format sex gender. age agegrp. color  $color. ;
    run;
    ```

- sql步调用

    ```sas
    /*PROC SQL format选项调用*/
    proc sql;
      select age  format=agegroup. ,sex format=gender.,income  format=dollar8.,color  format=$color.
      from survey;
    quit;
    ```

## 1.6. 参考

1. [sas help center](https\://documentation.sas.com/doc/en/pgmsascdc/9.4\_3.5/proc/p1xidhqypi0fnwn1if8opjpqpbmn.htm)
2. [SAS-100种关于format的用法](https://cloud.tencent.com/developer/article/1523901 "SAS-100种关于format的用法，你在用哪种？ - 腾讯云开发者社区-腾讯云 (tencent.com)")
