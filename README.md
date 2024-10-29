# Analysis of marketing campaigns

## Data

There are 4 tables:
1. google_ads_basic_daily:
   ad_date - the date of the launch of the advertising in google;
   campaign_name - name of advertisement campaign in google;
   adset_name - name of google advertising;
   spend - advertising cost;
   impressions - number of ad impressions;
   reach - ad reach (how many unique people viewed the ad);
   clicks - the number of visits to the advertiser's site after the advertisement;
   leads - the number of potential customers who provided their contact information;
   value - ad revenue;
   url_parameters - values ​​of the measured parameters from the url address.
2.  facebook_ads_basic_daily:
   ad_date - the date of the launch of the advertising in facebook;
   campaign_id - id of facebook advertisement campaign;
   adset_id - id of advertising in facebook;
   spend - asvertising cost;
   impressions - number of ad impressions;
   reach - ad reach (how many unique people viewed the ad);
   clicks - the number of visits to the advertiser's site after the advertisement;
   leads - the number of potential customers who provided their contact information;
   value - ad revenue;
   url_parameters - values ​​of the measured parameters from the url address.
3. facebook_campaign:
   campaign_id - id of advertisement campaign in facebook;
   campaign_name - name of advertisement campaign in facebook.
4. facebook_adset:
   adset_name - name of advertising in facebook;
   adset_id - id of facebook advertising.

## Tools

SQL, Looker studio.

## Goals

The main goal is to boost advertising strategies, and optimize marketing efforts.

## What metrics were observed

For each ad campaign was calculated: spends, impressions, clicks, income, CPM, ROMI, CTR and CPC. Preparation query are in the "Script-advertising_1", results are [there](https://lookerstudio.google.com/reporting/7626cbef-f329-447e-a435-60cc7ace02ce).

## Source and utm campaigns comparison

For each source (google and facebook) was calculated the same metrics as for campaigns, query are in the "Script_source_comparison". 
For each utm campaign was calculated the same metrics and were compared with results in previous month. Query are in "Script-advertising_2". Also was calculated a rating of each campaign by month based on metric values (in "Script-advertising_3").

