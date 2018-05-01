include: "adcreative_adapter.view"
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
  extends: ["adcreative_adapter", "stitch_base"]

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

  dimension: body {
    type: string
    sql: ${TABLE}.body ;;
  }

  dimension: call_to_action_type {
    type: string
    sql: ${TABLE}.call_to_action_type ;;
  }

  dimension: effective_instagram_story_id {
    hidden: yes
    type: string
    sql: ${TABLE}.effective_instagram_story_id ;;
  }

  dimension: effective_object_story_id {
    hidden: yes
    type: string
    sql: ${TABLE}.effective_object_story_id ;;
  }

  dimension: image_hash {
    hidden: yes
    type: string
    sql: ${TABLE}.image_hash ;;
  }

  dimension: image_url {
    hidden: yes
    type: string
    sql: ${TABLE}.image_url ;;
    html: "<img src='{{value}}' />" ;;
  }

  dimension: instagram_actor_id {
    type: string
    sql: ${TABLE}.instagram_actor_id ;;
    hidden: yes
  }

  dimension: instagram_permalink_url {
    hidden: yes
    type: string
    sql: ${TABLE}.instagram_permalink_url ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: object_story_id {
    hidden: yes
    type: string
    sql: ${TABLE}.object_story_id ;;
  }

  dimension: object_story_spec {
    hidden: yes
    sql: ${TABLE}.object_story_spec ;;
  }

  dimension: object_type {
    type: string
    sql: ${TABLE}.object_type ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: status_active {
    type: yesno
    sql: ${status} = "ACTIVE" ;;
  }

  dimension: thumbnail_url {
    type: string
    sql: ${TABLE}.thumbnail_url ;;
    html: "<img src='{{value}}' />" ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: video_id {
    type: string
    sql: ${TABLE}.video_id ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}

view: adcreative__object_story_spec {
  dimension: instagram_actor_id {
    hidden: yes
    type: string
    sql: ${TABLE}.instagram_actor_id ;;
  }

  dimension: link_data {
    hidden: yes
    sql: ${TABLE}.link_data ;;
  }

  dimension: page_id {
    hidden: yes
    type: string
    sql: ${TABLE}.page_id ;;
  }

  dimension: video_data {
    hidden: yes
    sql: ${TABLE}.video_data ;;
  }
}

view: adcreative__object_story_spec__video_data__call_to_action {
  dimension: type {
    hidden: yes
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: adcreative__object_story_spec__video_data__call_to_action__value {
  dimension: lead_gen_form_id {
    hidden: yes
    type: string
    sql: ${TABLE}.lead_gen_form_id ;;
  }

  dimension: link {
    hidden: yes
    type: string
    sql: ${TABLE}.link ;;
  }

  dimension: link_caption {
    hidden: yes
    type: string
    sql: ${TABLE}.link_caption ;;
  }

  dimension: link_format {
    hidden: yes
    type: string
    sql: ${TABLE}.link_format ;;
  }
}

view: adcreative__object_story_spec__video_data {
  dimension: call_to_action {
    hidden: yes
    sql: ${TABLE}.call_to_action ;;
  }

  dimension: image_hash {
    hidden: yes
    type: string
    sql: ${TABLE}.image_hash ;;
  }

  dimension: image_url {
    hidden: yes
    type: string
    sql: ${TABLE}.image_url ;;
  }

  dimension: link_description {
    hidden: yes
    type: string
    sql: ${TABLE}.link_description ;;
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

  dimension: video_id {
    hidden: yes
    type: string
    sql: ${TABLE}.video_id ;;
  }
}

view: adcreative__object_story_spec__link_data__call_to_action {
  dimension: type {
    hidden: yes
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: adcreative__object_story_spec__link_data {
  dimension: attachment_style {
    hidden: yes
    type: string
    sql: ${TABLE}.attachment_style ;;
  }

  dimension: call_to_action {
    hidden: yes
    sql: ${TABLE}.call_to_action ;;
  }

  dimension: caption {
    hidden: yes
    type: string
    sql: ${TABLE}.caption ;;
  }

  dimension: description {
    hidden: yes
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: image_hash {
    hidden: yes
    type: string
    sql: ${TABLE}.image_hash ;;
  }

  dimension: link {
    hidden: yes
    type: string
    sql: ${TABLE}.link ;;
  }

  dimension: message {
    hidden: yes
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: picture {
    hidden: yes
    type: string
    sql: ${TABLE}.picture ;;
  }
}