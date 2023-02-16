
view: order_details_first_30_days {
  derived_table: {
    explore_source: order_items {
      column: created_month { field: users.created_month }
      column: total_gross_revenue {}
      column: num_items {}
      column: num_total_orders {}
      column: user_id {}
      filters: {
        field: order_items.order_days_since_signup
        value: "<=30"
      }
      filters: {
        field: order_items.iscomplete
        value: "Yes"
      }
    }
  }
  dimension: created_month {
    description: ""
    type: date_month
  }
  dimension: total_gross_revenue {
    type: number
  }
  dimension: num_items {
    description: ""
    type: number
  }
  dimension: num_total_orders {
    description: ""
    type: number
  }
  dimension: user_id {
    description: ""
    type: number
  }

  measure: average_num_items {
    type: average
    sql: ${num_items} ;;
  }

  measure: average_num_sales {
    type: average
    sql: ${num_total_orders} ;;
  }


  measure: average_revenue_30_days {
    type: average
    sql: ${total_gross_revenue} ;;
  }

  measure: total_num_items {
    type: sum
    sql: ${total_num_items} ;;
  }

  measure: total_num_sales {
    type: sum
    sql: ${num_total_orders} ;;
  }

  measure: total_revenue_30_days {
    type: sum
    sql: ${total_gross_revenue} ;;
  }
}
