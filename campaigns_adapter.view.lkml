include: "config.view"

view: campaigns_adapter {
  extension: required
  extends: [config]
  sql_table_name: {{ facebook_ads_schema._sql }}.campaigns ;;
}