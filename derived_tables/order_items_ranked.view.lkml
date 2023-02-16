view: order_items_ranked {
  derived_table: {
    sql: with order_dates as (
      select user_id, order_id, min(created_at) order_start_date, max(created_at) order_end_date
      from order_items
    where status<>'Cancelled' and returned_at is null
      group by 1,2
      )
      select order_id, order_start_date, order_end_date,
        row_number() over (partition by user_id order by order_start_date) as first_rn,
        row_number() over (partition by user_id order by order_end_date desc) as last_rn
      from order_dates
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: order_start_date {
    type: time
    hidden: yes
    sql: ${TABLE}.order_start_date ;;
  }

  dimension_group: order_end_date {
    type: time
    hidden: yes
    sql: ${TABLE}.order_end_date ;;
  }
  dimension: first_rn {
    type: number
    hidden: yes
    sql: ${TABLE}.first_rn ;;
  }

  dimension: isfirstorder {
    type: yesno
    sql: ${first_rn}=1 ;;
  }
  dimension: islastorder {
    type: yesno
    sql: ${last_rn}=1 ;;
  }

  dimension: last_rn {
    type: number
    hidden: yes
    sql: ${TABLE}.last_rn ;;
  }

  set: detail {
    fields: [
      order_id,
      order_start_date_time,
      order_end_date_time,
      first_rn,
      last_rn
    ]
  }
}
