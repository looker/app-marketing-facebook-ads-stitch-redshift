include: "ad_metrics_parent_comparison_base.view"
include: "account_fact.view"

explore: campaign_date_fact {
  hidden: yes
  from: campaign_date_fact
  view_name: fact
  label: "Campaign This Period"
  view_label: "Campaign This Period"
  join: last_fact {
    from: campaign_date_fact
    view_label: "Campaign Prior Period"
    sql_on: ${fact.account_id} = ${last_fact.account_id} AND
      ${fact.campaign_id} = ${last_fact.campaign_id} AND
      ${fact.date_last_period} = ${last_fact.date_period} AND
      ${fact.date_day_of_period} = ${last_fact.date_day_of_period} ;;
    relationship: one_to_one
    fields: [last_fact.ad_metrics_set*]
  }
  join: parent_fact {
    view_label: "Account This Period"
    from: account_date_fact
    sql_on: ${fact.account_id} = ${parent_fact.account_id} AND
      ${fact.date_date} = ${parent_fact.date_date};;
    relationship: many_to_one
    fields: [parent_fact.ad_metrics_set*]
  }
}

view: campaign_key_base {
  extends: [account_key_base]
  extension: required

  dimension: campaign_key_base {
    hidden: yes
    sql: CONCAT(${account_key_base}, "-", CAST(${campaign_id} as STRING)) ;;
  }
  dimension: key_base {
    hidden: yes
    sql: ${campaign_key_base} ;;
  }
}

view: campaign_date_fact {
  extends: [ad_metrics_parent_comparison_base, account_date_fact, campaign_key_base]

  derived_table: {
    explore_source: ad_impressions {
      column: campaign_id { field: fact.campaign_id }
      column: campaign_name { field: fact.campaign_name }
    }
  }
  dimension: campaign_id {
    hidden: yes
  }
  dimension: campaign_name {}
  set: detail {
    fields: [account_id, campaign_id]
  }
}