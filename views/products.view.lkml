view: products {
  sql_table_name: `looker-partners.thelook.products`;;
  drill_fields: [id]

  #--primary key--##
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  ##--dimensions--##
  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    drill_fields: [department, name]
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  ##--measures--##
  measure: num_products {
    type: count
  }
  set: detail {
    fields: [
      id,
      name,
      distribution_centers.name,
      distribution_centers.id,
      inventory_items.count,
      order_items.count
    ]
  }
}
