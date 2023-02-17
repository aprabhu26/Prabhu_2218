- dashboard: product_count
  title: Product Count
  layout: newspaper
  preferred_viewer: dashboards-next
  preferred_slug: rjPJGweyRfm5JzmY9tFR0y
  elements:
  - title: Product Count
    name: Product Count
    model: ecommerce_prabhu2218
    explore: products
    type: looker_grid
    fields: [products.brand, products.department, products.count]
    pivots: [products.department]
    sorts: [products.department, products.count desc 0]
    limit: 500
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 12
