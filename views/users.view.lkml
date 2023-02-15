view: users {
  sql_table_name: `looker-partners.thelook.users`
    ;;
  drill_fields: [id]

##--primary key--##
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  ##--dimensions--##
  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [15, 26, 36, 51, 66]
    sql: ${age} ;;
    style:  integer
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    drill_fields: [state]
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: days_since_signup {
    type: number
    sql: date_diff(current_date,${created_date},day) ;;
  }

  dimension: days_since_signup_grp {
    type: tier
    sql: ${days_since_signup} ;;
    tiers: [30,90,180,365,730]
    style: integer
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: months_since_signup {
    type: number
    sql: date_diff(current_date,${created_date},month) ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: street_address {
    type: string
    sql: ${TABLE}.street_address ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
    drill_fields: [user_details*]
  }

  ##--measures--##
  measure: average_age {
    type: average
    sql: ${age} ;;
  }

  measure: average_days_since_signup {
    type: average
    sql: ${days_since_signup} ;;
  }

  measure: average_months_since_signup {
    type: average
    sql: ${months_since_signup} ;;
  }

  measure: total_users {
    type: count
  }

  set: user_details {
    fields: [gender, age_tier]
  }
}
