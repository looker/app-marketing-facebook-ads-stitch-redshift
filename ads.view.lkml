include: "ads_adapter.view"
include: "adcreative.view"
include: "adsets.view"

explore: ads_nested_joins_base {
  extension: required

  join: ads__conversion_specs {
    view_label: "Ads: Conversion Specs"
    sql: LEFT JOIN UNNEST([${ads.conversion_specs}]) as ads__conversion_specs ;;
    relationship: one_to_one
  }

  join: ads__bid_info {
    view_label: "Ads: Bid Info"
    sql: LEFT JOIN UNNEST([${ads.bid_info}]) as ads__bid_info ;;
    relationship: one_to_one
  }

  join: ads__recommendations {
    view_label: "Ads: Recommendations"
    sql: LEFT JOIN UNNEST(${ads.recommendations}) as ads__recommendations ;;
    relationship: one_to_many
  }

  join: ads__targeting {
    view_label: "Ads: Targeting"
    sql: LEFT JOIN UNNEST([${ads.targeting}]) as ads__targeting ;;
    relationship: one_to_one
  }

  join: ads__targeting__friends_of_connections {
    view_label: "Ads: Targeting Friends Of Connections"
    sql: LEFT JOIN UNNEST(${ads__targeting.friends_of_connections}) as ads__targeting__friends_of_connections ;;
    relationship: one_to_many
  }

  join: ads__targeting__geo_locations__regions {
    view_label: "Ads: Targeting Geo Locations Regions"
    sql: LEFT JOIN UNNEST(${ads__targeting__geo_locations.regions}) as ads__targeting__geo_locations__regions ;;
    relationship: one_to_many
  }

  join: ads__targeting__geo_locations {
    view_label: "Ads: Targeting Geo Locations"
    sql: LEFT JOIN UNNEST([${ads__targeting.geo_locations}]) as ads__targeting__geo_locations ;;
    relationship: one_to_one
  }

  join: ads__targeting__geo_locations__cities {
    view_label: "Ads: Targeting Geo Locations Cities"
    sql: LEFT JOIN UNNEST(${ads__targeting__geo_locations.cities}) as ads__targeting__geo_locations__cities ;;
    relationship: one_to_many
  }

  join: ads__targeting__geo_locations__countries {
    view_label: "Ads: Targeting Geo Locations Countries"
    sql: LEFT JOIN UNNEST(${ads__targeting__geo_locations.countries}) as ads__targeting__geo_locations__countries ;;
    relationship: one_to_many
  }

  join: ads__targeting__geo_locations__location_types {
    view_label: "Ads: Targeting Geo Locations Location Types"
    sql: LEFT JOIN UNNEST(${ads__targeting__geo_locations.location_types}) as ads__targeting__geo_locations__location_types ;;
    relationship: one_to_many
  }

  join: ads__targeting__geo_locations__zips {
    view_label: "Ads: Targeting Geo Locations Zips"
    sql: LEFT JOIN UNNEST(${ads__targeting__geo_locations.zips}) as ads__targeting__geo_locations__zips ;;
    relationship: one_to_many
  }

  join: ads__targeting__custom_audiences {
    view_label: "Ads: Targeting Custom Audiences"
    sql: LEFT JOIN UNNEST(${ads__targeting.custom_audiences}) as ads__targeting__custom_audiences ;;
    relationship: one_to_many
  }

  join: ads__targeting__flexible_spec__work_positions {
    view_label: "Ads: Targeting Flexible Spec Work Positions"
    sql: LEFT JOIN UNNEST(${ads__targeting__flexible_spec.work_positions}) as ads__targeting__flexible_spec__work_positions ;;
    relationship: one_to_many
  }

  join: ads__targeting__flexible_spec__friends_of_connections {
    view_label: "Ads: Targeting Flexible Spec Friends Of Connections"
    sql: LEFT JOIN UNNEST(${ads__targeting__flexible_spec.friends_of_connections}) as ads__targeting__flexible_spec__friends_of_connections ;;
    relationship: one_to_many
  }

  join: ads__targeting__flexible_spec__behaviors {
    view_label: "Ads: Targeting Flexible Spec Behaviors"
    sql: LEFT JOIN UNNEST(${ads__targeting__flexible_spec.behaviors}) as ads__targeting__flexible_spec__behaviors ;;
    relationship: one_to_many
  }

  join: ads__targeting__flexible_spec__interests {
    view_label: "Ads: Targeting Flexible Spec Interests"
    sql: LEFT JOIN UNNEST(${ads__targeting__flexible_spec.interests}) as ads__targeting__flexible_spec__interests ;;
    relationship: one_to_many
  }

  join: ads__targeting__flexible_spec__connections {
    view_label: "Ads: Targeting Flexible Spec Connections"
    sql: LEFT JOIN UNNEST(${ads__targeting__flexible_spec.connections}) as ads__targeting__flexible_spec__connections ;;
    relationship: one_to_many
  }

  join: ads__targeting__flexible_spec__work_employers {
    view_label: "Ads: Targeting Flexible Spec Work Employers"
    sql: LEFT JOIN UNNEST(${ads__targeting__flexible_spec.work_employers}) as ads__targeting__flexible_spec__work_employers ;;
    relationship: one_to_many
  }

  join: ads__targeting__interests {
    view_label: "Ads: Targeting Interests"
    sql: LEFT JOIN UNNEST(${ads__targeting.interests}) as ads__targeting__interests ;;
    relationship: one_to_many
  }

  join: ads__tracking_specs {
    view_label: "Ads: Tracking Specs"
    sql: LEFT JOIN UNNEST([${ads.tracking_specs}]) as ads__tracking_specs ;;
    relationship: one_to_one
  }

  join: ads__targeting__flexible_spec {
    view_label: "Ads: Targeting Flexible Spec"
    sql: LEFT JOIN UNNEST(${ads__targeting.flexible_spec}) as ads__targeting__flexible_spec ;;
    relationship: one_to_one
  }
}

explore: ads {
  extends: [ads_nested_joins_base]
  hidden: yes

  join: adcreative {
    type: left_outer
    sql_on: ${ads.creative_id} = ${adcreative.id} ;;
    relationship: one_to_one
  }

  join: adsets {
    type: left_outer
    sql_on: ${ads.adset_id} = ${adsets.id} ;;
    relationship: many_to_one
  }

  join: campaigns {
    type: left_outer
    sql_on: ${ads.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }
}

view: ads {
  extends: ["stitch_base", "ads_adapter"]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }

  dimension: account_id {
    type: string
    hidden: yes
  }

  dimension: adset_id {
    type: string
    hidden: yes
  }

  dimension: bid_amount {
    type: number
  }

  dimension: bid_info {
    hidden: yes
  }

  dimension: bid_type {
    type: string
    sql: ${TABLE}.bid_type ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
    hidden: yes
  }

  dimension: conversion_specs {
    hidden: yes
    sql: ${TABLE}.conversion_specs ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_time ;;
  }

  dimension: creative_id {
    type: string
    sql: ${TABLE}.creative.id ;;
    hidden: yes
  }

  dimension: effective_status {
    type: string
    sql: ${TABLE}.effective_status ;;
  }

  dimension: last_updated_by_app_id {
    type: string
    sql: ${TABLE}.last_updated_by_app_id ;;
    hidden: yes
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: recommendations {
    hidden: yes
    sql: ${TABLE}.recommendations ;;
  }

  dimension: source_ad_id {
    type: string
    sql: ${TABLE}.source_ad_id ;;
    hidden: yes
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: status_active {
    type: yesno
    sql: ${status} = "ACTIVE" ;;
  }

  dimension: targeting {
    hidden: yes
    sql: ${TABLE}.targeting ;;
  }

  dimension: tracking_specs {
    hidden: yes
    sql: ${TABLE}.tracking_specs ;;
  }

  dimension_group: updated {
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

view: ads__conversion_specs {
  dimension: action_type {
    hidden: yes
    type: string
    sql: ${TABLE}.action_type ;;
  }

  dimension: conversion_id {
    hidden: yes
    type: string
    sql: ${TABLE}.conversion_id ;;
  }

  dimension: leadgen {
    hidden: yes
    type: string
    sql: ${TABLE}.leadgen ;;
  }

  dimension: page {
    hidden: yes
    type: string
    sql: ${TABLE}.page ;;
  }

  dimension: post {
    hidden: yes
    type: string
    sql: ${TABLE}.post ;;
  }

  dimension: post_wall {
    hidden: yes
    type: string
    sql: ${TABLE}.post_wall ;;
  }
}

view: ads__bid_info {
  dimension: actions {
    hidden: yes
    type: number
    sql: ${TABLE}.actions ;;
  }
}

view: ads__recommendations {
  dimension: blame_field {
    hidden: yes
    type: string
    sql: ${TABLE}.blame_field ;;
  }

  dimension: code {
    hidden: yes
    type: number
    sql: ${TABLE}.code ;;
  }

  dimension: confidence {
    hidden: yes
    type: string
    sql: ${TABLE}.confidence ;;
  }

  dimension: importance {
    hidden: yes
    type: string
    sql: ${TABLE}.importance ;;
  }

  dimension: message {
    hidden: yes
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: title {
    hidden: yes
    type: string
    sql: ${TABLE}.title ;;
  }
}

view: ads__targeting {
  dimension: age_max {
    hidden: yes
    type: number
    sql: ${TABLE}.age_max ;;
  }

  dimension: age_min {
    hidden: yes
    type: number
    sql: ${TABLE}.age_min ;;
  }

  dimension: audience_network_positions {
    hidden: yes
    type: string
    sql: ${TABLE}.audience_network_positions ;;
  }

  dimension: custom_audiences {
    hidden: yes
    sql: ${TABLE}.custom_audiences ;;
  }

  dimension: device_platforms {
    hidden: yes
    type: string
    sql: ${TABLE}.device_platforms ;;
  }

  dimension: facebook_positions {
    hidden: yes
    type: string
    sql: ${TABLE}.facebook_positions ;;
  }

  dimension: flexible_spec {
    hidden: yes
    sql: ${TABLE}.flexible_spec ;;
  }

  dimension: friends_of_connections {
    hidden: yes
    sql: ${TABLE}.friends_of_connections ;;
  }

  dimension: geo_locations {
    hidden: yes
    sql: ${TABLE}.geo_locations ;;
  }

  dimension: instagram_positions {
    hidden: yes
    type: string
    sql: ${TABLE}.instagram_positions ;;
  }

  dimension: interests {
    hidden: yes
    sql: ${TABLE}.interests ;;
  }

  dimension: messenger_positions {
    hidden: yes
    type: string
    sql: ${TABLE}.messenger_positions ;;
  }

  dimension: publisher_platforms {
    hidden: yes
    type: string
    sql: ${TABLE}.publisher_platforms ;;
  }

  dimension: targeting_optimization {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_optimization ;;
  }
}

view: ads__targeting__friends_of_connections {
  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: ads__targeting__geo_locations__regions {
  dimension: country {
    hidden: yes
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: key {
    hidden: yes
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: ads__targeting__geo_locations {
  dimension: cities {
    hidden: yes
    sql: ${TABLE}.cities ;;
  }

  dimension: countries {
    hidden: yes
    sql: ${TABLE}.countries ;;
  }

  dimension: location_types {
    hidden: yes
    sql: ${TABLE}.location_types ;;
  }

  dimension: regions {
    hidden: yes
    sql: ${TABLE}.regions ;;
  }

  dimension: zips {
    hidden: yes
    sql: ${TABLE}.zips ;;
  }
}

view: ads__targeting__geo_locations__cities {
  dimension: country {
    hidden: yes
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: distance_unit {
    hidden: yes
    type: string
    sql: ${TABLE}.distance_unit ;;
  }

  dimension: key {
    hidden: yes
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: radius {
    hidden: yes
    type: number
    sql: ${TABLE}.radius ;;
  }

  dimension: region {
    hidden: yes
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: region_id {
    hidden: yes
    type: string
    sql: ${TABLE}.region_id ;;
  }
}

view: ads__targeting__geo_locations__countries {
  dimension: country {
    hidden: yes
    type: string
    map_layer_name: countries
    sql: ${TABLE} ;;
  }
}

view: ads__targeting__geo_locations__location_types {
  dimension: location_type {
    hidden: yes
    type: string
    sql: ${TABLE} ;;
  }
}

view: ads__targeting__geo_locations__zips {
  dimension: country {
    hidden: yes
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: key {
    hidden: yes
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: primary_city_id {
    hidden: yes
    type: number
    sql: ${TABLE}.primary_city_id ;;
  }

  dimension: region_id {
    hidden: yes
    type: number
    sql: ${TABLE}.region_id ;;
  }
}

view: ads__targeting__custom_audiences {
  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: ads__targeting__flexible_spec__work_positions {
  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: ads__targeting__flexible_spec__friends_of_connections {
  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: ads__targeting__flexible_spec__behaviors {
  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: ads__targeting__flexible_spec__interests {
  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: ads__targeting__flexible_spec__connections {
  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: ads__targeting__flexible_spec__work_employers {
  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: ads__targeting__interests {
  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: ads__tracking_specs {
  dimension: action_type {
    hidden: yes
    type: string
    sql: ${TABLE}.action_type ;;
  }

  dimension: fb_pixel {
    hidden: yes
    type: string
    sql: ${TABLE}.fb_pixel ;;
  }

  dimension: page {
    hidden: yes
    type: string
    sql: ${TABLE}.page ;;
  }

  dimension: post {
    hidden: yes
    type: string
    sql: ${TABLE}.post ;;
  }

  dimension: post_wall {
    hidden: yes
    type: string
    sql: ${TABLE}.post_wall ;;
  }
}

view: ads__targeting__flexible_spec {
  dimension: behaviors {
    hidden: yes
    sql: ${TABLE}.behaviors ;;
  }

  dimension: connections {
    hidden: yes
    sql: ${TABLE}.connections ;;
  }

  dimension: friends_of_connections {
    hidden: yes
    sql: ${TABLE}.friends_of_connections ;;
  }

  dimension: interests {
    hidden: yes
    sql: ${TABLE}.interests ;;
  }

  dimension: work_employers {
    hidden: yes
    sql: ${TABLE}.work_employers ;;
  }

  dimension: work_positions {
    hidden: yes
    sql: ${TABLE}.work_positions ;;
  }
}
