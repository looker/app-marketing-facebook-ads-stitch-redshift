include: "/app_marketing_analytics_config/facebook_ads_config.view"
include: "adcreative.view"
include: "adset.view"

explore: ad_nested_joins_base {
  extension: required

  join: ad__conversion_specs__action_type {
    view_label: "Ad: Conversion Specs"
    from: ad__conversion_specs__action_type
    sql_on: ${ad.id} = ${ad__conversion_specs__action_type._sdc_source_key_id} ;;
    relationship: one_to_one
  }

  join: ad__conversion_specs__conversion_id {
    view_label: "Ad: Conversion Specs"
    from: ad__conversion_specs__conversion_id
    sql_on: ${ad.id} = ${ad__conversion_specs__conversion_id._sdc_source_key_id} ;;
    relationship: one_to_one
  }

  join: ad__conversion_specs__page {
    view_label: "Ad: Conversion Specs"
    from: ad__conversion_specs__page
    sql_on: ${ad.id} = ${ad__conversion_specs__page._sdc_source_key_id} ;;
    relationship: one_to_one
  }

  join: ad__conversion_specs__post {
    view_label: "Ad: Conversion Specs"
    from: ad__conversion_specs__post
    sql_on: ${ad.id} = ${ad__conversion_specs__post._sdc_source_key_id} ;;
    relationship: one_to_one
  }

  join: ad__conversion_specs__post_wall {
    view_label: "Ad: Conversion Specs"
    from: ad__conversion_specs__post_wall
    sql_on: ${ad.id} = ${ad__conversion_specs__post_wall._sdc_source_key_id} ;;
    relationship: one_to_one
  }

  join: ad__bid_info {
    view_label: "Ad: Bid Info"
    sql: LEFT JOIN UNNEST([${ad.bid_info}]) as ad__bid_info ;;
    relationship: one_to_one
  }

  join: ad__recommendations {
    view_label: "Ad: Recommendations"
    sql: LEFT JOIN UNNEST(${ad.recommendations}) as ad__recommendations ;;
    relationship: one_to_many
  }

  join: ad__targeting {
    view_label: "Ad: Targeting"
    sql: LEFT JOIN UNNEST([${ad.targeting}]) as ad__targeting ;;
    relationship: one_to_one
  }

  join: ad__targeting__friends_of_connections {
    view_label: "Ad: Targeting Friends Of Connections"
    sql: LEFT JOIN UNNEST(${ad__targeting.friends_of_connections}) as ad__targeting__friends_of_connections ;;
    relationship: one_to_many
  }

  join: ad__targeting__geo_locations__regions {
    view_label: "Ad: Targeting Geo Locations Regions"
    sql: LEFT JOIN UNNEST(${ad__targeting__geo_locations.regions}) as ad__targeting__geo_locations__regions ;;
    relationship: one_to_many
  }

  join: ad__targeting__geo_locations {
    view_label: "Ad: Targeting Geo Locations"
    sql: LEFT JOIN UNNEST([${ad__targeting.geo_locations}]) as ad__targeting__geo_locations ;;
    relationship: one_to_one
  }

  join: ad__targeting__geo_locations__cities {
    view_label: "Ad: Targeting Geo Locations Cities"
    sql: LEFT JOIN UNNEST(${ad__targeting__geo_locations.cities}) as ad__targeting__geo_locations__cities ;;
    relationship: one_to_many
  }

  join: ad__targeting__geo_locations__countries {
    view_label: "Ad: Targeting Geo Locations Countries"
    sql: LEFT JOIN UNNEST(${ad__targeting__geo_locations.countries}) as ad__targeting__geo_locations__countries ;;
    relationship: one_to_many
  }

  join: ad__targeting__geo_locations__location_types {
    view_label: "Ad: Targeting Geo Locations Location Types"
    sql: LEFT JOIN UNNEST(${ad__targeting__geo_locations.location_types}) as ad__targeting__geo_locations__location_types ;;
    relationship: one_to_many
  }

  join: ad__targeting__geo_locations__zips {
    view_label: "Ad: Targeting Geo Locations Zips"
    sql: LEFT JOIN UNNEST(${ad__targeting__geo_locations.zips}) as ad__targeting__geo_locations__zips ;;
    relationship: one_to_many
  }

  join: ad__targeting__custom_audiences {
    view_label: "Ad: Targeting Custom Audiences"
    sql: LEFT JOIN UNNEST(${ad__targeting.custom_audiences}) as ad__targeting__custom_audiences ;;
    relationship: one_to_many
  }

  join: ad__targeting__flexible_spec__work_positions {
    view_label: "Ad: Targeting Flexible Spec Work Positions"
    sql: LEFT JOIN UNNEST(${ad__targeting__flexible_spec.work_positions}) as ad__targeting__flexible_spec__work_positions ;;
    relationship: one_to_many
  }

  join: ad__targeting__flexible_spec__friends_of_connections {
    view_label: "Ad: Targeting Flexible Spec Friends Of Connections"
    sql: LEFT JOIN UNNEST(${ad__targeting__flexible_spec.friends_of_connections}) as ad__targeting__flexible_spec__friends_of_connections ;;
    relationship: one_to_many
  }

  join: ad__targeting__flexible_spec__behaviors {
    view_label: "Ad: Targeting Flexible Spec Behaviors"
    sql: LEFT JOIN UNNEST(${ad__targeting__flexible_spec.behaviors}) as ad__targeting__flexible_spec__behaviors ;;
    relationship: one_to_many
  }

  join: ad__targeting__flexible_spec__interests {
    view_label: "Ad: Targeting Flexible Spec Interests"
    sql: LEFT JOIN UNNEST(${ad__targeting__flexible_spec.interests}) as ad__targeting__flexible_spec__interests ;;
    relationship: one_to_many
  }

  join: ad__targeting__flexible_spec__connections {
    view_label: "Ad: Targeting Flexible Spec Connections"
    sql: LEFT JOIN UNNEST(${ad__targeting__flexible_spec.connections}) as ad__targeting__flexible_spec__connections ;;
    relationship: one_to_many
  }

  join: ad__targeting__flexible_spec__work_employers {
    view_label: "Ad: Targeting Flexible Spec Work Employers"
    sql: LEFT JOIN UNNEST(${ad__targeting__flexible_spec.work_employers}) as ad__targeting__flexible_spec__work_employers ;;
    relationship: one_to_many
  }

  join: ad__targeting__interests {
    view_label: "Ad: Targeting Interests"
    sql: LEFT JOIN UNNEST(${ad__targeting.interests}) as ad__targeting__interests ;;
    relationship: one_to_many
  }

  join: ad__tracking_specs {
    view_label: "Ad: Tracking Specs"
    sql: LEFT JOIN UNNEST([${ad.tracking_specs}]) as ad__tracking_specs ;;
    relationship: one_to_one
  }

  join: ad__targeting__flexible_spec {
    view_label: "Ad: Targeting Flexible Spec"
    sql: LEFT JOIN UNNEST(${ad__targeting.flexible_spec}) as ad__targeting__flexible_spec ;;
    relationship: one_to_one
  }
}

explore: ad_fb_adapter {
  persist_with: facebook_ads_etl_datagroup
  extends: [ad_nested_joins_base]
  view_name: ad
  from: ad_fb_adapter
  # hidden: yes

  join: adcreative {
    from: adcreative_fb_adapter
    type: left_outer
    sql_on: ${ad.creative_id} = ${adcreative.id} ;;
    relationship: one_to_one
  }

  join: adset {
    from: adset_fb_adapter
    type: left_outer
    sql_on: ${ad.adset_id} = ${adset.id} ;;
    relationship: many_to_one
  }

  join: campaign {
    from: campaign_fb_adapter
    type: left_outer
    sql_on: ${ad.campaign_id} = ${campaign.id} ;;
    relationship: many_to_one
  }
}

view: ad_fb_adapter {
  extends: [stitch_base, facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}.facebook_ads_{{ facebook_account_id._sql }} ;;

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
  }

  dimension: campaign_id {
    type: string
    hidden: yes
  }

  dimension: conversion_specs {
    hidden: yes
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
    hidden: yes
  }

  dimension: effective_status {
    type: string
  }

  dimension: last_updated_by_app_id {
    type: string
    hidden: yes
  }

  dimension: name {
    type: string
  }

  dimension: recommendations {
    hidden: yes
    sql: ${TABLE}.recommendations ;;
  }

  dimension: source_ad_id {
    type: string
    hidden: yes
  }

  dimension: status {
    type: string
  }

  dimension: status_active {
    type: yesno
    sql: ${status} = "ACTIVE" ;;
  }

  dimension: targeting {
    hidden: yes
  }

  dimension: tracking_specs {
    hidden: yes
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

view: ad__conversion_specs__action_type {
  extends: [stitch_base, facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}."facebook_ads_{{ facebook_account_id._sql }}__conversion_specs__action.type" ;;

  dimension: _sdc_source_key_id {
    hidden: yes
    type: string
    sql: ${TABLE}._sdc_source_key_id ;;
  }

  dimension: action_type {
    hidden: no
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: ad__conversion_specs__conversion_id {
  extends: [stitch_base, facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}.facebook_ads_{{ facebook_account_id._sql }}__conversion_specs__conversion_id ;;

  dimension: _sdc_source_key_id {
    hidden: yes
    type: string
    sql: ${TABLE}._sdc_source_key_id ;;
  }

  dimension: conversion_id {
    hidden: no
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: ad__conversion_specs__page {
  extends: [stitch_base, facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}.facebook_ads_{{ facebook_account_id._sql }}__conversion_specs__page ;;

  dimension: _sdc_source_key_id {
    hidden: yes
    type: string
    sql: ${TABLE}._sdc_source_key_id ;;
  }

  dimension: page {
    hidden: no
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: ad__conversion_specs__post {
  extends: [stitch_base, facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}.facebook_ads_{{ facebook_account_id._sql }}__conversion_specs__post ;;

  dimension: _sdc_source_key_id {
    hidden: yes
    type: string
    sql: ${TABLE}._sdc_source_key_id ;;
  }

  dimension: post {
    hidden: no
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: ad__conversion_specs__post_wall {
  extends: [stitch_base, facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}."facebook_ads_{{ facebook_account_id._sql }}__conversion_specs__post.wall" ;;

  dimension: _sdc_source_key_id {
    hidden: yes
    type: string
    sql: ${TABLE}._sdc_source_key_id ;;
  }

  dimension: post_wall {
    hidden: no
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: ad__bid_info {
  dimension: actions {
    hidden: yes
    type: number
    sql: ${TABLE}.actions ;;
  }
}

view: ad__recommendations {
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

view: ad__targeting {
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

view: ad__targeting__friends_of_connections {
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

view: ad__targeting__geo_locations__regions {
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

view: ad__targeting__geo_locations {
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

view: ad__targeting__geo_locations__cities {
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

view: ad__targeting__geo_locations__countries {
  dimension: country {
    hidden: yes
    type: string
    map_layer_name: countries
    sql: ${TABLE} ;;
  }
}

view: ad__targeting__geo_locations__location_types {
  dimension: location_type {
    hidden: yes
    type: string
    sql: ${TABLE} ;;
  }
}

view: ad__targeting__geo_locations__zips {
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

view: ad__targeting__custom_audiences {
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

view: ad__targeting__flexible_spec__work_positions {
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

view: ad__targeting__flexible_spec__friends_of_connections {
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

view: ad__targeting__flexible_spec__behaviors {
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

view: ad__targeting__flexible_spec__interests {
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

view: ad__targeting__flexible_spec__connections {
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

view: ad__targeting__flexible_spec__work_employers {
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

view: ad__targeting__interests {
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

view: ad__tracking_specs {
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

view: ad__targeting__flexible_spec {
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
