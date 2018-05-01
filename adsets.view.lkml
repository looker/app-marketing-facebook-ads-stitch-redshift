include: "adsets_adapter.view"
include: "campaigns.view"

explore: adsets_nested_joins_base {
  extension: required

  join: adsets__bid_info {
    view_label: "Adsets: Bid Info"
    sql: LEFT JOIN UNNEST([${adsets.bid_info}]) as adsets__bid_info ;;
    relationship: one_to_one
  }

  join: adsets__targeting {
    view_label: "Adsets: Targeting"
    sql: LEFT JOIN UNNEST([${adsets.targeting}]) as adsets__targeting ;;
    relationship: one_to_one
  }

  join: adsets__targeting__flexible_spec__work_positions {
    view_label: "Adsets: Targeting Flexible Spec Work Positions"
    sql: LEFT JOIN UNNEST(${adsets__targeting__flexible_spec.work_positions}) as adsets__targeting__flexible_spec__work_positions ;;
    relationship: one_to_many
  }

  join: adsets__targeting__flexible_spec__friends_of_connections {
    view_label: "Adsets: Targeting Flexible Spec Friends Of Connections"
    sql: LEFT JOIN UNNEST(${adsets__targeting__flexible_spec.friends_of_connections}) as adsets__targeting__flexible_spec__friends_of_connections ;;
    relationship: one_to_many
  }

  join: adsets__targeting__flexible_spec__behaviors {
    view_label: "Adsets: Targeting Flexible Spec Behaviors"
    sql: LEFT JOIN UNNEST(${adsets__targeting__flexible_spec.behaviors}) as adsets__targeting__flexible_spec__behaviors ;;
    relationship: one_to_many
  }

  join: adsets__targeting__flexible_spec__interests {
    view_label: "Adsets: Targeting Flexible Spec Interests"
    sql: LEFT JOIN UNNEST(${adsets__targeting__flexible_spec.interests}) as adsets__targeting__flexible_spec__interests ;;
    relationship: one_to_many
  }

  join: adsets__targeting__flexible_spec__connections {
    view_label: "Adsets: Targeting Flexible Spec Connections"
    sql: LEFT JOIN UNNEST(${adsets__targeting__flexible_spec.connections}) as adsets__targeting__flexible_spec__connections ;;
    relationship: one_to_many
  }

  join: adsets__targeting__flexible_spec__work_employers {
    view_label: "Adsets: Targeting Flexible Spec Work Employers"
    sql: LEFT JOIN UNNEST(${adsets__targeting__flexible_spec.work_employers}) as adsets__targeting__flexible_spec__work_employers ;;
    relationship: one_to_many
  }

  join: adsets__targeting__geo_locations__regions {
    view_label: "Adsets: Targeting Geo Locations Regions"
    sql: LEFT JOIN UNNEST(${adsets__targeting__geo_locations.regions}) as adsets__targeting__geo_locations__regions ;;
    relationship: one_to_many
  }

  join: adsets__targeting__geo_locations {
    view_label: "Adsets: Targeting Geo Locations"
    sql: LEFT JOIN UNNEST([${adsets__targeting.geo_locations}]) as adsets__targeting__geo_locations ;;
    relationship: one_to_one
  }

  join: adsets__targeting__geo_locations__cities {
    view_label: "Adsets: Targeting Geo Locations Cities"
    sql: LEFT JOIN UNNEST(${adsets__targeting__geo_locations.cities}) as adsets__targeting__geo_locations__cities ;;
    relationship: one_to_many
  }

  join: adsets__targeting__geo_locations__countries {
    view_label: "Ads: Targeting Geo Locations Countries"
    sql: LEFT JOIN UNNEST(${adsets__targeting__geo_locations.countries}) as adsets__targeting__geo_locations__countries ;;
    relationship: one_to_many
  }

  join: adsets__targeting__geo_locations__location_types {
    view_label: "Ads: Targeting Geo Locations Location Types"
    sql: LEFT JOIN UNNEST(${adsets__targeting__geo_locations.location_types}) as adsets__targeting__geo_locations__location_types ;;
    relationship: one_to_many
  }

  join: adsets__targeting__geo_locations__zips {
    view_label: "Adsets: Targeting Geo Locations Zips"
    sql: LEFT JOIN UNNEST(${adsets__targeting__geo_locations.zips}) as adsets__targeting__geo_locations__zips ;;
    relationship: one_to_many
  }

  join: adsets__targeting__custom_audiences {
    view_label: "Adsets: Targeting Custom Audiences"
    sql: LEFT JOIN UNNEST(${adsets__targeting.custom_audiences}) as adsets__targeting__custom_audiences ;;
    relationship: one_to_many
  }

  join: adsets__promoted_object {
    view_label: "Adsets: Promoted Object"
    sql: LEFT JOIN UNNEST([${adsets.promoted_object}]) as adsets__promoted_object ;;
    relationship: one_to_one
  }

  join: adsets__targeting__flexible_spec {
    view_label: "Adsets: Targeting Flexible Spec"
    sql: LEFT JOIN UNNEST([${adsets__targeting.flexible_spec}]) as adsets__targeting__flexible_spec ;;
    relationship: one_to_one
  }
}

explore: adsets {
  extends: [adsets_nested_joins_base]
  hidden: yes

  join: campaigns {
    type: left_outer
    sql_on: ${adsets.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }
}


view: adsets {
  extends: ["adsets_adapter", "stitch_base"]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: account_id {
    hidden: yes
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: bid_info {
    hidden: yes
    sql: ${TABLE}.bid_info ;;
  }

  dimension: budget_remaining {
    type: number
    sql: ${TABLE}.budget_remaining ;;
  }

  dimension: campaign_id {
    hidden: yes
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_time ;;
  }

  dimension: daily_budget {
    type: number
    sql: ${TABLE}.daily_budget ;;
  }

  measure: total_daily_budget {
    type: sum
    sql: ${daily_budget} ;;
  }

  dimension: effective_status {
    type: string
    sql: ${TABLE}.effective_status ;;
  }

  dimension_group: end {
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
    sql: ${TABLE}.end_time ;;
  }

  dimension: lifetime_budget {
    type: number
    sql: ${TABLE}.lifetime_budget ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: promoted_object {
    hidden: yes
    sql: ${TABLE}.promoted_object ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.start_time ;;
  }

  dimension: targeting {
    hidden: yes
    sql: ${TABLE}.targeting ;;
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

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      name,
      campaigns.name,
      ads.count,
    ]
  }
}

view: adsets__bid_info {
  dimension: actions {
    hidden: yes
    type: number
    sql: ${TABLE}.actions ;;
  }
}

view: adsets__targeting {
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

  dimension: geo_locations {
    hidden: yes
    sql: ${TABLE}.geo_locations ;;
  }

  dimension: instagram_positions {
    hidden: yes
    type: string
    sql: ${TABLE}.instagram_positions ;;
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

view: adsets__targeting__flexible_spec__work_positions {
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

view: adsets__targeting__flexible_spec__friends_of_connections {
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

view: adsets__targeting__flexible_spec__behaviors {
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

view: adsets__targeting__flexible_spec__interests {
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

view: adsets__targeting__flexible_spec__connections {
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

view: adsets__targeting__flexible_spec__work_employers {
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

view: adsets__targeting__geo_locations__regions {
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

view: adsets__targeting__geo_locations {
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

view: adsets__targeting__geo_locations__cities {
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

view: adsets__targeting__geo_locations__countries {
  dimension: country {
    hidden: yes
    type: string
    map_layer_name: countries
    sql: ${TABLE} ;;
  }
}

view: adsets__targeting__geo_locations__location_types {
  dimension: location_type {
    hidden: yes
    type: string
    sql: ${TABLE} ;;
  }
}

view: adsets__targeting__geo_locations__zips {
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

view: adsets__targeting__custom_audiences {
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

view: adsets__promoted_object {
  dimension: custom_event_type {
    hidden: yes
    type: string
    sql: ${TABLE}.custom_event_type ;;
  }

  dimension: page_id {
    hidden: yes
    type: string
    sql: ${TABLE}.page_id ;;
  }

  dimension: pixel_id {
    hidden: yes
    type: string
    sql: ${TABLE}.pixel_id ;;
  }
}

view: adsets__targeting__flexible_spec {
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