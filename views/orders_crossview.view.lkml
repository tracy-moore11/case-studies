view: orders_crossview {

  measure: percentage_customers_with_returns {
    type: number
    value_format_name: percent_2
    sql: 1.0*${order_items.num_cust_with_returns}
      /NULLIF(${users.total_users}, 0) ;;
    view_label: "Order Items"
  }
}
