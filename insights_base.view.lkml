view: insights_base {
  extension: required

  dimension: frequency {
    hidden: yes
    type: number
    sql: ${TABLE}.frequency ;;
  }

  dimension: reach {
    hidden: yes
    type: number
    sql: ${TABLE}.reach ;;
  }

  dimension: spend {
    hidden: yes
    type: number
    sql: ${TABLE}.spend ;;
  }

  dimension: impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: total_actions {
    hidden: yes
    type: number
    sql: ${TABLE}.total_actions ;;
  }

  dimension: total_action_value {
    hidden: yes
    type: number
    sql: ${TABLE}.total_action_value ;;
  }

  dimension: account_id {
    hidden:  yes
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: actions {
    hidden: yes
    sql: ${TABLE}.actions ;;
  }

  dimension: ad_id {
    hidden:  yes
    type: string
    sql: ${TABLE}.ad_id ;;
  }

  dimension: ad_name {
    type: string
    sql: ${TABLE}.ad_name ;;
  }

  dimension: adset_id {
    hidden:  yes
    type: string
    sql: ${TABLE}.adset_id ;;
  }

  dimension: adset_name {
    type: string
    sql: ${TABLE}.adset_name ;;
  }

  dimension: campaign_id {
    hidden:  yes
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: canvas_avg_view_percent {
    hidden: yes
    type: number
    sql: ${TABLE}.canvas_avg_view_percent ;;
  }

  dimension: canvas_avg_view_time {
    hidden: yes
    type: number
    sql: ${TABLE}.canvas_avg_view_time ;;
  }

  dimension: cost_per_inline_link_click {
    hidden: yes
    type: number
    sql: ${TABLE}.cost_per_inline_link_click ;;
  }

  dimension: cost_per_inline_post_engagement {
    hidden: yes
    type: number
    sql: ${TABLE}.cost_per_inline_post_engagement ;;
  }

  dimension: cost_per_total_action {
    hidden: yes
    type: number
    sql: ${TABLE}.cost_per_total_action ;;
  }

  dimension: cost_per_unique_click {
    hidden: yes
    type: number
    sql: ${TABLE}.cost_per_unique_click ;;
  }

  dimension: cost_per_unique_inline_link_click {
    hidden: yes
    type: number
    sql: ${TABLE}.cost_per_unique_inline_link_click ;;
  }

  dimension: cpc {
    hidden: yes
    type: number
    sql: ${TABLE}.cpc ;;
  }

  dimension: cpm {
    hidden: yes
    type: number
    sql: ${TABLE}.cpm ;;
  }

  dimension: cpp {
    hidden: yes
    type: number
    sql: ${TABLE}.cpp ;;
  }

  dimension: ctr {
    hidden: yes
    type: number
    sql: ${TABLE}.ctr ;;
  }

  dimension: _date {
    hidden: yes
    type: date_raw
    sql: CAST(${TABLE}.date_start AS DATE) ;;
  }

  dimension_group: date_start {
    hidden: yes
    type: time
    label: "Start"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date_start ;;
    allow_fill: no
  }

  dimension_group: date_stop {
    hidden:  yes
    label: "Stop"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date_stop ;;
  }

  dimension: inline_link_click_ctr {
    hidden: yes
    type: number
    sql: ${TABLE}.inline_link_click_ctr ;;
  }

  dimension: inline_link_clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.inline_link_clicks ;;
  }

  dimension: inline_post_engagement {
    hidden: yes
    type: number
    sql: ${TABLE}.inline_post_engagement ;;
  }

  dimension: objective {
    hidden: yes
    type: string
    sql: ${TABLE}.objective ;;
  }

  dimension: social_clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.social_clicks ;;
  }

  dimension: social_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.social_impressions ;;
  }

  dimension: social_reach {
    hidden: yes
    type: number
    sql: ${TABLE}.social_reach ;;
  }

  dimension: total_unique_actions {
    hidden: yes
    type: number
    sql: ${TABLE}.total_unique_actions ;;
  }

  dimension: unique_actions {
    hidden: yes
    sql: ${TABLE}.unique_actions ;;
  }

  dimension: unique_clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.unique_clicks ;;
  }

  dimension: unique_ctr {
    hidden: yes
    type: number
    sql: ${TABLE}.unique_ctr ;;
  }

  dimension: unique_inline_link_click_ctr {
    hidden: yes
    type: number
    sql: ${TABLE}.unique_inline_link_click_ctr ;;
  }

  dimension: unique_inline_link_clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.unique_inline_link_clicks ;;
  }

  dimension: unique_link_clicks_ctr {
    hidden: yes
    type: number
    sql: ${TABLE}.unique_link_clicks_ctr ;;
  }

  dimension: unique_social_clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.unique_social_clicks ;;
  }

  dimension: video_10_sec_watched_actions {
    hidden: yes
    sql: ${TABLE}.video_10_sec_watched_actions ;;
  }

  dimension: video_15_sec_watched_actions {
    hidden: yes
    sql: ${TABLE}.video_15_sec_watched_actions ;;
  }

  dimension: video_30_sec_watched_actions {
    hidden: yes
    sql: ${TABLE}.video_30_sec_watched_actions ;;
  }

  dimension: video_p100_watched_actions {
    hidden: yes
    sql: ${TABLE}.video_p100_watched_actions ;;
  }

  dimension: video_p25_watched_actions {
    hidden: yes
    sql: ${TABLE}.video_p25_watched_actions ;;
  }

  dimension: video_p50_watched_actions {
    hidden: yes
    sql: ${TABLE}.video_p50_watched_actions ;;
  }

  dimension: video_p75_watched_actions {
    hidden: yes
    sql: ${TABLE}.video_p75_watched_actions ;;
  }

  dimension: video_p95_watched_actions {
    hidden: yes
    sql: ${TABLE}.video_p95_watched_actions ;;
  }

  dimension: website_ctr {
    hidden: yes
    sql: ${TABLE}.website_ctr ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      account_name,
      campaign_name,
      adsets_name,
      ad_name
    ]
  }
}

view: ads_insights__actions_website_base {
  extension: required
  dimension: action_destination {
    hidden: yes
    type: string
    sql: ${TABLE}.action_destination ;;
  }

  dimension: action_target_id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.action_target_id ;;
  }

  dimension: action_type {
    hidden: yes
    type: string
    sql: ${TABLE}.action_type ;;
  }

  dimension: value {
    hidden: yes
    type: number
    sql: ${TABLE}.value ;;
  }

  dimension: offsite_conversion_value {
    hidden: yes
    type: number
    sql: CASE WHEN (${action_type} = 'offsite_conversion') THEN ${value} ELSE NULL END ;;
  }
}

view: ads_insights__actions_base {
  extends: [ads_insights__actions_website_base]
  extension: required
  dimension: _1d_click {
    hidden: yes
    type: number
    sql: ${TABLE}._1d_click ;;
  }

  dimension: _1d_view {
    hidden: yes
    type: number
    sql: ${TABLE}._1d_view ;;
  }

  dimension: _28d_click {
    hidden: yes
    type: number
    sql: ${TABLE}._28d_click ;;
  }

  dimension: _28d_view {
    hidden: yes
    type: number
    sql: ${TABLE}._28d_view ;;
  }

  dimension: _7d_click {
    hidden: yes
    type: number
    sql: ${TABLE}._7d_click ;;
  }

  dimension: _7d_view {
    hidden: yes
    type: number
    sql: ${TABLE}._7d_view ;;
  }
}

view: ads_insights__video_30_sec_watched_actions {
  extends: [ads_insights__actions_base]
}

view: ads_insights__video_p75_watched_actions {
  extends: [ads_insights__actions_base]
}

view: ads_insights__video_p95_watched_actions {
  extends: [ads_insights__actions_base]
}

view: ads_insights__actions {
  extends: [ads_insights__actions_base]
}

view: ads_insights__website_ctr {
  extends: [ads_insights__actions_website_base]
}

view: ads_insights__video_15_sec_watched_actions {
  extends: [ads_insights__actions_base]
}

view: ads_insights__video_10_sec_watched_actions {
  extends: [ads_insights__actions_base]
}

view: ads_insights__unique_actions {
  extends: [ads_insights__actions_base]
}

view: ads_insights__video_p25_watched_actions {
  extends: [ads_insights__actions_base]
}

view: ads_insights__video_p100_watched_actions {
  extends: [ads_insights__actions_base]
}

view: ads_insights__video_p50_watched_actions {
  extends: [ads_insights__actions_base]
}
