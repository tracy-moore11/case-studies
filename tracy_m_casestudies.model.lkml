connection: "looker_partner_demo"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project

explore: order_items {
  join: products {
    type: inner
    sql_on: ${order_items.product_id} = ${products.id} ;;
    relationship: one_to_one
    }
  join: users {
    type: inner
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: orders_crossview {
    relationship:  one_to_one
    sql:  ;;
}
}
explore: users {}

explore: products {}
