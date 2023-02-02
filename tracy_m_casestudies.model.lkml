connection: "looker_partner_demo"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project

explore: order_items {
  join: products {
    type: inner
    sql_on: ${order_items.product_id} = ${products.id} ;;
    relationship: many_to_one
    }
}
explore: users {}
explore: products {
  join: order_items {
    type: inner
    sql_on: ${products.id} = ${order_items.product_id} ;;
    relationship: one_to_many
    }
}

#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
