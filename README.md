# Facebook Ads

LookML files for a Facebook block compatible with [Stitch's Facebook Ads Insights ETL](https://www.stitchdata.com/integrations/facebook-ads/).

To use this block, you will need to:

Create a `app_marketing_analytics_config` project that is assumed by the manifest.lkml. This configuration requires a facebook_ads_config.view.lkml file

For example:

```LookML
view: facebook_ads_config {
  extension: required

  dimension: facebook_ads_schema {
    hidden: yes
    sql:facebook_ads_stitch;;
  }
}
```

For a reference of all of the fields names and definitions reference Facebook’s API documentation for [breakdowns](https://developers.facebook.com/docs/marketing-api/insights/breakdowns) and [parameters](https://developers.facebook.com/docs/marketing-api/insights/parameters).
