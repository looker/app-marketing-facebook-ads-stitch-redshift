include: "/app_marketing_analytics_config/facebook_ads_config.view"

include: "adcreative.view"
include: "insights_base.view"

explore: ad_impressions_nested_joins_base_fb_adapter {
  extension: required

  join: ads_insights__video_30_sec_watched_actions {
    view_label: "Ads Insights: Video 30 Sec Watched Actions"
    sql_on:
      ${fact.ad_id} = ${ads_insights__video_30_sec_watched_actions.ad_id} AND
      ${fact.adset_id} = ${ads_insights__video_30_sec_watched_actions.adset_id} AND
      ${fact.campaign_id} = ${ads_insights__video_30_sec_watched_actions.campaign_id} AND
      ${fact.date_start_raw} = ${ads_insights__video_30_sec_watched_actions.date_start_raw} ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p75_watched_actions {
    view_label: "Ads Insights: Video P75 Watched Actions"
    sql_on:
      ${fact.ad_id} = ${ads_insights__video_p75_watched_actions.ad_id} AND
      ${fact.adset_id} = ${ads_insights__video_p75_watched_actions.adset_id} AND
      ${fact.campaign_id} = ${ads_insights__video_p75_watched_actions.campaign_id} AND
      ${fact.date_start_raw} = ${ads_insights__video_p75_watched_actions.date_start_raw} ;;
      relationship: one_to_many
  }

  join: ads_insights__video_p95_watched_actions {
    view_label: "Ads Insights: Video P95 Watched Actions"
    sql_on:
      ${fact.ad_id} = ${ads_insights__video_p95_watched_actions.ad_id} AND
      ${fact.adset_id} = ${ads_insights__video_p95_watched_actions.adset_id} AND
      ${fact.campaign_id} = ${ads_insights__video_p95_watched_actions.campaign_id} AND
      ${fact.date_start_raw} = ${ads_insights__video_p95_watched_actions.date_start_raw} ;;
    relationship: one_to_many
  }

  join: ads_insights__actions {
    view_label: "Ads Insights: Actions"
    sql_on:
      ${fact.ad_id} = ${ads_insights__actions.ad_id} AND
      ${fact.adset_id} = ${ads_insights__actions.adset_id} AND
      ${fact.campaign_id} = ${ads_insights__actions.campaign_id} AND
      ${fact.date_start_raw} = ${ads_insights__actions.date_start_raw} ;;
    relationship: one_to_many
  }

  join: ads_insights__video_15_sec_watched_actions {
    view_label: "Ads Insights: Video 15 Sec Watched Actions"
    sql_on:
      ${fact.ad_id} = ${ads_insights__video_p75_watched_actions.ad_id} AND
      ${fact.adset_id} = ${ads_insights__video_p75_watched_actions.adset_id} AND
      ${fact.campaign_id} = ${ads_insights__video_p75_watched_actions.campaign_id} AND
      ${fact.date_start_raw} = ${ads_insights__video_p75_watched_actions.date_start_raw} ;;
    relationship: one_to_many
  }

  join: ads_insights__video_10_sec_watched_actions {
    view_label: "Ads Insights: Video 10 Sec Watched Actions"
    sql_on:
      ${fact.ad_id} = ${ads_insights__video_10_sec_watched_actions.ad_id} AND
      ${fact.adset_id} = ${ads_insights__video_10_sec_watched_actions.adset_id} AND
      ${fact.campaign_id} = ${ads_insights__video_10_sec_watched_actions.campaign_id} AND
      ${fact.date_start_raw} = ${ads_insights__video_10_sec_watched_actions.date_start_raw} ;;
    relationship: one_to_many
  }

  join: ads_insights__unique_actions {
    view_label: "Ads Insights: Unique Actions"
    sql: LEFT JOIN UNNEST(${fact.unique_actions}) as ads_insights__unique_actions ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p25_watched_actions {
    view_label: "Ads Insights: Video P25 Watched Actions"
    sql_on:
      ${fact.ad_id} = ${ads_insights__video_p25_watched_actions.ad_id} AND
      ${fact.adset_id} = ${ads_insights__video_p25_watched_actions.adset_id} AND
      ${fact.campaign_id} = ${ads_insights__video_p25_watched_actions.campaign_id} AND
      ${fact.date_start_raw} = ${ads_insights__video_p25_watched_actions.date_start_raw} ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p100_watched_actions {
    view_label: "Ads Insights: Video P100 Watched Actions"
    sql_on:
      ${fact.ad_id} = ${ads_insights__video_p100_watched_actions.ad_id} AND
      ${fact.adset_id} = ${ads_insights__video_p100_watched_actions.adset_id} AND
      ${fact.campaign_id} = ${ads_insights__video_p100_watched_actions.campaign_id} AND
      ${fact.date_start_raw} = ${ads_insights__video_p100_watched_actions.date_start_raw} ;;
    relationship: one_to_many
  }

  join: ads_insights__video_p50_watched_actions {
    view_label: "Ads Insights: Video P50 Watched Actions"
    sql_on:
      ${fact.ad_id} = ${ads_insights__video_p50_watched_actions.ad_id} AND
      ${fact.adset_id} = ${ads_insights__video_p50_watched_actions.adset_id} AND
      ${fact.campaign_id} = ${ads_insights__video_p50_watched_actions.campaign_id} AND
      ${fact.date_start_raw} = ${ads_insights__video_p50_watched_actions.date_start_raw} ;;
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
    sql_on:
      ${fact.ad_id}  = ${ads_insights__relevance_score.ad_id} AND
      ${fact.adset_id} = ${ads_insights__relevance_score.adset_id} AND
      ${fact.campaign_id} = ${ads_insights__relevance_score.campaign_id};;
    relationship: one_to_one
  }
}

view: ad_impressions_fb_adapter {
  extends: [insights_base, facebook_ads_config]
  sql_table_name:
  (
    SELECT facebook_ads_ads_insights.*
    FROM {{ facebook_ads_schema._sql }}.facebook_ads_insights_{{ facebook_account_id._sql }} AS facebook_ads_ads_insights
    INNER JOIN (
      SELECT
          MAX(_sdc_sequence) AS seq
          , ad_id
          , adset_id
          , campaign_id
          , date_start
      FROM {{ facebook_ads_schema._sql }}.facebook_ads_insights_{{ facebook_account_id._sql }}
      -- fact.faceb
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
    sql: CAST(${_date} AS VARCHAR)
      || '|'::text || ${account_id}
      || '|'::text || ${campaign_id}
      || '|'::text || ${adset_id}
      || '|'::text || ${ad_id} ;;
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
  FROM {{ facebook_ads_schema._sql }}.facebook_ads_insights_age_and_gender_{{ facebook_account_id._sql }} AS facebook_ads_ads_insights_age_and_gender
  INNER JOIN (
  SELECT
      MAX(_sdc_sequence) AS seq
      , ad_id
      , adset_id
      , campaign_id
      , date_start
      , age
      , gender
  FROM {{ facebook_ads_schema._sql }}.facebook_ads_insights_age_and_gender_{{ facebook_account_id._sql }}
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
    sql: CAST(${_date} AS VARCHAR)
      || '|'::text || ${account_id}
      || '|'::text || ${campaign_id}
      || '|'::text || ${adset_id}
      || '|'::text || ${ad_id}
      || '|'::text || ${age}
      || '|'::text || ${gender};;
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
  FROM {{ facebook_ads_schema._sql }}.facebook_ads_insights_country_{{ facebook_account_id._sql }} AS facebook_ads_ads_insights_country
  INNER JOIN (
    SELECT
        MAX(_sdc_sequence) AS seq
        , ad_id
        , adset_id
        , campaign_id
        , date_start
        , country
    FROM {{ facebook_ads_schema._sql }}.facebook_ads_insights_country_{{ facebook_account_id._sql }}
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
    sql: CAST(${_date} as VARCHAR)
      || '|'::text || ${account_id}
      || '|'::text || ${campaign_id}
      || '|'::text || ${adset_id}
      || '|'::text || ${ad_id}
      || '|'::text || ${country} ;;
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
    FROM {{ facebook_ads_schema._sql }}.facebook_ads_insights_placement_and_device_{{ facebook_account_id._sql }} AS facebook_ads_ads_insights_platform_and_device
    INNER JOIN (
      SELECT
          MAX(_sdc_sequence) AS seq
          , ad_id
          , adset_id
          , campaign_id
          , date_start
          , placement
          , impression_device
      FROM {{ facebook_ads_schema._sql }}.facebook_ads_insights_placement_and_device_{{ facebook_account_id._sql }}
      GROUP BY ad_id, adset_id, campaign_id, date_start, placement, impression_device
    ) AS max_ads_insights_platform_and_device
    ON facebook_ads_ads_insights_platform_and_device.ad_id = max_ads_insights_platform_and_device.ad_id
    AND facebook_ads_ads_insights_platform_and_device.adset_id = max_ads_insights_platform_and_device.adset_id
    AND facebook_ads_ads_insights_platform_and_device.campaign_id = max_ads_insights_platform_and_device.campaign_id
    AND facebook_ads_ads_insights_platform_and_device.date_start = max_ads_insights_platform_and_device.date_start
    AND facebook_ads_ads_insights_platform_and_device.placement = max_ads_insights_platform_and_device.placement
    AND facebook_ads_ads_insights_platform_and_device.impression_device = max_ads_insights_platform_and_device.impression_device
    AND facebook_ads_ads_insights_platform_and_device._sdc_sequence = max_ads_insights_platform_and_device.seq
  ) ;;

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: CAST(${_date} AS VARCHAR)
      || '|'::text || ${account_id}
      || '|'::text || ${campaign_id}
      || '|'::text || ${adset_id}
      || '|'::text || ${ad_id}
      || '|'::text || ${impression_device}
      || '|'::text || ${platform_position} ;;
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
    sql: ${TABLE}.placement ;;
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
    sql: 'NA'::text ;;
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
