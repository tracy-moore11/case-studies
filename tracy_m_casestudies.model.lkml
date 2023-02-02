connection: "looker_partner_demo"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project

explore: order_items {}
explore: users {}
explore: products {}

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
