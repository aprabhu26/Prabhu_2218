- name: add_a_unique_name_1676628035
  title: Untitled Visualization
  model: ecommerce_prabhu2218
  explore: orders
  type: table
  fields: [orders.created_year, orders.count, orders.dynamic_measure]
  filters:
    orders.campaign_dynamic_selector: Email
  sorts: [orders.created_year desc]
  limit: 500
  column_limit: 50
