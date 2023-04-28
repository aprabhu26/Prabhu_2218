# The name of this view in Looker is "Orders"
view: orders {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `orders.orders`
    ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Campaign" in Explore.

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.


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
    html:
    {% if status._value == 'complete' %}
    <p style="color: black; background-color: green; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif status._value == 'cancelled' %}
    <p style="color: black; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: yellow; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %};;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Status" in Explore.


  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    # sql:case
    # when ${TABLE}.status="complete" then '{{_localization['complete']}}'
    # when ${TABLE}.status="pending" then '{{_localization['pending']}}'
    # else '{{_localization['cancelled']}}'
    # end;;

    # sql: ${TABLE}.status ;;
    # sql: case
    # when ${TABLE}.status = "complete" then '{{_localization['complete']}}'
    # when ${TABLE}.status = "pending" then '{{_localization['pending']}}'
    # else '{{_localization['cancelled']}}'
    # end;;
    html:
    {% if value == 'complete' %}
    <p style="color: black; background-color: green; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'cancelled' %}
    <p style="color: black; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: yellow; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %};;
  #   html:
  #   {% if value == 'complete' %}
  #   {% assign indicator = "green,▲" | split: ',' %}
  #   {% elsif value == 'cancelled' %}
  #   {% assign indicator = "red,▼" | split: ',' %}
  #   {% else %}
  #   {% assign indicator = "black,▬" | split: ',' %}
  # {% endif %}

      #     <font color="{{indicator[0]}}">

      #     {% if value == 99999.12345 %} &infin

      #     {% else %}{{rendered_value}}

      #     {% endif %} {{indicator[1]}}

      #     </font> ;;

    }


  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.id, users.first_name, order_items.count]
  }

  measure: count_organic_users {
    type: count_distinct
    sql:  ${user_id} ;;
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
    filters: {
      field: campaign
      value: "Organic"
    }
  }

  measure: count_display_users {
    type: count_distinct
    sql:  ${user_id} ;;
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
    filters: {
      field: campaign
      value: "Display"
    }
  }

  measure: count_email_users {
    type: count_distinct
    sql:  ${user_id} ;;
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
    filters: {
      field: campaign
      value: "Email"
    }
  }

  measure: count_facebook_users {
    type: count_distinct
    sql:  ${user_id} ;;
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
    filters: {
      field: campaign
      value: "Facebook"
    }
  }

  measure: count_search_users {
    type: count_distinct
    sql:  ${user_id} ;;
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
    filters: {
      field: campaign
      value: "Search"
    }
  }

  parameter: campaign_dynamic_selector {
    type: unquoted
    allowed_value: {
      label: "count_display_users"
      value: "Display"
    }
    allowed_value: {
      label: "count_email_users"
      value: "Email"
    }
    allowed_value: {
      label: "count_organic_users"
      value: "organic"
    }
    allowed_value: {
      label: "count_facebook_users"
      value: "facebook"
    }
    allowed_value: {
      label: "count_search_users"
      value: "seach"
    }
  }

  measure: dynamic_measure{
    type: string
    sql: {%if campaign_dynamic_selector._parameter_value == 'Display'%}
    ${count_display_users}
    {%elsif campaign_dynamic_selector._parameter_value  == 'Email'%}
    ${count_email_users}
    {%elsif campaign_dynamic_selector._parameter_value  == 'organic'%}
    ${count_organic_users}
    {%elsif campaign_dynamic_selector._parameter_value  == 'facebook'%}
    ${count_facebook_users}
    {%else%}
    ${count_search_users}
    {%endif%};;

  }

}
