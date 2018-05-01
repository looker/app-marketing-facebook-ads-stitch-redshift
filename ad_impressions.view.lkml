include: "adcreative.view"
include: "ad_impressions_adapter.view"
include: "insights_base.view"

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
}

explore: ad_impressions_base {
  extension: required
  extends: [ad_impressions_nested_joins_base, campaigns_nested_joins_base, adsets_nested_joins_base, ads_nested_joins_base, adcreative_nested_joins_base]
  view_name: fact
  label: "Ad Impressions"
  view_label: "Ad Impressions"

  join: campaigns {
    type: left_outer
    sql_on: ${fact.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: adsets {
    type: left_outer
    sql_on: ${fact.adset_id} = ${adsets.id} ;;
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
}

explore: ad_impressions {
  extension: required
  extends: [ad_impressions_base]
  hidden: yes
  from: ad_impressions

  join: ads_insights__relevance_score {
    view_label: "Ads Insights: Relevance Score"
    sql: LEFT JOIN UNNEST([${fact.relevance_score}]) as ads_insights__relevance_score ;;
    relationship: one_to_one
  }
}

view: ad_impressions {
  extends: [insights_base, ad_impressions_adapter]

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    expression: concat(${_date}, ${account_id}, ${campaign_id}, ${adset_id}, ${ad_id}) ;;
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

view: ad_impressions_platform_and_device {
  extends: [insights_base, ad_impressions_platform_and_device_adapter]

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    expression: concat(${_date}, ${account_id}, ${campaign_id}, ${adset_id}, ${ad_id},
    ${impression_device}, ${platform_position}, ${publisher_platform}) ;;
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

  dimension: platform_position {
    type: string
  }

  dimension: publisher_platform {
    type: string
  }
}

view: ad_impressions_country {
  extends: [insights_base, ad_impressions_country_adapter]

  dimension: country {
    type: string
    map_layer_name: countries
  }
}

view: ad_impressions_age_and_gender {
  extends: [insights_base, ad_impressions_age_and_gender_adapter]

  dimension: age {
    type: string
  }

  dimension: gender {
    type: string
  }
}
