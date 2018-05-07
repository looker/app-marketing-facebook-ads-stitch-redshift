explore: account_fb_adapter {
  hidden: yes
}
view: account_fb_adapter {
  sql_table_name: (SELECT "1" as id) ;;
  dimension: id {
    hidden: yes
  }
}
