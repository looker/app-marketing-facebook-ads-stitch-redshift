include: "/app_marketing_analytics_config/facebook_ads_config.view"

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
  extends: [stitch_base, facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}.adsets ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }

  dimension: account_id {
    hidden: yes
    type: string
  }

  dimension: bid_info {
    hidden: yes
  }

  dimension: budget_remaining {
    type: number
  }

  dimension: campaign_id {
    hidden: yes
    type: string
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
  }

  dimension: effective_status {
    type: string
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
  }

  dimension: name {
    type: string
  }

  dimension: promoted_object {
    hidden: yes
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
  }
}

view: adsets__bid_info {
  dimension: actions {
    hidden: yes
    type: number
  }
}

view: adsets__targeting {
  dimension: age_max {
    hidden: yes
    type: number
  }

  dimension: age_min {
    hidden: yes
    type: number
  }

  dimension: audience_network_positions {
    hidden: yes
    type: string
  }

  dimension: custom_audiences {
    hidden: yes
  }

  dimension: device_platforms {
    hidden: yes
    type: string
  }

  dimension: facebook_positions {
    hidden: yes
    type: string
  }

  dimension: flexible_spec {
    hidden: yes
  }

  dimension: geo_locations {
    hidden: yes
  }

  dimension: instagram_positions {
    hidden: yes
    type: string
  }

  dimension: messenger_positions {
    hidden: yes
    type: string
  }

  dimension: publisher_platforms {
    hidden: yes
    type: string
  }

  dimension: targeting_optimization {
    hidden: yes
    type: string
  }
}

view: adsets__targeting__flexible_spec_base {
  extension: required
  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }

  dimension: name {
    hidden: yes
    type: string
  }
}

view: adsets__targeting__flexible_spec__work_positions {
  extends: [adsets__targeting__flexible_spec_base]
}

view: adsets__targeting__flexible_spec__friends_of_connections {
  extends: [adsets__targeting__flexible_spec_base]
}

view: adsets__targeting__flexible_spec__behaviors {
  extends: [adsets__targeting__flexible_spec_base]
}

view: adsets__targeting__flexible_spec__interests {
  extends: [adsets__targeting__flexible_spec_base]
}

view: adsets__targeting__flexible_spec__connections {
  extends: [adsets__targeting__flexible_spec_base]
}

view: adsets__targeting__flexible_spec__work_employers {
  extends: [adsets__targeting__flexible_spec_base]
}

view: adsets__targeting__geo_locations__regions {
  dimension: country {
    hidden: yes
    type: string
    map_layer_name: countries
  }

  dimension: key {
    hidden: yes
    type: string
  }

  dimension: name {
    hidden: yes
    type: string
  }
}

view: adsets__targeting__geo_locations {
  dimension: cities {
    hidden: yes
  }

  dimension: countries {
    hidden: yes
  }

  dimension: location_types {
    hidden: yes
  }

  dimension: regions {
    hidden: yes
  }

  dimension: zips {
    hidden: yes
  }
}

view: adsets__targeting__geo_locations__cities {
  dimension: country {
    hidden: yes
    type: string
    map_layer_name: countries
  }

  dimension: distance_unit {
    hidden: yes
    type: string
  }

  dimension: key {
    hidden: yes
    type: string
  }

  dimension: name {
    hidden: yes
    type: string
  }

  dimension: radius {
    hidden: yes
    type: number
  }

  dimension: region {
    hidden: yes
    type: string
  }

  dimension: region_id {
    hidden: yes
    type: string
  }
}

view: adsets__targeting__geo_locations__countries {
  dimension: country {
    hidden: yes
    type: string
    map_layer_name: countries
  }
}

view: adsets__targeting__geo_locations__location_types {
  dimension: location_type {
    hidden: yes
    type: string
  }
}

view: adsets__targeting__geo_locations__zips {
  dimension: country {
    hidden: yes
    type: string
    map_layer_name: countries
  }

  dimension: key {
    hidden: yes
    type: string
  }

  dimension: name {
    hidden: yes
    type: string
  }

  dimension: primary_city_id {
    hidden: yes
    type: number
  }

  dimension: region_id {
    hidden: yes
    type: number
  }
}

view: adsets__targeting__custom_audiences {
  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }

  dimension: name {
    hidden: yes
    type: string
  }
}

view: adsets__promoted_object {
  dimension: custom_event_type {
    hidden: yes
    type: string
  }

  dimension: page_id {
    hidden: yes
    type: string
  }

  dimension: pixel_id {
    hidden: yes
    type: string
  }
}

view: adsets__targeting__flexible_spec {
  dimension: behaviors {
    hidden: yes
  }

  dimension: connections {
    hidden: yes
  }

  dimension: friends_of_connections {
    hidden: yes
  }

  dimension: interests {
    hidden: yes
  }

  dimension: work_employers {
    hidden: yes
  }

  dimension: work_positions {
    hidden: yes
  }
}
