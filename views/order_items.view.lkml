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
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: iscomplete {
    type: yesno
    sql: ${status} != "Cancelled" AND ${returned_date} IS NULL ;;
  }

  dimension: isreturned {
    type: yesno
    sql: ${returned_date} IS NOT NULL ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
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

  measure: cumulative_total_sales {
    description: "Cumulative total sales from items sold (also known as a running total)"
    type: running_total
    sql: ${sale_price};;
    value_format_name: usd
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

  measure: num_returned_items {
    type: count
    filters: [isreturned: "yes"]
  }

  measure: num_uncancelled_items {
    type: count
    filters: [status: "-Cancelled"]
  }

  measure: num_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: total_gross_margin_amount {
    type: sum
    filters: [iscomplete: "yes"]
    sql: ${order_items.sale_price}-${products.cost} ;;
    value_format_name: usd
  }

  measure: total_gross_revenue {
    description: "Total revenue from completed sales (cancelled and returned orders excluded)"
    type: sum
    sql: ${sale_price} ;;
    filters: [iscomplete: "yes"]
    value_format_name: usd
  }

  measure: total_sale_price {
    description: "Total sales from items sold"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
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
