view: order_items {
  sql_table_name: `looker-partners.thelook.order_items`;;
  drill_fields: [id]

  # --primary key--##

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

# --dimensions--##

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: hasrepeat {
    type: yesno
    sql: ${cust_top_lvl_dtl.num_total_orders}>1 ;;
  }

  dimension: iscomplete {
    type: yesno
    sql: ${status} != "Cancelled" AND ${returned_date} IS NULL ;;
  }

  dimension: is_new_cust_at_sale {
    type: yesno
    sql: ${order_days_since_signup}<=90 ;;
  }

  dimension: is_not_cancelled {
    type: yesno
    sql: ${status} != "Cancelled" ;;
  }

  dimension: isreturned {
    type: yesno
    sql: ${returned_date} IS NOT NULL ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: order_days_since_signup {
    type: number
    sql: date_diff(${order_items.created_date},${users.created_date},day) ;;
  }

  dimension: order_days_since_signup_grp {
    type: tier
    sql: ${order_days_since_signup} ;;
    tiers: [30, 60, 90,180,365,730]
    style: integer
  }

  dimension: product_id {
    type: number
    hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  # --measures--##

  measure: average_cost_sold_items {
    type: average
    sql: ${products.cost} ;;
    value_format_name: usd
  }

  measure: average_gross_margin_amount {
    type: average
    filters: [iscomplete: "yes"]
    sql: ${order_items.sale_price}-${products.cost} ;;
    value_format_name: usd
  }

  measure: average_sale_price {
    description: "Average sale price of items sold"
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  measure: average_spend_per_customer {
    type: number
    value_format_name: usd
    sql: 1.0*${total_sale_price}
      /NULLIF(${num_users}, 0) ;;
    view_label: "Order Items"
  }

  measure: cumulative_total_sales {
    description: "Cumulative total sales from items sold (also known as a running total)"
    type: running_total
    sql: ${total_gross_revenue};;
    value_format_name: usd
  }

  measure: first_order {
    sql: min(${created_raw});;
    type: date_time
  }

  measure: gross_margin_percentage {
    type: number
    value_format_name: percent_3
    sql: 1.0*${total_gross_margin_amount}
      /NULLIF(${total_gross_revenue}, 0) ;;
    view_label: "Order Items"
  }

  measure: item_return_rate {
    type: number
    value_format_name: percent_2
    sql: 1.0*${total_returned_items}
      /NULLIF(${num_uncancelled_items}, 0) ;;
    view_label: "Order Items"
  }

  # measure: gross_revenue_percent_of_total {
  #   type: percent_of_total
  #   sql: ${total_gross_revenue} ;;
  # }

  measure: latest_order {
    sql: max(${created_raw});;
    type: date_time
  }

  measure: num_complete_sales {
    type: count_distinct
    sql: ${order_id} ;;
    filters: [iscomplete: "yes"]
  }

  measure: num_cust_with_returns {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [isreturned: "yes"]
  }

  measure: num_items {
    type: count
  }

  measure: num_total_orders {
    type: count_distinct
    sql: ${order_id} ;;
  }

  measure: num_uncancelled_items {
    type: count
    filters: [is_not_cancelled: "yes"]
  }

  measure: num_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: percentage_customers_with_returns {
    type: number
    value_format_name: percent_2
    sql: 1.0*${num_cust_with_returns}
      /NULLIF(${num_users}, 0) ;;
    view_label: "Order Items"
  }

  measure: total_cost_sold_items {
    type: sum
    filters: [iscomplete: "yes"]
    sql: ${products.cost} ;;
    value_format_name: usd
  }

  measure: total_gross_margin_amount {
    type: sum
    filters: [iscomplete: "yes"]
    sql: ${order_items.sale_price}-${products.cost} ;;
    value_format_name: usd
    drill_fields: [product_dd*]
  }

  measure: total_gross_revenue {
    description: "Total revenue from completed sales (cancelled and returned orders excluded)"
    type: sum
    sql: ${sale_price} ;;
    filters: [iscomplete: "yes"]
    value_format_name: usd
  }

  measure: total_returned_items {
    type: count
    filters: [isreturned: "yes"]
  }

  measure: total_sale_price {
    description: "Total sales from items sold"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  set: product_dd {
    fields: [products.name,total_gross_margin_amount,total_sale_price,total_cost_sold_items]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.last_name,
      users.id,
      users.first_name,
      inventory_items.id,
      inventory_items.product_name,
      products.name,
      products.id
    ]
  }
}
