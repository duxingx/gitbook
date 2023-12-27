# SAS Skills

## unicode特殊字符

## proc format picutre的bug处理

当percent=9.96时，put(percent,pcta.)结果为0的问题

<pre class="language-sas" data-overflow="wrap"><code class="lang-sas"><strong>proc format;
</strong><strong>        picture pcta(round)
</strong>                0-&#x3C;10   ='9.9)' (prefix=' (  ')
                10-&#x3C;100='99.9)' (prefix=' ( ')
                100   ='999  )' (prefix=' (')
         ;
 run;
 data test;
         set tfl;
         if (9.95 &#x3C;= percent &#x3C; 10) or (99.95 &#x3C;= percent &#x3C; 100) then do;
                 percent = round(percent, 2);
         end;
 run;
</code></pre>
