view: product_details {
  derived_table: {
    sql: select user_id, p.name, p.brand, p.category, cast(oi.created_at as date) as order_date,
        rank() over (partition by user_id, brand order by cast(oi.created_at as date)) as brand_purchase_rank,
        rank() over (partition by user_id, category order by cast(oi.created_at as date)) as category_purchase_rank
      from order_items oi
        join products p on oi.product_id=p.id
      where returned_at is null and status<>'Cancelled'
       ;;
  }

  measure: count {
    type: count
    label: "Total Purchases"
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: order_date {
    type: date
    datatype: date
    sql: ${TABLE}.order_date ;;
  }

  dimension: brand_purchase_rank {
    type: number
    sql: ${TABLE}.brand_purchase_rank ;;
  }

  dimension: category_purchase_rank {
    type: number
    sql: ${TABLE}.category_purchase_rank ;;
  }

  measure: percent_rpt_brand_purchase {
    type: number
    label: "Brand Repeat Purchase Rate"
    sql: ${total_rpt_brand}/${count} ;;
    value_format_name: percent_2
  }

  measure: percent_rpt_category_purchase {
    type: number
    label: "Category Repeat Purchase Rate"
    sql: ${total_rpt_category}/${count} ;;
    value_format_name: percent_2
  }

  measure: total_rpt_brand {
    type: count
    label: "Brand Repeat Purchases"
    filters: [brand_purchase_rank: ">1"]
  }

  measure: total_rpt_category {
    type: count
    label: "Category Repeat Purchases"
    filters: [category_purchase_rank: ">1"]
  }

  set: detail {
    fields: [
      user_id,
      name,
      brand,
      category,
      order_date,
      brand_purchase_rank,
      category_purchase_rank
    ]
  }
}
