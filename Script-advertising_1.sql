

WITH CTE25 as( --creating table with all campaigns and count of spends, impressions, clicks and values
SELECT ad_date,
'facebook_ads' as media_source,
campaign_name,
adset_name,
spend,
impressions,
reach,
clicks,
leads,
value
FROM facebook_ads_basic_daily fabd
left join facebook_campaign c on fabd.campaign_id=c.campaign_id
left join facebook_adset a on fabd.adset_id=a.adset_id
UNION ALL
SELECT ad_date,
'google_ads' as media_source,
campaign_name,
adset_name,
spend,
impressions,
reach,
clicks,
leads,
value
FROM google_ads_basic_daily gabd)
select ad_date, media_source, sum(spend) as sumofspends, sum(impressions) as countofimpressions, sum(clicks) as sumofclicks, sum(value) as sumofvalue 
from CTE25
group by 1, 2


