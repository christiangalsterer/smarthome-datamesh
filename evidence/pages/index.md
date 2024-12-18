---
title: Welcome to the SmartHome DataMesh
---

<LastRefreshed/>

```sql heat_quantities_yearly
  select 
    year,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heat_quantities_yearly
  order by year desc;
```

```sql heat_quantities_monthly
  select 
    month,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heat_quantities_monthly
  order by month desc;
```

```sql heat_quantities_daily
  select 
    day,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heat_quantities_daily
  order by day desc;
```

## Yearly
<BigValue 
  data={heat_quantities_yearly} 
  value=heat_quantity_heating
  sparkline=year
  fmt=num2
/>

<BigValue 
  data={heat_quantities_yearly} 
  value=heat_quantity_water
  sparkline=year
  fmt=num2
/>

## Monthly

<BigValue 
  data={heat_quantities_monthly} 
  value=heat_quantity_heating
  sparkline=month
  fmt=num2
/>

<BigValue 
  data={heat_quantities_monthly} 
  value=heat_quantity_water
  sparkline=month
  fmt=num2
/>

## Daily

<BigValue 
  data={heat_quantities_daily} 
  value=heat_quantity_heating
  sparkline=day
  fmt=num2
/>

<BigValue 
  data={heat_quantities_daily} 
  value=heat_quantity_water
  sparkline=day
  fmt=num2
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
    temp_delta_t
  from smarthome_dwh.temperatures
  where strftime(created_date, '%Y-%m-%d') like '${inputs.day.value}'
  order by timestamp desc
```

<LineChart
    data={temperatures}
    title="Temperatures over time for {inputs.day.label}"
    x=timestamp
    y={['temp_ruecklauf', 'temp_ruecklauf_soll', 'temp_vorlauf', 'temp_delta_t']}
    xFmt="yyyy-mm-dd hh:mm:s"
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
    title="Heat Quantities over time for {inputs.day.label}"
    x=timestamp
    y={['heat_quantity_heating', 'heat_quantity_water']}
    xFmt="yyyy-mm-dd hh:mm:s"
    yFmt=num1
/>

```sql compressor_usage
  select 
    created_date as timestamp,
    compressor_heating,
    compressor_water
  from smarthome_dwh.compressor_usage
  where strftime(created_date, '%Y-%m-%d') like '${inputs.day.value}'
  order by timestamp desc
```

<LineChart
    data={compressor_usage}
    title="Compressors usage for {inputs.day.label}"
    x=timestamp
    y={['compressor_heating', 'compressor_water']}
    xFmt="yyyy-mm-dd hh:mm:s"
    yFmt=num1
/>
