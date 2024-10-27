--calculation spends, impressions, clicks, income, CPM, ROMI, CTR, CPC for each month and advertition campaign, comparison metrics CPM, ROMI, CTR, CPC with results in previous month: 
with CTE5 as(select ad_date, --TABLE WITH ALL data needed FOR google AND facebook campaigns
campaign_name, 
adset_name, 
spend, 
impressions,
reach, clicks, 
leads, 
value, 
url_parameters
from facebook_ads_basic_daily fabd 
left join facebook_campaign fc 
on fabd.campaign_id = fc.campaign_id 
left join facebook_adset fad 
on fabd.adset_id=fad.adset_id union all select * from google_ads_basic_daily),
CTE9 AS --extraction campaign AND calculating ALL mentioned metrics
(select date_trunc('month', ad_date) as ad_month, 
lag(date_trunc('month', ad_date), 1) over(partition by 
case when substring(url_parameters, 'utm_campaign=([^&]+)') like 'nan' then null else substring(url_parameters, 'utm_campaign=([^&]+)') end order by date_trunc('month', ad_date)) as prev_month,
case when substring(url_parameters, 'utm_campaign=([^&]+)') like 'nan' then null else substring(url_parameters, 'utm_campaign=([^&]+)') end as utm_campaign, 
case when sum(spend) = null then 0 else sum(spend) end as sumofspends, 
case when sum(impressions) = null then 0 else sum(impressions)::numeric end  as countofimpressions, 
case when sum(clicks) = null then 0 else sum(clicks) end as sumofclicks, 
case when sum(value) = null then 0 else sum(value) end as sumofvalue,
case when sum(impressions) = 0 then 0 else sum(spend)/sum(impressions)::numeric*1000 end as CPM,
case when sum(spend) = 0 then 0 else (sum(value)-sum(spend))/sum(spend)::numeric end as ROMI,
case when sum(impressions) = 0 then 0 else sum(clicks)/sum(impressions)::numeric*100 end as CTR,
case when sum(clicks) = 0 then 0 else sum(spend)/sum(clicks)::numeric end as CPC,
lag(case when sum(impressions)::numeric = 0 then 0 else sum(spend)/sum(impressions)::numeric*1000 end, 1) over(partition by case when substring(url_parameters, 'utm_campaign=([^&]+)') like 'nan' then null else substring(url_parameters, 'utm_campaign=([^&]+)') end order by date_trunc('month', ad_date)) as prev_CPM,
lag(case when sum(spend) = 0 then 0 else (sum(value)-sum(spend))/sum(spend)::numeric end,1) over(partition by case when substring(url_parameters, 'utm_campaign=([^&]+)') like 'nan' then null else substring(url_parameters, 'utm_campaign=([^&]+)') end order by date_trunc('month', ad_date)) as prev_ROMI,
lag(case when sum(impressions)::numeric = 0 then 0 else sum(clicks)/sum(impressions)::numeric*100 end, 1) over(partition by case when substring(url_parameters, 'utm_campaign=([^&]+)') like 'nan' then null else substring(url_parameters, 'utm_campaign=([^&]+)') end order by date_trunc('month', ad_date)) as prev_CTR,
lag(case when sum(clicks) = 0 then 0 else sum(spend)/sum(clicks)::numeric end, 1) over(partition by case when substring(url_parameters, 'utm_campaign=([^&]+)') like 'nan' then null else substring(url_parameters, 'utm_campaign=([^&]+)') end order by date_trunc('month', ad_date)) as prev_CPC
from CTE5 
group by ad_month, utm_campaign)
select *, --comparison CPM, ROMI, CTR and CPC metrics with results in previos month  
case when prev_CPM = 0 then 0 
else CPM/prev_CPM*100::numeric end as CPM_diff,
case when prev_ROMI = 0 then 0 
else ROMI/prev_ROMI*100::numeric end as ROMI_diff,
case when prev_CTR = 0 then 0 
else CTR/prev_CTR*100::numeric end as CTR_diff,
case when prev_CPC = 0 then 0 
else CPC/prev_CPC*100::numeric end as CPC_diff
from CTE9;