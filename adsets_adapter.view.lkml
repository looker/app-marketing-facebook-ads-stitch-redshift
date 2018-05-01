include: "config.view"

view: adsets_adapter {
  extension: required
  extends: [config]
  sql_table_name: {{ facebook_ads_schema._sql }}.adsets ;;
}