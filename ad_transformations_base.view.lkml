view: ad_transformations_base {
  extension: required

  dimension: conversions {
    type: number
    expression: ${ads_insights__actions.offsite_conversion_value} ;;
  }

  dimension: conversionvalue {
    type: number
    expression:  ${total_action_value};;
  }

  dimension: cost {
    type: number
    expression:  ${spend} ;;
  }
}
