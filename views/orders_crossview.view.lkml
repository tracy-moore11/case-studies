view: orders_crossview {

  measure: average_spend_per_customer {
    type: number
    value_format_name: usd
    sql: 1.0*${order_items.total_sale_price}
      /NULLIF(${order_items.num_users}, 0) ;;
    view_label: "Order Items"
  }

  measure: gross_margin_percentage {
    type: number
    value_format_name: percent_3
    sql: 1.0*${order_items.total_gross_margin_amount}
      /NULLIF(${order_items.total_gross_revenue}, 0) ;;
    view_label: "Order Items"
  }

  measure: percentage_customers_with_returns {
    type: number
    value_format_name: percent_2
    sql: 1.0*${order_items.num_cust_with_returns}
      /NULLIF(${users.total_users}, 0) ;;
    view_label: "Order Items"
  }

  measure: item_return_rate {
    type: number
    value_format_name: percent_2
    sql: 1.0*${order_items.total_returned_items}
      /NULLIF(${order_items.num_uncancelled_items}, 0) ;;
    view_label: "Order Items"
  }
}
