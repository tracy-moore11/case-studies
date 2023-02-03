view: orders_crossview {

  measure: percentage_customers_with_returns {
    type: number
    value_format_name: percent_2
    sql: 1.0*${order_items.count_users_with_returns}
      /NULLIF(${users.total_users}, 0) ;;
    view_label: "Order Items"
  }

  measure: percentage_gross_margin {
    type: number
    value_format_name: percent_2
    sql: 1.0*${order_items.total_gross_margin_amount}
      /NULLIF(${order_items.total_gross_revenue}, 0) ;;
    view_label: "Order Items"
  }

  measure: item_return_rate {
    type: number
    value_format_name: percent_2
    sql: 1.0*${order_items.num_returned_items}
      /NULLIF(${order_items.num_uncancelled_items}, 0) ;;
    view_label: "Order Items"
  }
}
