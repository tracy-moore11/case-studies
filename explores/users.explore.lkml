include: "/views/users.view.lkml"
include: "/derived_tables/cust_top_lvl_dtl.view.lkml"

explore: users {
  join: cust_top_lvl_dtl {
    type: left_outer
    sql_on: ${users.id}=${cust_top_lvl_dtl.user_id} ;;
    relationship: one_to_one
  }
}
