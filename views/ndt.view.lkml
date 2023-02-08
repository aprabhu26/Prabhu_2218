view: ndt {
  derived_table: {
    explore_source: order_items {
      column: count { field: orders.count }
      column: city { field: users.city }
    }
  }
  dimension: count {
    description: ""
    type: number
  }
  dimension: city {
    description: "cityname"
  }
  measure: avg_count_city {
    type: average
    sql:${TABLE}.count;;
  }
}
