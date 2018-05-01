include: "config.view"

view: ads_adapter {
  extension: required
  extends: [config]
  sql_table_name: {{ facebook_ads_schema._sql }}.ads ;;
}