include: "date_base.view"
include: "adcreative.view"
include: "ad_transformations_base.view"
include: "ad_impressions_adapter.view"
include: "insights_base.view"
include: "period_base.view"

explore: ad_impressions_nested_joins_base {
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

  join: ads_insights__relevance_score {
    view_label: "Ads Insights: Relevance Score"
    sql: LEFT JOIN UNNEST([${fact.relevance_score}]) as ads_insights__relevance_score ;;
    relationship: one_to_one
  }
}

explore: ad_impressions {
  extends: [ad_impressions_nested_joins_base, campaigns_nested_joins_base, adsets_nested_joins_base, ads_nested_joins_base, adcreative_nested_joins_base]
  hidden: yes
  from: ad_impressions
  view_name: fact
  label: "Ad Impressions"
  view_label: "Ad Impressions"

  join: campaigns {
    type: left_outer
    sql_on: ${fact.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: ads {
    type: left_outer
    sql_on: ${fact.ad_id} = ${ads.id} ;;
    relationship: many_to_one
  }

  join: adcreative {
    type: left_outer
    sql_on: ${ads.creative_id} = ${adcreative.id} ;;
    relationship: one_to_one
  }

  join: adsets {
    type: left_outer
    sql_on: ${fact.adset_id} = ${adsets.id} ;;
    relationship: many_to_one
  }
}

view: ad_impressions {
  extends: ["stitch_base", "insights_base", "date_base", "period_base", "ad_transformations_base", "ad_impressions_adapter"]

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(CAST(${date_date} AS STRING)
      ,"|", CAST(${account_id} AS STRING)
      ,"|", CAST(${campaign_id} AS STRING)
      ,"|", CAST(${adset_id} AS STRING)
      ,"|", CAST(${ad_id} AS STRING)
      {% if (fact.impression_device._in_query or fact.device_type._in_query or fact.platform_position._in_query or fact.publisher_platform._in_query) %}
      ,"|", CAST(${impression_device} AS STRING),"|", CAST(${platform_position} AS STRING),"|", CAST(${publisher_platform} AS STRING)
      {% elsif (fact.country._in_query) %}
      ,"|", CAST(${country} AS STRING)
      {% elsif (fact.age._in_query or fact.gender._in_query) %}
      ,"|", CAST(${age} AS STRING),"|", CAST(${gender} AS STRING)
      {% endif %}
      ) ;;
  }

  dimension: age {
    type: string
    sql: ${TABLE}.age ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: impression_device {
    hidden: yes
    type: string
    sql: ${TABLE}.impression_device ;;
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

  dimension: platform_position {
    type: string
    sql: ${TABLE}.platform_position ;;
  }

  dimension: publisher_platform {
    type: string
    sql: ${TABLE}.publisher_platform ;;
  }

  dimension: call_to_action_clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.call_to_action_clicks ;;
  }

  dimension: relevance_score {
    hidden: yes
    sql: ${TABLE}.relevance_score ;;
  }

  dimension: social_spend {
    hidden: yes
    type: number
    sql: ${TABLE}.social_spend ;;
  }
}

view: ads_insights__relevance_score {
  dimension: negative_feedback {
    hidden: yes
    type: string
    sql: ${TABLE}.negative_feedback ;;
  }

  dimension: positive_feedback {
    hidden: yes
    type: string
    sql: ${TABLE}.positive_feedback ;;
  }

  dimension: score {
    hidden: yes
    type: number
    sql: ${TABLE}.score ;;
  }

  dimension: status {
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }
}