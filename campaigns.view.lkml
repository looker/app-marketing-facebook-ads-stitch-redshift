include: "campaigns_adapter.view.lkml"
include: "stitch_base.view.lkml"

explore: campaigns_nested_joins_base {
  extension: required

  join: campaigns__ads__data {
    view_label: "Campaigns: Ads Data"
    sql: LEFT JOIN UNNEST(${campaigns__ads.data}) as campaigns__ads__data ;;
    relationship: one_to_many
  }

  join: campaigns__ads {
    view_label: "Campaigns: Ads"
    sql: LEFT JOIN UNNEST([${campaigns.ads}]) as campaigns__ads ;;
    relationship: one_to_one
  }
}

explore: campaigns {
  extends: [campaigns_nested_joins_base]
  hidden: yes
}

view: campaigns {
  extends: ["campaigns_adapter", "stitch_base"]

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

view: campaigns__ads__data {
  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }
}

view: campaigns__ads {
  dimension: data {
    hidden: yes
  }
}
