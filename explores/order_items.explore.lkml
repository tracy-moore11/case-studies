include: "/views/order_items.view.lkml"
include: "/views/users.view.lkml"
include: "/views/products.view.lkml"
include: "/views/orders_crossview.view.lkml"
include: "/derived_tables/cust_top_lvl_dtl.view.lkml"

explore: order_items {
  join: products {
    type: inner
    sql_on: ${order_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
  join: users {
    type: inner
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship:many_to_one
  }
  join: orders_crossview {
    relationship:  one_to_one
    sql:  ;;
}
join: cust_top_lvl_dtl {
  type: inner
  relationship: many_to_one
  sql_on: ${order_items.user_id}=${cust_top_lvl_dtl.user_id} ;;

}
}
