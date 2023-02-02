view: products_crossview {


  measure: average_gross_margin_amount {
    type: average
    sql: ${order_items.sale_price}-${products.cost} ;;
  }

  # measure: total_cost_completed {
  #   type: sum
  #   sql: ${products.cost} ;;
  #   filters: [order_items.iscomplete: "yes"]

  # }

  measure: total_gross_margin_amount {
    type: sum
    sql: ${order_items.sale_price}-${products.cost} ;;
    filters: [order_items.iscomplete: "yes"]
  }
}
