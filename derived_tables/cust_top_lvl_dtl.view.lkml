view: cust_top_lvl_dtl {
      derived_table: {
        explore_source: order_items {
          column: user_id {}
          column: num_total_orders {}
          column: first_order {}
          column: latest_order {}
          column: total_gross_revenue {}
          filters: {
            field: order_items.iscomplete
            value: "Yes"
          }
        }
      }

  ##--Dimensions--##
  dimension: user_id {
    type: number
    primary_key: yes
  }
  dimension: customer_lifetime_orders {
   type: tier
    tiers: [1, 2, 3, 6, 10]
    sql: ${num_total_orders} ;;
    style:  integer
  }
  dimension: customer_lifetime_revenue {
    type: tier
    tiers: [0, 5, 20, 50, 100, 500, 1000]
    sql: ${total_gross_revenue} ;;
    style:  integer
    value_format_name: usd
  }

  dimension: customer_lifetime_months {
    type: number
    sql: date_diff(${latest_order},${first_order},month) ;;
  }

  dimension: first_order {
    # hidden: yes
    type: date
  }
  dimension: latest_order {
    # hidden: yes
    type: date
  }
  dimension: num_total_orders {
    # hidden: yes
    type: number
  }
  dimension: total_gross_revenue {
    hidden: yes
    description: "Total revenue from completed sales (cancelled and returned orders excluded)"
    value_format_name: usd
    type: number
  }

  ##--Measures--##

  measure: average_lifetime_months {
    type: average
    sql: ${customer_lifetime_months} ;;
  }

  measure: average_lifetime_orders {
    type: average
    sql: ${num_total_orders} ;;
    value_format_name: decimal_2
  }

  measure: average_lifetime_revenue {
    type: average
    sql: ${total_gross_revenue} ;;
    value_format_name: usd
  }

  measure:  total_lifetime_orders{
    type:sum
    sql: ${num_total_orders} ;;
  }
  measure: total_lifetime_revenue {
    type: sum
    sql: ${total_gross_revenue} ;;
    value_format_name: usd
  }

}
