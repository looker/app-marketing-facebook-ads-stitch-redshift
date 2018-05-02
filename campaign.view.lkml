include: "/app_marketing_analytics_config/facebook_ads_config.view"

include: "account.view.lkml"
include: "stitch_base.view.lkml"

explore: campaign_nested_joins_base {
  extension: required

  join: campaign__ads__data {
    view_label: "campaign: Ads Data"
    sql: LEFT JOIN UNNEST(${campaign__ads.data}) as campaign__ads__data ;;
    relationship: one_to_many
  }

  join: campaign__ads {
    view_label: "campaign: Ads"
    sql: LEFT JOIN UNNEST([${campaign.ads}]) as campaign__ads ;;
    relationship: one_to_one
  }
}

explore: campaign_fb_adapter {
  view_name: campaign
  from: campaign_fb_adapter
  extends: [campaign_nested_joins_base]
  hidden: yes

  join: account {
    from: account_fb_adapter
    type: left_outer
    sql_on: ${campaign.account_id} = ${account.id} ;;
    relationship: many_to_one
  }
}

view: campaign_fb_adapter {
  extends: [stitch_base, facebook_ads_config]
  sql_table_name: {{ campaign.facebook_ads_schema._sql }}.campaigns ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }

  dimension: account_id {
    hidden: yes
    type: string
  }

  dimension: ads {
    hidden: yes
  }

  dimension: buying_type {
    type: string
  }

  dimension: effective_status {
    type: string
  }

  dimension: name {
    type: string
  }

  dimension: objective {
    type: string
  }

  dimension_group: start {
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
    sql: ${TABLE}.start_time ;;
  }

  dimension_group: updated {
    hidden: yes
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
    sql: ${TABLE}.updated_time ;;
  }
}

view: campaign__ads__data {
  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }
}

view: campaign__ads {
  dimension: data {
    hidden: yes
  }
}
