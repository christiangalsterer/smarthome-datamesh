---
title: Welcome to the SmartHome DataMesh
---

```sql categories
  select
      category
  from needful_things.orders
  group by category
```

<Dropdown data={categories} name=category value=category>
    <DropdownOption value="%" valueLabel="All Categories"/>
</Dropdown>

<Dropdown name=year>
    <DropdownOption value=% valueLabel="All Years"/>
    <DropdownOption value=2019/>
    <DropdownOption value=2020/>
    <DropdownOption value=2021/>
</Dropdown>

```sql orders_by_category
  select 
      date_trunc('month', order_datetime) as month,
      sum(sales) as sales_usd,
      category
  from needful_things.orders
  where category like '${inputs.category.value}'
  and date_part('year', order_datetime) like '${inputs.year.value}'
  group by all
  order by sales_usd desc
```
<LineChart
    data={orders_by_category}
    title="Sales by Month, {inputs.category.label}"
    x=month
    y=sales_usd
    series=category
/>

```sql days
  select
      strftime(created_date, '%Y-%m-%d') as day
  from smarthome_dwh.temperatures
  order by day desc
```

<Dropdown data={days} name=day value=day>
  <DropdownOption value="%" valueLabel="All Days"/>
</Dropdown>

```sql temperatures
  select 
    created_date as timestamp,
    temp_ruecklauf,
    temp_ruecklauf_soll,
    temp_vorlauf,
  from smarthome_dwh.temperatures
  where strftime(created_date, '%Y-%m-%d') like '${inputs.day.value}'
  order by timestamp desc
```

<LineChart
    data={temperatures}
    title="Temperatures over Time for {inputs.day.label}"
    x=timestamp
    y={['temp_ruecklauf', 'temp_ruecklauf_soll', 'temp_vorlauf']}
    fmt=num0
/>

