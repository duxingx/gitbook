# Clinical Trial 101

## 受试者临床试验流程

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

2. **治疗期(VISIT=DAY 1/2/...)**
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
   1. 正常吃药并完成了整个治疗期(EOT="COMPLETED")：VISIT=End of Treatment
   2. 提前结束治疗试验(EOT="DISCONTINUED")：VISIT=Early Termination
   3. 疗效评估：QS/FA/LB
4. **随访(VISIT=Follow-up)**
   1. 治疗结束后进行安全随访和生存随访：VISIT=Follow-Up

5. **研究结束(VISIT=EOS)**
   1. 结束随访后即整个研究结束(EOS="COMPLETED")：VISIT=End of Study

> 在写SE的时候，筛选期的SEENDTC是什么日期？治疗期的SEENDTC又是什么日期？在求RFPENDTC的时候，如果进行了生存随访，但是受试者在前几天就死亡了，今天这个随访日期我们能做到RFPENDTC里面去吗？

## Analysis Population

决定相关的Analysis Set的定义主要遵循以下两个原则(ICH E9)：

- 最小化偏差(to minimise bias)。
- 避免一类错误膨胀(to avoid inflation of type I error)。

### Enrolled Set(ENRLFL)

- 人群：受试者**签署了知情同意书同意参加临床试验**。

- 应用：主要用于summarize **Disposition**。

- 分组：被随机（**计划**）的组。

### Intent-to-Treatment(ITTFL)

- 人群：纳入**所有随机化受试者**，并遵从随机化分配结果进行统计分析。

- 应用：**通常用于主分析(Primary Analysis)**。
  - 因为它倾向于避免PPS所导致的对有效性的过度乐观估计：PPS中可以提前排除无基线值、依从性差、早期失访的患者，通常此类患者较高的结局事件发生风险，因此，ITT的结果一般偏于保守。
  - ITT原则认为**依据计划的随机化而不是实际的治疗措施**才能做出对效果最好的评价。ITT的优势在于尽量保持随机化，**最大程度的均衡基线特征，从而排除影响疗效评估的其他因素**。

- 分组：被随机（**计划**）的组。

### Full Analysis Set(FASFL)

- 人群：**尽可能接近包括所有随机化受试者的ITT理想状态的分析集**。在FAS分析中，保持初始随机化对于防止偏倚以及为统计检验提供可靠基础是很重要的。FAS是**以最小和最合理的方法排除了ITT中的部分受试者**，原因通常包括：
  - 违反重要入组标准（不合格入选标准的受试者）。
  - 受试者未接受试验药物治疗。
  - 无任何随机化后试验随访记录的受试者。

- 应用：**一般用于疗效的分析评价**。为许多临床试验提供了相对保守的策略，如果主要疗效指标缺失，可根据ITT分析，用前一次的结果结转可比性分析和次要疗效指标的缺失不作转结。

- 分组：**实际**的治疗组。

### Per-Protocol Set(PPSFL)

- 人群：是**FAS中的受试者对方案更具依从性的子集**，其中受试者符合如下标准：
  - 完成了对治疗方案的某个预先设定的最小暴露量。
  - 可以获得主要指标的测量值。
  - 无任何重大方案违背，包括入组标准违背。

     一般来说未能进入PPS集的病例有以下特征：
  - 主要疗效指标缺失基线值，无法有效评估。
  - 存在研究方案违背/偏离。
  - 依从性差。

- 应用：**一般用于疗效的分析评价**。使用PPS最可能在分析中显示出治疗的有效性。然而，相应的假设检验和处理效应估计可能不准确，对研究方案的依从性可能与处理和结局有关，这些因素可能会引入严重偏倚。

- 分组：**实际**的治疗组。

### Safety Set(SAFFL)

- 人群：**至少接受一次治疗，且有安全性指标记录的实际数据**。

- 应用：主要用于安全性评价：Extent of Exposure, AE/AESI, Clinical Laboratory Evaluation, Vital Signs, Physical Findings and Electrocardiogram.
  - 安全性数据缺失值不能转结。

- 分组：**实际**的治疗组。

### Pharmacokinetics Set(PKFL)

- 人群：**至少接受一次治疗，且至少有一个可评估的PK血浆浓度**。
- 应用：PK 分析。
- 分组：**实际**的治疗组。

### Pharmacodynamic Set (PDFL)

- 人群：**至少接受一次治疗，并且具有至少1个可评估的PD测量**。
- 应用：PD 分析。
- 分组：**实际**的治疗组。

## Disposition

- **Screened(ENRLFL=Y)**
  - = Subjects Failed Screening + Subjects Randomized(RANDFL=Y)

- **Randomized(RANDFL=Y)**
  - = Subjects Randomized but not Treated(RANDFL=Y & SAFFL^=Y) + subject Treated(SAFFL=Y)

  - = Subjects Completed Study(EOS=COMPLETED) + Subjects Discontinued from Study(EOS=DISCONTINUED)

  - = Subjects Completed the Month 6 Visit(M6CMFL=Y) + Subjects Withdrawal before the Month 6 Visit(M6CMET=Y)

- **Treated(SAFFL=Y)**
  - 可能需要提前明确SAP中对于Treated与Safety Set定义的区别
  - = Subjects Completed Treatment(EOT=COMPLETED) + Subjects Discontinued from Treatment(EOT=DISCONTINUED)

## Analysis Visit Window

The by-visit summaries will be displayed by scheduled nominal visits only. All assessments (both scheduled and unscheduled) will be mapped to an analysis visit according to the days relative to the first study drug dosing date (study day). The mutually exclusive analysis visit window is specified in Table 1.1 and Table 1.2 , based on protocol-defined target study day. Unless otherwise stated, if there are multiple assessments within an analysis visit window, the assessment collected in scheduled nominal visits will be used. If there are no valid assessments collected in scheduled nominal visits, then the one that is closest to the target study day will be used, unless two assessments that not scheduled on nominal visits are equally close, in which case the later assessment will be used.  By-subject listings will display the unscheduled or Early Termination (ET) visit as collected in Electronic Data Capture (EDC), without analysis visit mapping. But, study day will be included in subject listings.

Unscheduled or ET measurements will contribute to cross visit summaries, including sUA levels of <6.0 mg/dL sustained at Months 4, 5, and 6; AUC of sUA from baseline to Month 6; rate of gout flares from baseline to Month 6 (Every 3 months and overall); proportion of subjects reporting a gout flare up to each visit. (Every 3 months and overall); Maximum/ Minimum value during a time period, incidence of event during a time period, etc.

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



## SDTM/ADaM中Origin的填法

|Origin|Description|
|-|-|
|CRF|Data that was collected as part of a CRF and has an annotated CRF associated with the variable.|
|Protocol|Data that is defined as part of the Trial Design preparation. An example would be VSPOS (Vital Signs Position), which may be specified only in the protocol and not appear on a CRF or transferred via eDT.|
|eDT|Data that is received via an electronic Data Transfer (eDT) and usually does not have associated annotations. An origin of eDT refers to data collected via data streams such as laboratory, ECG, or IVRS.|
|Predecessor|Data that is copied from a variable in another dataset. For example, predecessor is used to link ADaM data back to SDTM variables to establish traceability.|
|Derived|Data that is not directly collected on the CRF or received via eDT, but is calculated by an algorithm or reproducible rule defined by the sponsor, which is dependent upon other data values.|
|Assigned|Data that is determined by individual judgment (by an evaluator other than the subject or investigator), rather than collected as part of the CRF, eDT or derived based on an algorithm. This may include third party attributions by an adjudicator. Coded terms that are supplied as part of a coding process (as in --DECOD) are considered to have an Origin of "Assigned". Values that are set independently of any subject-related data values in order to complete SDTM fields such as DOMAIN and --TESTCD are considered to have an Origin of "Assigned".|

### SDTM Origin

Possible SDTM values are **CRF**, **Derived**, **Assigned**, **Protocol**, **eDT**.

### ADaM Origin

- Origin should reflect the situation in the given ADaM dataset.
- Possible ADaM values are **Derived**, **Assigned**, **Predecessor**.
