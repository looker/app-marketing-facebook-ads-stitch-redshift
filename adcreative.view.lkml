include: "/app_marketing_analytics_config/facebook_ads_config.view"

include: "ads.view"
include: "adsets.view"

explore: adcreative_nested_joins_base {
  extension: required

  join: adcreative__object_story_spec {
    view_label: "Adcreative: Object Story Spec"
    sql: LEFT JOIN UNNEST([${adcreative.object_story_spec}]) as adcreative__object_story_spec ;;
    relationship: one_to_one
  }

  join: adcreative__object_story_spec__video_data__call_to_action {
    view_label: "Adcreative: Object Story Spec Video Data Call To Action"
    sql: LEFT JOIN UNNEST([${adcreative__object_story_spec__video_data.call_to_action}]) as adcreative__object_story_spec__video_data__call_to_action ;;
    relationship: one_to_one
  }

  join: adcreative__object_story_spec__video_data__call_to_action__value {
    view_label: "Adcreative: Object Story Spec Video Data Call To Action Value"
    sql: LEFT JOIN UNNEST([${adcreative__object_story_spec__video_data__call_to_action.value}]) as adcreative__object_story_spec__video_data__call_to_action__value ;;
    relationship: one_to_one
  }

  join: adcreative__object_story_spec__video_data {
    view_label: "Adcreative: Object Story Spec Video Data"
    sql: LEFT JOIN UNNEST([${adcreative__object_story_spec.video_data}]) as adcreative__object_story_spec__video_data ;;
    relationship: one_to_one
  }

  join: adcreative__object_story_spec__link_data__call_to_action {
    view_label: "Adcreative: Object Story Spec Link Data Call To Action"
    sql: LEFT JOIN UNNEST([${adcreative__object_story_spec__link_data.call_to_action}]) as adcreative__object_story_spec__link_data__call_to_action ;;
    relationship: one_to_one
  }

  join: adcreative__object_story_spec__link_data {
    view_label: "Adcreative: Object Story Spec Link Data"
    sql: LEFT JOIN UNNEST([${adcreative__object_story_spec.link_data}]) as adcreative__object_story_spec__link_data ;;
    relationship: one_to_one
  }
}

explore: adcreative {
  extends: [adcreative_nested_joins_base]
  hidden: yes

  join: ads {
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

view: adcreative {
  extends: [stitch_base, facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}.adcreative ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }

  dimension: account_id {
    hidden: yes
    type: string
  }

  dimension: body {
    type: string
  }

  dimension: call_to_action_type {
    type: string
  }

  dimension: effective_instagram_story_id {
    hidden: yes
    type: string
  }

  dimension: effective_object_story_id {
    hidden: yes
    type: string
  }

  dimension: image_hash {
    hidden: yes
    type: string
  }

  dimension: image_url {
    hidden: yes
    type: string
    html: "<img src='{{value}}' />" ;;
  }

  dimension: instagram_actor_id {
    type: string
    hidden: yes
  }

  dimension: instagram_permalink_url {
    hidden: yes
    type: string
  }

  dimension: name {
    type: string
  }

  dimension: object_story_id {
    hidden: yes
    type: string
  }

  dimension: object_story_spec {
    hidden: yes
  }

  dimension: object_type {
    type: string
  }

  dimension: status {
    type: string
  }

  dimension: status_active {
    type: yesno
    expression: ${status} = "ACTIVE" ;;
  }

  dimension: thumbnail_url {
    type: string
    html: "<img src='{{value}}' />" ;;
  }

  dimension: title {
    type: string
  }

  dimension: video_id {
    type: string
    hidden: yes
  }
}

view: adcreative__object_story_spec {
  dimension: instagram_actor_id {
    hidden: yes
    type: string
  }

  dimension: link_data {
    hidden: yes
  }

  dimension: page_id {
    hidden: yes
    type: string
  }

  dimension: video_data {
    hidden: yes
  }
}

view: adcreative__object_story_spec__video_data__call_to_action {
  dimension: type {
    hidden: yes
    type: string
  }

  dimension: value {
    hidden: yes
  }
}

view: adcreative__object_story_spec__video_data__call_to_action__value {
  dimension: lead_gen_form_id {
    hidden: yes
    type: string
  }

  dimension: link {
    hidden: yes
    type: string
  }

  dimension: link_caption {
    hidden: yes
    type: string
  }

  dimension: link_format {
    hidden: yes
    type: string
  }
}

view: adcreative__object_story_spec__video_data {
  dimension: call_to_action {
    hidden: yes
  }

  dimension: image_hash {
    hidden: yes
    type: string
  }

  dimension: image_url {
    hidden: yes
    type: string
  }

  dimension: link_description {
    hidden: yes
    type: string
  }

  dimension: message {
    hidden: yes
    type: string
  }

  dimension: title {
    hidden: yes
    type: string
  }

  dimension: video_id {
    hidden: yes
    type: string
  }
}

view: adcreative__object_story_spec__link_data__call_to_action {
  dimension: type {
    hidden: yes
    type: string
  }
}

view: adcreative__object_story_spec__link_data {
  dimension: attachment_style {
    hidden: yes
    type: string
  }

  dimension: call_to_action {
    hidden: yes
  }

  dimension: caption {
    hidden: yes
    type: string
  }

  dimension: description {
    hidden: yes
    type: string
  }

  dimension: image_hash {
    hidden: yes
    type: string
  }

  dimension: link {
    hidden: yes
    type: string
  }

  dimension: message {
    hidden: yes
    type: string
  }

  dimension: name {
    hidden: yes
    type: string
  }

  dimension: picture {
    hidden: yes
    type: string
  }
}
