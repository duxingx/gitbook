# Clinical Trial 101

## 临床试验流程

1. **筛选期(Visit=Screening)**
   1. 患者签署知情同意书
        - 签署知情同意的时间*代表受试者参加临床试验的起点*：RFICDT
        - 符合筛选条件的受试者进入Enrollment Set：ENRLFL=Y
   2. 入组前检查
        - 身高/体重/年龄/性别/婚育状况/吸烟史/酗酒史等：DM domain
        - 适应症相关的症状评估表：QS domain
        - 既往用药/既往病史等：CM/MH domain
        - 实验室检查/CT/心电图等：LB/PR/EG domain
   3. 筛选入排标准
        - 符合全部入组标准，不符合全部排除标准：IE domain
        - 不符合标准的记为筛败：Screen Failure
   4. 随机分组
        - 随机时间：RANDDT
        - 是否随机：RANDFL=Y
        - 进入意向性分析集：ITTFL=Y
        - 分配随机号：RANDNUM

2. **治疗期(VISIT=DAY 1)**
   1. 发药
        - 收集发药信息(DA domain)：DATEST/DAORRES/DADTC
   2. 在吃药前可能会再进行一次检查
        - 首次吃药前最后一次非空的检查结果作为基线结果：Baseline, BASE
   3. 首次吃药
        - 记录首次用药时间：TRTSDT
        - 收集计划入组和实际入组信息：TRT01P, TRT01A
        - 进入全分析集：FASFL=Y
        - 进入安全性分析集：SAFFL=Y
        - 吃药信息收集到EX中：ASTDT/AENDT/ADOSE/DOSEFRQ/DOSROUTE...
   4. 吃药后检查
        - 吃药后所有新发症状都收集到AE：用AESTDTC与TRTSDT比较后得到TRTEMFL=Y
   5. 定期吃药和检查
        - 每次检查都会被看成一个访视：VISIT
        - 收集定期吃药的信息：EX domain
        - 记录每次访视的检查结果：LB/EG/PR/QS domain...
        - 需要送到中心实验室的检查项目：Center Lab(External Vendor Data)
        - 本地实验室检查的项目：Local Lab(EDC Data)

3. **治疗结束(VISIT=ET/EOT)**
   1. 正常吃药并完成了整个治疗期(EOT="COMPLETED")
   2. 提前结束治疗试验(EOT="DISCONTINUED")

4. **随访(VISIT=Follow-up)**
   1. 治疗结束后进行安全随访和生存随访

5. **研究结束(VISIT=EOS)**
   1. 结束随访后即整个研究结束(EOS="COMPLETED")

> 在写SE的时候，筛选期的SEENDTC是什么日期？治疗期的SEENDTC又是什么日期？在求RFPENDTC的时候，如果进行了生存随访，但是受试者在前几天就死亡了，今天这个随访日期我们能做到RFPENDTC里面去吗？

## Disposition

- **Screened(ENRLFL=Y)**
  - = Subjects Failed Screening + Subjects Randomized(RANDFL=Y)

- **Randomized(RANDFL=Y)**
  - = Subjects Randomized but not Treated(RANDFL=Y & SAFFL^=Y) + subject Treated(SAFFL=Y)

  - = Subjects Completed Study(EOS=COMPLETED) + Subjects Discontinued from Study(EOS=DISCONTINUED)

  - = Subjects Completed the Month 6 Visit(M6CMFL=Y) + Subjects Withdrawal before the Month 6 Visit(M6CMET=Y)

- **Treated(SAFFL=Y)**
  - = Subjects Completed Treatment(EOT=COMPLETED) + Subjects Discontinued from Treatment(EOT=DISCONTINUED)

## Analysis Population

- Enrollment Population(ENRLFL)
    受试者签署了知情同意书同意参加临床试验。
    > 不过需要注意的是：Potential participants who are screened for the purpose of determining eligibility for the study, but do not participate in the study, are not considered enrolled, unless otherwise specified by the protocol.

- Full Analysis Population(FASFL)
    只要随机or用过试验药的，大致都会划分到这个集里，一般会用于基线数据分析和疗效评估

- Intent-to-Treatment(ITTFL)
  - 你情我愿的意思，受试者愿意接受治疗，研究者也愿意纳入本试验，其实从CRA角度来讲，就是签了知情呗。

- Per-Protocol Set(PPSFL)
  - 没有重大方案违反，显著影响主要疗效指标or次要疗效指标的，可以纳入。这个数据集的人群主要是用来进行主要疗效分析，会在数据审核会议上由专家们讨论后划分（对，就是你们递交的那个IDMC会议纪要啊、IDMC报告啊等）

- Safety Set(SAFFL)
  - 至少用药1次后纳入，主要用于安全性疗效分析。


## 统计学一般考虑

描述性统计内容：

连续型变量（Continued Variables，比如说血压、身高、心率、实验室检查结果等）一般用均值、例数、最大最小、中位数、标准差等进行描述；

分类型变量（Categorical Variables，比如说种族、性别、量表结果等）一般用例数、频数、百分比表示。

一般来说，连续型变量可以通过一定的规则转换为分类型变量，但是会缺失一些数据的精度，不过也方便直观呈现些统计学结果。在普通试验中，数据一般都是比较完整的，不完整的数据，也能把它变完整（逃）但是在临床试验中，一般不允许造假（咳咳，一线的煎茶员们看穿别揭穿哈），但是数据不完整就会影响统计推断，咋办？那就通过一系列的方法，把这个数据不全，方便我们分析。详细掌握SAP中的数据补齐方法，是在做数据集时候需要仔细看的。

推断性统计的：

也就是p值得计算了，具体使用什么模型，双侧单侧，CI多少，模型的因素选择是啥，等都是需要关注的点。

## 主要疗效指标（Primary Endpoints）

如果一个CRA做监查都不知道本试验的主要疗效指标是什么，那我认为是不合格的，至少方案培训是没有到位的。整个临床试验的开展，都是围绕主要疗效指标的统计学假设进行的。H0和H1分别是什么，本研究是优效/非劣效/等效等。使用什么样的统计模型进行分析，主要疗效指标的变量是什么类型，需要根据临床的实际情况加入各种因素（协变量等），明确了目标后，才能更好地进行统计分析和临床试验的开展和监查。

次要疗效指标和安全性分析指标也是类似，但侧重点不同，就不展开讲了。

冷知识：临床试验的样本量计算都是根据主要疗效指标来估计的，所以其实比较安全性指标的p值，意义不是很大，因为样本量不是为它服务的，也就图一乐。当然，不同方案设计会有不同的统计分析方法，我统计学小白属于班门弄斧，也请大家指正。

## 数据集/TFL的一些要求

变量怎么Derived，需要哪些数据集，出什么样的图表等等等等。这些会有另外专门的图表说明（Spec，specification）讲解，这里就不展开了。

