include: "/app_marketing_analytics_config/facebook_ads_config.view"

view: ads_adapter {
  extension: required
  extends: [facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}.ads ;;
}
