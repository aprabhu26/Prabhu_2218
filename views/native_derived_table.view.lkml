view: native_derived_table {
  derived_table: {
    explore_source: users {
      column: sum_age {}
      column: city {}
      column: count {}
      derived_column: avg_age{
        sql: sum_age/count;;
      }
    }
  }

  dimension: city {
  }

  dimension: sum_age {
    type: number
  }

  measure: avg_age {
    type: average
  }

}
