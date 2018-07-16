include: "/app_marketing_analytics_config/facebook_ads_config.view"

include: "adcreative.view"
include: "insights_base.view"

explore: ad_impressions_nested_joins_base_fb_adapter {
  extension: required

  join: ads_insights__video_30_sec_watched_actions {
    view_label: "Ads Insights: Video 30 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${fact.video_30_sec_watched_actions}) as ads_insights__video_30_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p75_watched_actions {
    view_label: "Ads Insights: Video P75 Watched Actions"
    sql: LEFT JOIN UNNEST(${fact.video_p75_watched_actions}) as ads_insights__video_p75_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p95_watched_actions {
    view_label: "Ads Insights: Video P95 Watched Actions"
    sql: LEFT JOIN UNNEST(${fact.video_p95_watched_actions}) as ads_insights__video_p95_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__actions {
    view_label: "Ads Insights: Actions"
    sql: LEFT JOIN UNNEST(${fact.actions}) as ads_insights__actions ;;
    relationship: one_to_many
  }

  join: ads_insights__website_ctr {
    view_label: "Ads Insights: Website Ctr"
    sql: LEFT JOIN UNNEST(${fact.website_ctr}) as ads_insights__website_ctr ;;
    relationship: one_to_many
  }

  join: ads_insights__video_15_sec_watched_actions {
    view_label: "Ads Insights: Video 15 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${fact.video_15_sec_watched_actions}) as ads_insights__video_15_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_10_sec_watched_actions {
    view_label: "Ads Insights: Video 10 Sec Watched Actions"
    sql: LEFT JOIN UNNEST(${fact.video_10_sec_watched_actions}) as ads_insights__video_10_sec_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__unique_actions {
    view_label: "Ads Insights: Unique Actions"
    sql: LEFT JOIN UNNEST(${fact.unique_actions}) as ads_insights__unique_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p25_watched_actions {
    view_label: "Ads Insights: Video P25 Watched Actions"
    sql: LEFT JOIN UNNEST(${fact.video_p25_watched_actions}) as ads_insights__video_p25_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p100_watched_actions {
    view_label: "Ads Insights: Video P100 Watched Actions"
    sql: LEFT JOIN UNNEST(${fact.video_p100_watched_actions}) as ads_insights__video_p100_watched_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p50_watched_actions {
    view_label: "Ads Insights: Video P50 Watched Actions"
    sql: LEFT JOIN UNNEST(${fact.video_p50_watched_actions}) as ads_insights__video_p50_watched_actions ;;
    relationship: one_to_many
  }
}

explore: ad_impressions_base_fb_adapter {
  extension: required
  extends: [ad_impressions_nested_joins_base_fb_adapter, campaign_nested_joins_base, adset_nested_joins_base, ad_nested_joins_base, adcreative_nested_joins_base]
  view_name: fact
  label: "Ad Impressions"
  view_label: "Ad Impressions"

  join: campaign {
    from: campaign_fb_adapter
    type: left_outer
    sql_on: ${fact.campaign_id} = ${campaign.id} ;;
    relationship: many_to_one
  }

  join: adset {
    from: adset_fb_adapter
    type: left_outer
    sql_on: ${fact.adset_id} = ${adset.id} ;;
    relationship: many_to_one
  }

  join: ad {
    from: ad_fb_adapter
    type: left_outer
    sql_on: ${fact.ad_id} = ${ad.id} ;;
    relationship: many_to_one
  }

  join: adcreative {
    from: adcreative_fb_adapter
    type: left_outer
    sql_on: ${ad.creative_id} = ${adcreative.id} ;;
    relationship: one_to_one
  }
}

explore: ad_impressions_fb_adapter {
  persist_with: facebook_ads_etl_datagroup
  extends: [ad_impressions_base_fb_adapter]
  hidden: yes
  from: ad_impressions_fb_adapter

  join: ads_insights__relevance_score {
    view_label: "Ads Insights: Relevance Score"
    sql: LEFT JOIN UNNEST([${fact.relevance_score}]) as ads_insights__relevance_score ;;
    relationship: one_to_one
  }
}

view: ad_impressions_fb_adapter {
  extends: [insights_base, facebook_ads_config]
  sql_table_name:
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
  ) ;;

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: concat(CAST(${_date} AS STRING)
      ,"|", ${account_id}
      ,"|", ${campaign_id}
      ,"|", ${adset_id}
      ,"|", ${ad_id}
    ) ;;
  }

  dimension: call_to_action_clicks {
    hidden: yes
    type: number
  }

  dimension: relevance_score {
    hidden: yes
  }

  dimension: social_spend {
    hidden: yes
    type: number
  }
}

explore: ad_impressions_age_and_gender_fb_adapter {
  persist_with: facebook_ads_etl_datagroup
  extends: [ad_impressions_base_fb_adapter]
  hidden: yes
  from: ad_impressions_age_and_gender_fb_adapter
}

view: ad_impressions_age_and_gender_fb_adapter {
  extends: [insights_base, facebook_ads_config]
  sql_table_name:
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
  ) ;;

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: concat(CAST(${_date} AS STRING)
      ,"|", ${account_id}
      ,"|", ${campaign_id}
      ,"|", ${adset_id}
      ,"|", ${ad_id}
      ,"|", ${age}
      ,"|", ${gender}
    ) ;;
  }

  dimension: age {
    type: string
  }

  dimension: gender_raw {
    hidden: yes
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: gender {
    type: string
    case: {
      when: {
        sql: ${gender_raw} = 'male' ;;
        label: "Male"
      }
      when: {
        sql: ${gender_raw} = 'female' ;;
        label: "Female"
      }
      when: {
        sql: ${gender_raw} = 'unknown';;
        label: "Unknown"
      }
      else: "Other"
    }
  }
}

explore: ad_impressions_geo_fb_adapter {
  persist_with: facebook_ads_etl_datagroup
  extends: [ad_impressions_base_fb_adapter]
  hidden: yes
  from: ad_impressions_geo_fb_adapter
}

view: ad_impressions_geo_fb_adapter {
  extends: [insights_base, facebook_ads_config]
  sql_table_name:
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
  ) ;;

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: concat(CAST(${_date} AS STRING)
      ,"|", ${account_id}
      ,"|", ${campaign_id}
      ,"|", ${adset_id}
      ,"|", ${ad_id}
      ,"|", ${country}
    ) ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
  }
}

explore: ad_impressions_platform_and_device_fb_adapter {
  persist_with: facebook_ads_etl_datagroup
  extends: [ad_impressions_base_fb_adapter]
  hidden: yes
  from: ad_impressions_platform_and_device_fb_adapter
}

view: ad_impressions_platform_and_device_fb_adapter {
  extends: [insights_base, facebook_ads_config]
  sql_table_name:
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
  ) ;;

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: concat(CAST(${_date} AS STRING)
      ,"|", ${account_id}
      ,"|", ${campaign_id}
      ,"|", ${adset_id}
      ,"|", ${ad_id}
      ,"|", ${impression_device}
      ,"|", ${platform_position}
      ,"|", ${publisher_platform}
    ) ;;
  }

  dimension: impression_device {
    hidden: yes
    type: string
  }

  dimension: device_type {
    type: string
    case: {
      when: {
        sql: ${impression_device} = 'desktop' ;;
        label: "Desktop"
      }
      when: {
        sql: ${impression_device} = 'iphone' OR ${impression_device} = 'android_smartphone' ;;
        label: "Mobile"
      }
      when: {
        sql: ${impression_device} = 'ipad'  OR ${impression_device} = 'android_tablet' ;;
        label: "Tablet"
      }
      else: "Other"
    }
  }


  dimension: platform_position_raw {
    hidden: yes
    type: string
    sql: ${TABLE}.platform_position ;;
  }

  dimension: platform_position {
    type: string
    case: {
      when: {
        sql: ${platform_position_raw} = 'feed' AND ${publisher_platform_raw} = 'instagram' ;;
        label: "Feed"
      }
      when: {
        sql: ${platform_position_raw} = 'feed' ;;
        label: "News Feed"
      }
      when: {
        sql: ${platform_position_raw} = 'an_classic' ;;
        label: "Classic"
      }
      when: {
        sql: ${platform_position_raw} = 'all_placements' ;;
        label: "All"
      }
      when: {
        sql: ${platform_position_raw} = 'instant_article' ;;
        label: "Instant Article"
      }
      when: {
        sql: ${platform_position_raw} = 'right_hand_column' ;;
        label: "Right Column"
      }
      when: {
        sql: ${platform_position_raw} = 'rewarded_video' ;;
        label: "Rewarded Video"
      }
      when: {
        sql: ${platform_position_raw} = 'suggested_video' ;;
        label: "Suggested Video"
      }
      when: {
        sql: ${platform_position_raw} = 'instream_video' ;;
        label: "InStream Video"
      }
      when: {
        sql: ${platform_position_raw} = 'messenger_inbox' ;;
        label: "Messenger Home"
      }
      else: "Other"
    }
  }

  dimension: publisher_platform_raw {
    hidden: yes
    type: string
    sql: ${TABLE}.publisher_platform ;;
  }

  dimension: publisher_platform {
    type: string
    label: "Platform"
    case: {
      when: {
        sql: ${publisher_platform_raw} = 'facebook' ;;
        label: "Facebook"
      }
      when: {
        sql: ${publisher_platform_raw} = 'instagram' ;;
        label: "Instagram"
      }
      when: {
        sql: ${publisher_platform_raw} = 'audience_network';;
        label: "Audience Network"
      }
      when: {
        sql: ${publisher_platform_raw} = 'messenger';;
        label: "Messenger"
      }
      else: "Other"
    }
  }
}
