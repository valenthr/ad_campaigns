--facebook and google campaigns comparison
with CTE5 as(select ad_date, --TABLE WITH ALL data needed FOR google AND facebook campaigns
campaign_name, 
adset_name, 
spend, 
impressions,
reach, clicks, 
leads, 
value, url_parameters, 
'facebook' as source
from facebook_ads_basic_daily fabd 
left join facebook_campaign fc 
on fabd.campaign_id = fc.campaign_id 
left join facebook_adset fad 
on fabd.adset_id=fad.adset_id union all select *, 'google' as source from google_ads_basic_daily)
select source, case when sum(spend) = null then 0 else sum(spend) end as sumofspends, 
case when sum(impressions) = null then 0 else sum(impressions)::numeric end  as countofimpressions, 
case when sum(clicks) = null then 0 else sum(clicks) end as sumofclicks, 
case when sum(value) = null then 0 else sum(value) end as sumofvalue,
case when sum(impressions) = 0 then 0 else sum(spend)/sum(impressions)::numeric*1000 end as CPM,
case when sum(spend) = 0 then 0 else (sum(value)-sum(spend))/sum(spend)::numeric end as ROMI,
case when sum(impressions) = 0 then 0 else sum(clicks)/sum(impressions)::numeric*100 end as CTR,
case when sum(clicks) = 0 then 0 else sum(spend)/sum(clicks)::numeric end as CPC
from CTE5
group by source
