view: ndt {
  derived_table: {
    explore_source: orders {
      column: count { field: orders.count }
      column: city { field: users.city }
    }
  }
  dimension: count {
    description: ""
    type: number
  }
  dimension: city {
    description: "city_name"
  }
  measure: avg_count_city {
    type: average
    sql:${TABLE}.count;;
  }
}
