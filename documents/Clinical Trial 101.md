# Clinical Trial 101

## 受试者临床试验流程

### 筛选期(Visit=Screening)

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

### 治疗期(VISIT=DAY 1/2/...)

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

### 治疗结束(VISIT=ET/EOT)

   1. 正常吃药并完成了整个治疗期(EOT="COMPLETED")：VISIT=End of Treatment
   2. 提前结束治疗试验(EOT="DISCONTINUED")：VISIT=Early Termination
   3. 疗效评估：QS/FA/LB

## 随访(VISIT=Follow-up)

   1. 治疗结束后进行安全随访和生存随访：VISIT=Follow-Up

## 研究结束(VISIT=EOS)

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
  - 可以获得主要指标的测量值（试验中主要指标的数据均可以获得）。
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

## Analysis Visit

### Baseline

- 一般用于分析的目的定义基线baseline为：**首次给药前的最后一次非空的评估**。
- 需要根据study protocol/SAP来确定：
  - 与首次给药同一天进行的计划内评估(schedule assessment)：被视为在给药前(pre-dose)进行的评估。
  - 与首次给药同一天进行的计划外评估(schedule assessment)：被视为在给药后(post-dose)进行的评估。
  - 随机但为给药的受试者将随机当天或之前的最后一次非空评估作为基线baseline。
  - 对于Lab数据：只有Central Lab Data才会考虑基线baseline的定义。

### Study Day

- 首次给药日期的Study Day=1。
- 如果评估日期在首次给药日期之前：
  - Study Day = (Date of assessment or interest - first study drug dosing date)
- 如果评估日期在首次给药日期当天或之后：
  - Study Day = (Date of assessment or interest - first study drug dosing date) + 1
- 一般来说只有评估日期和首次给药日期都存在的时候才会计算Study Day。但对于随机后但未给药的受试者有时可能需要额外考虑。
- 对于Post-Baseline的筛选方法：
  1. 因为Study Day(ADY)的本质就是和首次用药日期来判断，而Baseline是首次用药前的最后一次非空评估日期，所以Baseline的ADY理论上<=1, Post-Baseline的ADY>1。
  2. 如果对于Baseline的定义有额外的说明或者不寻常的方式，可以通过ABLFL=Y的日期来判断：ADY>ADY(ABLFL=Y)。

### Visit Window

- Visit-Window:

  - 所有(计划内和计划外的)评估将根据相对于首次研究药物给药日期（研究日）的天数映射到一个用于分析的访视(AVISIT/AVISITN)。分析访问窗口的定义一般是基于方案定义的目标研究日(Target Study Day)。如果在一个访视窗口内有多条评估记录，优先使用scheduled nominal visits；如果这些记录中没有scheduled nominal visits，然后选择距离target sutdy day最近的一条评估记录；如果在这种情况下还有多条记录距离target sutdy day同样近，选择靠后的一条。
  - Visit-Window的范围不能有重叠(overlap)，但可能会覆盖整个研究周期，在两个range之间也可能有间隔(gap)。
  - Follow-up Visit通常不会被定义在访视窗口中。

- scheduled nominal visit的使用：
  - 对于大部分的by-visit的summary table，由于primary analysis flag会选择scheduled visit，所以一般可以通过ANL0XFL来选择相应的记录。

- Unscheduled or ET的使用：
  - 一般对于by-subject的listing会呈现收集到的原始计划外的和ET visit，而不是mapping之后的avisit。
  - 此外用于cross visit summaries，一般会在SAP或shell中说明。

- 对超窗的理解
  - 在临床试验中，由于人力、环境及其他因素的影响，致某项操作时间超过方案允许的计划内正负时间范围，即称超窗。超窗应按照方案偏离上报。
  - 常见的超窗类型：访视超窗、检查检验超窗。
    - 访视超窗：访视超窗是指受试者未按照试验方案要求的时间返院
    - 检查检验超窗：检查/检验超窗是指受试者检查、检验结果超过试验方案规定的窗口期。
  - 超窗的处理：
    - 优先依据方案寻找处理建议：若在临床试验方案中，对随访超窗有了比较详细、可行的处理方法，按照方案规定相应执行即可。

## Endpoint

### 主要疗效指标(primary outcome/primary endpoint)

- 与研究主要目的直接相关，能确切反应药物有效性或安全性的观察指标。
- 通常一个临床试验主要指标只有一个。
- 根据实验目的的选择易于量化、客观性强、变异小、重复性高。
- 预先在protocol中明确定义。
- 用于试验样本量的估计。

### 次要疗效指标(secondary outcome/secondary endpoint)

- 与主要目的相关的辅助性指标，或与次要目的相关的指标。
- 通常有多个次要指标。
- 预先在protocol中明确定义。
- 只有当主要指标有统计学意义时，次要指标的统计分析结果才有参考价值。

### 伴发事件(Intercurrent events)

- 治疗开始后发生的事件，这些事件会影响与临床问题相关的测量结果的解释或存在。在描述所关注的临床问题时，有必要对伴发事件进行处理，以便精确定义所要估计的治疗效果。
- 处理伴发事件的五种最常用的策略：
  - 疗法策略(Treatment policy strategy)
  - 假想策略(Hypothetical strategy)
  - 复合变量策略(Composite variable strategy)
  - 在治策略(While on treatment strategy)
  - 主层策略(Pricipal stratum strategy)
- 常见的Intercurrent Events
  - 因不良反应退出治疗或减量
  - 因无疗效退出治疗
  - 因有效退出治疗
  - 其他原因退出治疗
  - 使用救援用药
  - 转组
  - 使用后线治疗
  - 因病死亡

### 估计目标的5个属性

估计目标是对治疗效果的精确描述，对试验目标和重点的详细化。

- 治疗(Treatments)：即受试者接受了实验组还是对照组的治疗，具体治疗内容是什么。针对受试者所在组别的不同，受试者接受的治疗可能不同。
- 人群(Population)：即该临床试验入组的受试者，不同治疗组的人群应该是相同的。
- 变量(Endpoint or Outcome)：即该估计目标所针对的主要终点是什么。
- 伴发事件及其处理策略(Intercurrent Event)：即受试者在接受指定治疗的过程中出现了哪些可以影响疗效准确性的时间。而处理策略，即针对该伴发事件我们可以采取哪些手段来尽可能的降低该事件对临床问题准确性的影响。同一个伴发事件针对不同的重点变量可能使用不同的处理策略。
- 群体层面汇总(Population-lvel Summary)：规定终点或结局变量在群体层面的汇总统计量。

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
