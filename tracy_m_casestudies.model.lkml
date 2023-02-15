connection: "looker_partner_demo"

include: "/explores/**.lkml"

explore: users_test {
  from: users
}
