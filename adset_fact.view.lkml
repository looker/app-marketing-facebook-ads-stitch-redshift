include: "campaign_fact.view"

explore: adset_date_fact {
  hidden: yes
  from: adset_date_fact
  view_name: fact
  label: "Adset This Period"
  view_label: "Adset This Period"
  join: last_fact {
    from: adset_date_fact
    view_label: "Adset Prior Period"
    sql_on: ${fact.account_id} = ${last_fact.account_id} AND
      ${fact.campaign_id} = ${last_fact.campaign_id} AND
      ${fact.adset_id} = ${last_fact.adset_id} AND
      ${fact.date_last_period} = ${last_fact.date_period} AND
      ${fact.date_day_of_period} = ${last_fact.date_day_of_period} ;;
    relationship: one_to_one
    fields: [last_fact.ad_metrics_set*]
  }
  join: parent_fact {
    view_label: "Campaign This Period"
    from: campaign_date_fact
    sql_on: ${fact.account_id} = ${parent_fact.account_id} AND
      ${fact.campaign_id} = ${parent_fact.campaign_id} AND
      ${fact.date_date} = ${parent_fact.date_date};;
    relationship: many_to_one
    fields: [parent_fact.ad_metrics_set*]
  }
}

view: adset_key_base {
  extends: [account_key_base]
  extension: required

  dimension: adset_key_base {
    hidden: yes
    sql: CONCAT(${campaign_key_base}, "-", CAST(${adset_id} as STRING)) ;;
  }
  dimension: key_base {
    hidden: yes
    sql: ${adset_key_base} ;;
  }
}

view: adset_date_fact {
  extends: [campaign_date_fact, adset_key_base]

  derived_table: {
    explore_source: ad_impressions {
      column: adset_id { field: fact.adset_id }
      column: adset_name { field: fact.adset_name }
      column: daily_budget { field: adsets.total_daily_budget}
    }
  }
  dimension: adset_id {
    hidden: yes
  }
  dimension: adset_name {}

  # TODO consolidate this with AdWords budget reporting.
  dimension: daily_budget {
    hidden: yes
    type: number
    sql: ${TABLE}.daily_budget ;;
  }

  dimension: remaining_budget {
    hidden: yes
    type: number
    sql: ${daily_budget} - ${cost} ;;
    value_format_name: usd_0
  }
  dimension: percent_remaining_budget {
    hidden: yes
    type: number
    sql: ${remaining_budget} / NULLIF(${daily_budget},0) ;;
    value_format_name: percent_2
  }
  dimension: percent_used_budget {
    hidden: yes
    type: number
    sql: COALESCE(1 - ${percent_remaining_budget}, 0) ;;
    value_format_name: percent_2
  }
  dimension: percent_used_budget_tier {
    hidden: yes
    type: tier
    tiers: [0, 0.2, 0.4, 0.6, 0.8, 1]
    style: interval
    sql: ${percent_used_budget} ;;
    value_format_name: percent_2
  }
  dimension: constrained_budget {
    hidden: yes
    type: yesno
    description: "Daily spend within 20% of adset budget"
    sql:  ${percent_remaining_budget} <= .2 ;;
  }
  measure: total_daily_budget {
    hidden: yes
    type: sum
    sql: ${daily_budget} ;;
    value_format_name: usd_0
  }
  measure: total_cost {
    hidden: yes
    type: sum
    sql: ${cost} ;;
    value_format_name: usd_0
  }
  measure: count_constrained_budget_days {
    hidden: yes
    type: count_distinct
    description: "Days with daily spend within 20% of adset budget"
    sql:  CONCAT(CAST(${date_raw} as STRING), CAST(${adset_id} as STRING))  ;;
    filters: {
      field: constrained_budget
      value: "yes"
    }
  }
  set: detail {
    fields: [account_id, campaign_id, adset_id]
  }
}