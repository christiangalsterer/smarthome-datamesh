---
title: Welcome to the SmartHome DataMesh
---

<LastRefreshed/>

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
    temp_delta_t
  from smarthome_dwh.temperatures
  where strftime(created_date, '%Y-%m-%d') like '${inputs.day.value}'
  order by timestamp desc
```

<LineChart
    data={temperatures}
    title="Temperatures over Time for {inputs.day.label}"
    x=timestamp
    y={['temp_ruecklauf', 'temp_ruecklauf_soll', 'temp_vorlauf', 'temp_delta_t']}
    yFmt=num2
/>

```sql heat_quantities
  select 
    created_date as timestamp,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heat_quantities
  where strftime(created_date, '%Y-%m-%d') like '${inputs.day.value}'
  order by timestamp desc
```

<LineChart
    data={heat_quantities}
    title="Heat Quantities over Time for {inputs.day.label}"
    x=timestamp
    y={['heat_quantity_heating', 'heat_quantity_water']}
    yFmt=num1
/>
