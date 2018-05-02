view: ad_transformations_base {
  extension: required

  dimension: conversions {
    hidden: yes
    type: number
    expression: ${ads_insights__actions.offsite_conversion_value} ;;
  }

  dimension: conversionvalue {
    hidden: yes
    type: number
    expression: ${total_action_value};;
  }

  dimension: cost {
    hidden: yes
    type: number
    expression: ${spend} ;;
  }
}
