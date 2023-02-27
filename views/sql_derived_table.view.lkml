
  view: sql_derived_table {
    derived_table: {
      sql: SELECT
            users.city  AS users_city,
            users.id  AS users_id,
            SUM(users.age ) AS users_sum_age
        FROM `orders.users`
             AS users
        GROUP BY
            1,
            2
        ORDER BY
            3 DESC
              ;;
    }

    dimension: users_city {
      type: string
      primary_key: yes
      sql:${TABLE}.users_city;;
    }

    dimension: age{
      type: number
      sql: ${TABLE}.age;;
    }

    measure: age_average {
      type: average
      sql: ${users.age} ;;
    }
  }
