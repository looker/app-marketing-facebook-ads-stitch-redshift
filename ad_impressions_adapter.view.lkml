include: "config.view"

view: ad_impressions_adapter {
  extension: required
  extends: [config]
  sql_table_name:
  {% if (fact.impression_device._in_query or fact.device_type._in_query or fact.platform_position._in_query or fact.publisher_platform._in_query) %}
 (
  SELECT facebook_ads_ads_insights_platform_and_device.*
  FROM {{ fact.facebook_ads_schema._sql }}.ads_insights_platform_and_device AS facebook_ads_ads_insights_platform_and_device
  INNER JOIN (
    SELECT
        MAX(_sdc_sequence) AS seq
        , ad_id
        , adset_id
        , campaign_id
        , date_start
        , publisher_platform
        , platform_position
        , impression_device
    FROM {{ fact.facebook_ads_schema._sql }}.ads_insights_platform_and_device
    GROUP BY ad_id, adset_id, campaign_id, date_start, publisher_platform, platform_position, impression_device
  ) AS max_ads_insights_platform_and_device
  ON facebook_ads_ads_insights_platform_and_device.ad_id = max_ads_insights_platform_and_device.ad_id
  AND facebook_ads_ads_insights_platform_and_device.adset_id = max_ads_insights_platform_and_device.adset_id
  AND facebook_ads_ads_insights_platform_and_device.campaign_id = max_ads_insights_platform_and_device.campaign_id
  AND facebook_ads_ads_insights_platform_and_device.date_start = max_ads_insights_platform_and_device.date_start
  AND facebook_ads_ads_insights_platform_and_device.publisher_platform = max_ads_insights_platform_and_device.publisher_platform
  AND facebook_ads_ads_insights_platform_and_device.platform_position = max_ads_insights_platform_and_device.platform_position
  AND facebook_ads_ads_insights_platform_and_device.impression_device = max_ads_insights_platform_and_device.impression_device
  AND facebook_ads_ads_insights_platform_and_device._sdc_sequence = max_ads_insights_platform_and_device.seq
)
  {% elsif (fact.country._in_query) %}
(
  SELECT facebook_ads_ads_insights_country.*
  FROM {{ fact.facebook_ads_schema._sql }}.ads_insights_country AS facebook_ads_ads_insights_country
  INNER JOIN (
    SELECT
        MAX(_sdc_sequence) AS seq
        , ad_id
        , adset_id
        , campaign_id
        , date_start
        , country
    FROM {{ fact.facebook_ads_schema._sql }}.ads_insights_country
    GROUP BY ad_id, adset_id, campaign_id, date_start, country
  ) AS max_ads_insights_country
  ON facebook_ads_ads_insights_country.ad_id = max_ads_insights_country.ad_id
  AND facebook_ads_ads_insights_country.adset_id = max_ads_insights_country.adset_id
  AND facebook_ads_ads_insights_country.campaign_id = max_ads_insights_country.campaign_id
  AND facebook_ads_ads_insights_country.date_start = max_ads_insights_country.date_start
  AND facebook_ads_ads_insights_country.country = max_ads_insights_country.country
  AND facebook_ads_ads_insights_country._sdc_sequence = max_ads_insights_country.seq
)
  {% elsif (fact.age._in_query or fact.gender._in_query) %}
(
  SELECT facebook_ads_ads_insights_age_and_gender.*
  FROM {{ fact.facebook_ads_schema._sql }}.ads_insights_age_and_gender AS facebook_ads_ads_insights_age_and_gender
  INNER JOIN (
    SELECT
        MAX(_sdc_sequence) AS seq
        , ad_id
        , adset_id
        , campaign_id
        , date_start
        , age
        , gender
    FROM {{ fact.facebook_ads_schema._sql }}.ads_insights_age_and_gender
    GROUP BY ad_id, adset_id, campaign_id, date_start, age, gender
  ) AS max_ads_insights_age_and_gender
  ON facebook_ads_ads_insights_age_and_gender.ad_id = max_ads_insights_age_and_gender.ad_id
  AND facebook_ads_ads_insights_age_and_gender.adset_id = max_ads_insights_age_and_gender.adset_id
  AND facebook_ads_ads_insights_age_and_gender.campaign_id = max_ads_insights_age_and_gender.campaign_id
  AND facebook_ads_ads_insights_age_and_gender.date_start = max_ads_insights_age_and_gender.date_start
  AND facebook_ads_ads_insights_age_and_gender.age = max_ads_insights_age_and_gender.age
  AND facebook_ads_ads_insights_age_and_gender.gender = max_ads_insights_age_and_gender.gender
  AND facebook_ads_ads_insights_age_and_gender._sdc_sequence = max_ads_insights_age_and_gender.seq
)
  {% else %}
(
  SELECT facebook_ads_ads_insights.*
  FROM {{ fact.facebook_ads_schema._sql }}.ads_insights AS facebook_ads_ads_insights
  INNER JOIN (
    SELECT
        MAX(_sdc_sequence) AS seq
        , ad_id
        , adset_id
        , campaign_id
        , date_start
    FROM {{ fact.facebook_ads_schema._sql }}.ads_insights
    GROUP BY ad_id, adset_id, campaign_id, date_start
  ) AS max_ads_insights
  ON facebook_ads_ads_insights.ad_id = max_ads_insights.ad_id
  AND facebook_ads_ads_insights.adset_id = max_ads_insights.adset_id
  AND facebook_ads_ads_insights.campaign_id = max_ads_insights.campaign_id
  AND facebook_ads_ads_insights.date_start = max_ads_insights.date_start
  AND facebook_ads_ads_insights._sdc_sequence = max_ads_insights.seq
)
  {% endif %} ;;
}