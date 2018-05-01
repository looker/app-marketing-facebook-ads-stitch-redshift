include: "adset_fact.view"

explore: ad_date_fact {
  hidden: yes
  from: ad_date_fact
  view_name: fact
  label: "Ad This Period"
  view_label: "Ad This Period"
  join: last_fact {
    from: ad_date_fact
    view_label: "Ad Prior Period"
    sql_on: ${fact.account_id} = ${last_fact.account_id} AND
      ${fact.campaign_id} = ${last_fact.campaign_id} AND
      ${fact.adset_id} = ${last_fact.adset_id} AND
      ${fact.ad_id} = ${last_fact.ad_id} AND
      ${fact.date_last_period} = ${last_fact.date_period} AND
      ${fact.date_day_of_period} = ${last_fact.date_day_of_period} ;;
    relationship: one_to_one
    fields: [last_fact.ad_metrics_set*]
  }
  join: parent_fact {
    view_label: "Adset This Period"
    from: adset_date_fact
    sql_on: ${fact.account_id} = ${parent_fact.account_id} AND
      ${fact.campaign_id} = ${parent_fact.campaign_id} AND
      ${fact.adset_id} = ${parent_fact.adset_id} AND
      ${fact.date_date} = ${parent_fact.date_date};;
    relationship: many_to_one
    fields: [parent_fact.ad_metrics_set*]
  }
}

view: ad_key_base {
  extends: [account_key_base]
  extension: required

  dimension: ad_key_base {
    hidden: yes
    sql: CONCAT(${adset_key_base}, "-", CAST(${ad_id} as STRING)) ;;
  }
  dimension: key_base {
    hidden: yes
    sql: ${ad_key_base} ;;
  }
}

view: ad_date_fact {
  extends: [adset_date_fact, ad_key_base]

  derived_table: {
    explore_source: ad_impressions {
      column: ad_id { field: fact.ad_id }
      column: ad_name { field: fact.ad_name }
    }
  }
  dimension: ad_id {
    hidden: yes
  }
  dimension: ad_name {}
  set: detail {
    fields: [account_id, campaign_id, adset_id, ad_id]
  }
}