include: "/views/order_items.view.lkml"
include: "/views/users.view.lkml"
include: "/views/products.view.lkml"
include: "/derived_tables/cust_top_lvl_dtl.view.lkml"
include: "/derived_tables/order_items_ranked.view.lkml"

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
join: cust_top_lvl_dtl {
  type: inner
  relationship: many_to_one
  sql_on: ${order_items.user_id}=${cust_top_lvl_dtl.user_id} ;;

  }
join: order_items_ranked {
  type: left_outer
  sql_on: ${order_items.order_id}=${order_items_ranked.order_id} ;;
  relationship: many_to_one
}
}
