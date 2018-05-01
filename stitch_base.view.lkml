view: stitch_base {
  extension: required

  dimension: _sdc_batched {
    hidden: yes
    type: date_time
    sql: ${TABLE}._sdc_batched_at ;;
  }

  dimension: _sdc_extracted {
    hidden: yes
    type: date_time
    sql: ${TABLE}._sdc_extracted_at ;;
  }

  dimension: _sdc_received {
    hidden: yes
    type: date_time
    sql: ${TABLE}._sdc_received_at ;;
  }

  dimension: _sdc_sequence {
    hidden: yes
    type: number
    sql: ${TABLE}._sdc_sequence ;;
  }

  dimension: _sdc_table_version {
    hidden: yes
    type: number
    sql: ${TABLE}._sdc_table_version ;;
  }
}
