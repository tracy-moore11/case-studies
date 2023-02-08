connection: "looker_partner_demo"

include: "/views/*.view.lkml"
# include: "/derived_tables/*.view.lkml"

explore: order_items {
  join: products {
    type: inner
    sql_on: ${order_items.product_id} = ${products.id} ;;
    relationship: many_to_one
    }
  join: users {
    type: inner
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: one_to_many
  }
  join: orders_crossview {
    relationship:  one_to_one
    sql:  ;;
  }
}
explore: users {}

explore: products {}
