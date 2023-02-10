view: cust_top_lvl_dtl {
  derived_table: {
    explore_source: order_items {
      column: user_id {}
      column: first_order {}
      column: latest_order {}
      column: num_total_orders {}
      column: total_gross_revenue {}
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
  dimension: first_order {
    type: date
    hidden: yes
  }
  dimension: days_since_last_order {
    type: number
    sql: DATE_DIFF(CURRENT_DATE,${latest_order},DAY) ;;
  }
  dimension: isactive {
    type: yesno
    sql: DATE_DIFF(CURRENT_DATE,${latest_order},DAY) <= 90 ;;
  }
  dimension: latest_order {
    type: date
    hidden: yes
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
  measure: average_days_since_lastest_order {
    type: average
    sql: ${days_since_last_order} ;;
    value_format_name: decimal_2
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
