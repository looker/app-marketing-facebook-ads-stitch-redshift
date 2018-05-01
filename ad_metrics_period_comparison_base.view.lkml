view: ad_metrics_period_comparison_base {
  extension: required

  dimension: impressions_period_delta {
    hidden: yes
    type: number
    sql: ${fact.impressions} - ${last_fact.impressions} ;;
    group_label: "Period Comparisons"
  }
  dimension: clicks_period_delta {
    hidden: yes
    type: number
    sql: ${fact.clicks} - ${last_fact.clicks} ;;
    group_label: "Period Comparisons"
  }
  dimension: conversions_period_delta {
    hidden: yes
    type: number
    sql: ${fact.conversions} - ${last_fact.conversions} ;;
    group_label: "Period Comparisons"
  }
  dimension: conversionvalue_period_delta {
    hidden: yes
    type: number
    sql: ${fact.conversionvalue} - ${last_fact.conversionvalue} ;;
    group_label: "Period Comparisons"
  }
  dimension: click_rate_period_percent_change {
    hidden: yes
    type: number
    sql: (${fact.click_rate} - ${last_fact.click_rate}) / NULLIF(${last_fact.click_rate}, 0) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  dimension: click_rate_period_percent_change_abs {
    hidden: yes
    type: number
    sql: abs(${fact.click_rate_period_percent_change}) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  dimension: conversion_rate_period_percent_change {
    hidden: yes
    type: number
    sql: (${fact.conversion_rate} - ${last_fact.conversion_rate}) / NULLIF(${last_fact.conversion_rate}, 0) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  dimension: conversion_rate_period_percent_change_abs {
    hidden: yes
    type: number
    sql: abs(${fact.conversion_rate_period_percent_change}) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  dimension: cost_per_click_period_percent_change {
    hidden: yes
    type: number
    sql: (${fact.cost_per_click} - ${last_fact.cost_per_click}) / NULLIF(${last_fact.cost_per_click}, 0) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  dimension: cost_per_click_period_percent_change_abs {
    hidden: yes
    type: number
    sql: abs(${fact.cost_per_click_period_percent_change}) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  dimension: cost_per_conversion_period_percent_change {
    hidden: yes
    type: number
    sql: (${fact.cost_per_conversion} - ${last_fact.cost_per_conversion}) / NULLIF(${last_fact.cost_per_conversion}, 0) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  dimension: cost_per_conversion_period_percent_change_abs {
    hidden: yes
    type: number
    sql: abs(${fact.cost_per_conversion_period_percent_change}) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  dimension: click_rate_period_z_score {
    hidden: yes
    type: number
    sql:
    (
      (${fact.click_rate}) -
      (${last_fact.click_rate})
    ) /
    NULLIF(SQRT(
      (${fact.clicks} + ${last_fact.clicks}) / (${fact.impressions} + ${last_fact.impressions}) *
      (1 - (${fact.clicks} + ${last_fact.clicks}) / (${fact.impressions} + ${last_fact.impressions})) *
      ((1 / NULLIF(${fact.impressions},0)) + (1 / NULLIF(${last_fact.impressions},0)))
    ),0) ;;
    group_label: "Period Comparisons"
    value_format_name: decimal_2
  }
  dimension: click_rate_period_significant {
    hidden: yes
    type: yesno
    sql:  (${fact.click_rate_period_z_score} > 1.96) OR
      (${fact.click_rate_period_z_score} < -1.96) ;;
    group_label: "Period Comparisons"
  }
  dimension: click_rate_period_better {
    hidden: yes
    type: yesno
    sql:  ${fact.click_rate} > ${last_fact.click_rate} ;;
    group_label: "Period Comparisons"
  }
  dimension: conversion_rate_period_z_score {
    hidden: yes
    type: number
    sql:
    (
      (${fact.conversion_rate}) -
      (${last_fact.conversion_rate})
    ) /
    NULLIF(SQRT(
      (${fact.conversions} + ${last_fact.conversions}) / (${fact.clicks} + ${last_fact.clicks}) *
      (1 - (${fact.conversions} + ${last_fact.conversions}) / (${fact.clicks} + ${last_fact.clicks})) *
      ((1 / NULLIF(${fact.clicks},0)) + (1 / NULLIF(${last_fact.clicks},0)))
    ),0) ;;
    group_label: "Period Comparisons"
    value_format_name: decimal_2
  }
  dimension: conversion_rate_period_significant {
    hidden: yes
    type: yesno
    sql:  (${fact.conversion_rate_period_z_score} > 1.96) OR
      (${fact.conversion_rate_period_z_score} < -1.96) ;;
    group_label: "Period Comparisons"
  }
  dimension: conversion_rate_period_better {
    hidden: yes
    type: yesno
    sql:  ${fact.conversion_rate} > ${last_fact.conversion_rate} ;;
    group_label: "Period Comparisons"
  }
  measure: total_cost_period_delta {
    hidden: yes
    type: number
    sql: ${fact.total_cost} - ${last_fact.total_cost} ;;
    group_label: "Period Comparisons"
  }
  measure: total_impressions_period_delta {
    hidden: yes
    type: number
    sql: ${fact.total_impressions} - ${last_fact.total_impressions} ;;
    group_label: "Period Comparisons"
  }
  measure: total_clicks_period_delta {
    hidden: yes
    type: number
    sql: ${fact.total_clicks} - ${last_fact.total_clicks} ;;
    group_label: "Period Comparisons"
  }
  measure: total_conversions_period_delta {
    hidden: yes
    type: number
    sql: ${fact.total_conversions} - ${last_fact.total_conversions} ;;
    group_label: "Period Comparisons"
  }
  measure: total_conversionvalue_period_delta {
    hidden: yes
    type: number
    sql: ${fact.total_conversionvalue} - ${last_fact.total_conversionvalue} ;;
    group_label: "Period Comparisons"
  }
  measure: average_click_rate_period_percent_change {
    hidden: yes
    type: number
    sql: (${fact.average_click_rate} - ${last_fact.average_click_rate}) / NULLIF(${last_fact.average_click_rate}, 0) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  measure: average_click_rate_period_percent_change_abs {
    hidden: yes
    type: number
    sql: abs(${fact.average_click_rate_period_percent_change}) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  measure: average_conversion_rate_period_percent_change {
    hidden: yes
    type: number
    sql: (${fact.average_conversion_rate} - ${last_fact.average_conversion_rate}) / NULLIF(${last_fact.average_conversion_rate}, 0) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  measure: average_conversion_rate_period_percent_change_abs {
    hidden: yes
    type: number
    sql: abs(${fact.average_conversion_rate_period_percent_change}) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  measure: average_cost_per_click_period_percent_change {
    hidden: yes
    type: number
    sql: (${fact.average_cost_per_click} - ${last_fact.average_cost_per_click}) / NULLIF(${last_fact.average_cost_per_click}, 0) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  measure: average_cost_per_click_period_percent_change_abs {
    hidden: yes
    type: number
    sql: abs(${fact.average_cost_per_click_period_percent_change}) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  measure: average_cost_per_conversion_period_percent_change {
    hidden: yes
    type: number
    sql: (${fact.average_cost_per_conversion} - ${last_fact.average_cost_per_conversion}) / NULLIF(${last_fact.average_cost_per_conversion}, 0) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  measure: average_cost_per_conversion_period_percent_change_abs {
    hidden: yes
    type: number
    sql: abs(${fact.average_cost_per_conversion_period_percent_change}) ;;
    group_label: "Period Comparisons"
    value_format_name: percent_1
  }
  measure: average_click_rate_period_z_score {
    hidden: yes
    type: number
    sql:
    (
      (${fact.average_click_rate}) -
      (${last_fact.average_click_rate})
    ) /
    NULLIF(SQRT(
      (${fact.total_clicks} + ${last_fact.total_clicks}) / (${fact.total_impressions} + ${last_fact.total_impressions}) *
      (1 - (${fact.total_clicks} + ${last_fact.total_clicks}) / (${fact.total_impressions} + ${last_fact.total_impressions})) *
      ((1 / NULLIF(${fact.total_impressions},0)) + (1 / NULLIF(${last_fact.total_impressions},0)))
    ),0) ;;
    group_label: "Period Comparisons"
    value_format_name: decimal_2
  }
  measure: average_click_rate_period_significant {
    hidden: yes
    type: yesno
    sql:  (${fact.average_click_rate_period_z_score} > 1.96) OR
      (${fact.average_click_rate_period_z_score} < -1.96) ;;
    group_label: "Period Comparisons"
  }
  measure: average_click_rate_period_better {
    hidden: yes
    type: yesno
    sql:  ${fact.average_click_rate} > ${last_fact.average_click_rate} ;;
    group_label: "Period Comparisons"
  }
  measure: average_conversion_rate_period_z_score {
    hidden: yes
    type: number
    sql:
    (
      (${fact.average_conversion_rate}) -
      (${last_fact.average_conversion_rate})
    ) /
    NULLIF(SQRT(
      (${fact.total_conversions} + ${last_fact.total_conversions}) / (${fact.total_clicks} + ${last_fact.total_clicks}) *
      (1 - (${fact.total_conversions} + ${last_fact.total_conversions}) / (${fact.total_clicks} + ${last_fact.total_clicks})) *
      ((1 / NULLIF(${fact.total_clicks},0)) + (1 / NULLIF(${last_fact.total_clicks},0)))
    ),0) ;;
    group_label: "Period Comparisons"
    value_format_name: decimal_2
  }
  measure: average_conversion_rate_period_significant {
    hidden: yes
    type: yesno
    sql:  (${fact.average_conversion_rate_period_z_score} > 1.96) OR
      (${fact.average_conversion_rate_period_z_score} < -1.96) ;;
    group_label: "Period Comparisons"
  }
  measure: average_conversion_rate_period_better {
    hidden: yes
    type: yesno
    sql:  ${fact.average_conversion_rate} > ${last_fact.average_conversion_rate} ;;
    group_label: "Period Comparisons"
  }

  dimension: cost_per_click_big_mover {
    hidden: yes
    type: yesno
    sql: ${cost_per_click_period_percent_change_abs} > .2 ;;
    group_label: "Period Comparisons"
  }
  dimension: cost_per_conversion_big_mover {
    hidden: yes
    type: yesno
    sql: ${cost_per_conversion_period_percent_change_abs} > .2 ;;
    group_label: "Period Comparisons"
  }

  dimension: conversion_rate_big_mover {
    hidden: yes
    type: yesno
    sql: ${conversion_rate_period_percent_change_abs} > .2 ;;
    group_label: "Period Comparisons"
  }

  dimension: click_rate_big_mover {
    hidden: yes
    type: yesno
    sql: ${click_rate_period_percent_change_abs} > .2 ;;
    group_label: "Period Comparisons"
  }

  measure: cost_per_conversion_count_big_mover {
    hidden: yes
    type: count_distinct
    sql: ${key_base} ;;
    filters: {
      field: cost_per_conversion_big_mover
      value: "Yes"
    }
    group_label: "Period Comparisons"
  }

  measure: conversion_rate_count_big_mover {
    hidden: yes
    type: count_distinct
    sql: ${key_base} ;;
    filters: {
      field: conversion_rate_big_mover
      value: "Yes"
    }
    group_label: "Period Comparisons"
  }

  measure: click_rate_count_big_mover {
    hidden: yes
    type: count_distinct
    sql: ${key_base} ;;
    filters: {
      field: click_rate_big_mover
      value: "Yes"
    }
    group_label: "Period Comparisons"
  }

  set: ad_metrics_period_comparison_set {
    fields: [
      cost_period_delta,
      clicks_period_delta,
      conversions_period_delta,
      impressions_period_delta,
      conversionvalue_period_delta,
      click_rate_period_percent_change,
      click_rate_period_percent_change_abs,
      conversion_rate_period_percent_change,
      conversion_rate_period_percent_change_abs,
      cost_per_click_period_percent_change,
      cost_per_click_period_percent_change_abs,
      cost_per_conversion_period_percent_change,
      cost_per_conversion_period_percent_change_abs,
      click_rate_period_z_score,
      click_rate_period_significant,
      click_rate_period_better,
      conversion_rate_period_z_score,
      conversion_rate_period_significant,
      conversion_rate_period_better,
      total_cost_period_delta,
      total_clicks_period_delta,
      total_conversions_period_delta,
      total_impressions_period_delta,
      total_conversionvalue_period_delta,
      average_click_rate_period_percent_change,
      average_click_rate_period_percent_change_abs,
      average_conversion_rate_period_percent_change,
      average_conversion_rate_period_percent_change_abs,
      average_cost_per_click_period_percent_change,
      average_cost_per_click_period_percent_change_abs,
      average_cost_per_conversion_period_percent_change,
      average_cost_per_conversion_period_percent_change_abs,
      average_click_rate_period_z_score,
      average_click_rate_period_significant,
      average_click_rate_period_better,
      average_conversion_rate_period_z_score,
      average_conversion_rate_period_significant,
      average_conversion_rate_period_better,
      cost_per_conversion_big_mover,
      conversion_rate_big_mover,
      click_rate_big_mover
    ]
  }

}
