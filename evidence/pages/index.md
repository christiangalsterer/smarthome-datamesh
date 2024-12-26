---
title: SmartHome DataMesh
---

```sql days
  select
      strftime(created_date, '%Y-%m-%d') as day
  from smarthome_dwh.temperatures
  order by day desc
```

```sql years
  select
      strftime(created_date, '%Y') as year
  from smarthome_dwh.temperatures
  order by year desc
```

```sql heat_quantities_yearly
  select 
    strftime(year, '%Y') as year,
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
  where strftime(month, '%Y') like '${inputs.year.value}'
  order by month desc;
```

```sql heat_quantities_daily
  select 
    day,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heat_quantities_daily
  where strftime(day, '%Y-%m') like '${inputs.year.value}-12'
  order by day desc;
```
<LastRefreshed/>


## Yearly

<Dropdown data={years} name=year value=year>
</Dropdown>

<LineBreak/>

<BigValue 
  data={heat_quantities_yearly} 
  value=heat_quantity_heating
  fmt=num2
/>

<BigValue 
  data={heat_quantities_yearly} 
  value=heat_quantity_water
  fmt=num2
/>

<Grid cols=2>
<BarChart 
    data={heat_quantities_yearly}
    title="Heat Quantities over time for {inputs.year.label}"
    x=year
    y=heat_quantity_heating
    xFmt=yyyy
/>

<BarChart 
    data={heat_quantities_yearly}
    title="Heat Quantities over time for {inputs.year.label}"
    x=year
    y=heat_quantity_water
    xFmt=yyyy
/>
</Grid>

<LineChart
    data={heat_quantities_monthly}
    title="Heat Quantities over time for {inputs.year.label}"
    x=month
    y={['heat_quantity_heating', 'heat_quantity_water']}
    xFmt="yyyy-mm-dd"
    yFmt=num1
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

<LineChart
    data={heat_quantities_daily}
    title="Heat Quantities over time for {inputs.year.label}"
    x=day
    y={['heat_quantity_heating', 'heat_quantity_water']}
    xFmt="yyyy-mm-dd"
    yFmt=num1
/>

## Daily

<Dropdown data={days} name=day value=day>
</Dropdown>

<DateRange
    name=day_range
    data={days}
    dates=day
/>

<LineBreak/>

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

```sql temperatures
  select 
    created_date as timestamp,
    temp_ruecklauf,
    temp_ruecklauf_soll,
    temp_vorlauf,
    temp_delta_t
  from smarthome_dwh.temperatures
  where strftime(created_date, '%Y-%m-%d') like '${inputs.day.value}'
  --where timestamp between '${inputs.day_range.start}' and '${inputs.day_range.end}'
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
