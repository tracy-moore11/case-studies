connection: "looker_partner_demo"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project

explore: order_items {
  join: products {
    type: inner
    sql_on: ${order_items.product_id} = ${products.id} ;;
    relationship: one_to_one
    }
}
explore: users {}

explore: products {}
