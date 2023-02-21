# Define the database connection to be used for this model.
connection: "looker-dcl-data"

# include all the views
include: "/views/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: ecommerce_prabhu2218_default_datagroup {
  sql_trigger: SELECT EXTRACT( DAY FROM DATE_ADD(current_date(), INTERVAL 1 DAY)) != 23 ;;
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "24 hour"
}

persist_with: ecommerce_prabhu2218_default_datagroup

# access_grant: limited_access_feilds {
#   user_attribute: access_grant_test
#   allowed_values: ["prabhu"]
# }
explore: users {
  # access_filter: {
  #   field: users.state
  #   user_attribute: access_filter_test
  # }

  # required_access_grants: [limited_access_feilds]
}

explore: products {}

explore: employee_master {}

explore: order_items {}

explore: inventory_items_vijaya {
  join: products {
    type: left_outer
    sql_on: ${inventory_items_vijaya.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: product_sheets {
  join: products {
    type: left_outer
    sql_on: ${product_sheets.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: sql_derived_table {
  join: users {
    type: left_outer
    sql_on: ${users.city} = ${sql_derived_table.users_city};;
    relationship: many_to_one
  }
}

explore: native_derived_table {
  join: users {
    type: left_outer
    sql_on: ${users.city} = ${native_derived_table.city};;
    relationship: many_to_one
  }
}

explore: ndt {
  join: users {
    type: left_outer
    sql_on: ${users.city} = ${ndt.city};;
    relationship: many_to_one
  }
}





# # explore: order_items {
#   join: orders {
#     type: left_outer
#     sql_on: ${order_items.order_id} = ${orders.id} ;;
#     relationship: many_to_one
#   }

#   join: users {
#     type: left_outer
#     sql_on: ${orders.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }

#   join: inventory_items {
#     type: left_outer
#     sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
#     relationship: many_to_one
#   }

#   join: products {
#     type: left_outer
#     sql_on: ${inventory_items.product_id} = ${products.id} ;;
#     relationship: many_to_one
#   }
# }
