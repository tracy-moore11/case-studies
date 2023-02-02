connection: "looker_partner_demo"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project

explore: order_items {
  join: products {
    type: inner
    sql_on: ${order_items.product_id} = ${products.id} ;;
    relationship: many_to_one
    }
  # join: products_crossview {
  #   relationship: one_to_one
  # sql:  ;;
  # }
}
explore: users {}

explore: products {
  join: order_items {
    type: inner
    sql_on: ${products.id} = ${order_items.product_id} ;;
    relationship: one_to_many
    }
}
