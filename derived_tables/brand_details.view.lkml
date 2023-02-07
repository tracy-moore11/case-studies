view:  brand_details {
  derived_table: {
    explore_source: order_items {
      column: brand { field: products.brand }
      column: total_gross_revenue {}
      column: total_cost_sold_items {}
      column: total_gross_margin_amount {}
      column: gross_margin_percentage { field: orders_crossview.gross_margin_percentage }
    }
  }
  dimension: brand {
    description: ""
    primary_key: yes
  }
  dimension: total_gross_revenue {
    description: "Total revenue from completed sales (cancelled and returned orders excluded)"
    value_format: "$#,##0.00"
    type: number
  }
  dimension: total_cost_sold_items {
    description: ""
    value_format: "$#,##0.00"
    type: number
  }
  dimension: total_gross_margin_amount {
    description: ""
    value_format: "$#,##0.00"
    type: number
  }
  dimension: gross_margin_percentage {
    label: "Order Items Gross Margin Percentage"
    description: ""
    value_format: "#,##0.00%"
    type: number
  }
  measure: percent_sales_total {
    type: percent_of_total
    sql: ${total_gross_revenue} ;;
    value_format_name: decimal_2
  }
}
