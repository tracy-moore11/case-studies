view: distribution_centers {
  sql_table_name: `looker-partners.thelook.distribution_centers`
    ;;
  drill_fields: [id]

##--primary key--##
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  ##--dimensions--##
  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }


  ##--measures--##
  measure: average_latitude {
    type: average
    sql: ${latitude} ;;
  }

  measure: total_latitude {
    type: sum
    sql: ${latitude} ;;
  }

}
