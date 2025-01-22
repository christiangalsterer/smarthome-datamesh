---
title: Energy Monitor
---

```sql years
  select distinct
      strftime(created_date, '%Y') as year
  from smarthome_dwh.heatpump_temperatures
  order by year desc
```

```sql months
  select distinct
      strftime(created_date, '%Y-%m') as month
  from smarthome_dwh.heatpump_temperatures
  order by month desc
```

```sql days
  select distinct
      strftime(created_date, '%Y-%m-%d') as day
  from smarthome_dwh.heatpump_temperatures
  order by day desc
```

```sql heat_quantities_current_year
  select 
    strftime(year, '%Y') as year,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heatpump_heat_quantities_yearly
  where strftime(year, '%Y') like date_part('year', current_date())
  order by year desc;
```

```sql heat_quantities_yearly
  select 
    strftime(year, '%Y') as year,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heatpump_heat_quantities_yearly
  order by year desc;
```

```sql heat_quantities_last_13_month
  select 
    month,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heatpump_heat_quantities_monthly
  where month between current_date() - INTERVAL 13 MONTH and current_date()
  order by month desc;
```

```sql meter_heat_quantities_last_13_month
  select 
    month,
    heat_quantity
  from smarthome_dwh.meter_heat_quantities_monthly
  where month between current_date() - INTERVAL 13 MONTH and current_date()
  order by month desc;
```

```sql heat_quantities_last_month
  select 
    day,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heatpump_heat_quantities_daily
  where day between current_date() - INTERVAL 1 MONTH and current_date()
  order by day desc;
```

```sql heat_quantities_monthly
  select 
    month,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heatpump_heat_quantities_monthly
  where strftime(month, '%Y') like '${inputs.year.value}'
  order by month desc;
```

```sql heat_quantities_month
  select 
    month,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heatpump_heat_quantities_monthly
  where strftime(month, '%Y-%m') like '${inputs.month.value}'
  order by month desc;
```

```sql heat_quantities_daily
  select 
    day,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heatpump_heat_quantities_daily
  where strftime(day, '%Y-%m') like '${inputs.month.value}'
  order by day desc;
```

```sql heat_quantities_day
  select 
    created_date as timestamp,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heatpump_heat_quantities
  where strftime(created_date, '%Y-%m-%d') like '${inputs.day.value}'
  order by timestamp desc
```

```sql heatpump_temperatures_day
  select 
    created_date as timestamp,
    temp_ruecklauf,
    temp_ruecklauf_soll,
    temp_vorlauf,
    temp_delta_t,
    temp_water,
    temp_water_soll
  from smarthome_dwh.heatpump_temperatures
  where strftime(created_date, '%Y-%m-%d') like '${inputs.day.value}'
  order by timestamp desc
```

```sql temperatures_last_7_days
  select 
    created_date as timestamp,
    temp_ruecklauf,
    temp_ruecklauf_soll,
    temp_vorlauf,
    temp_delta_t
  from smarthome_dwh.heatpump_temperatures
  where timestamp between current_date() - INTERVAL 7 DAY and current_date()
  order by timestamp desc
```

```sql outside_temperatures_day
  select 
    created_date as timestamp,
    temp_outside
  from smarthome_dwh.outside_temperatures
  where strftime(created_date, '%Y-%m-%d') like '${inputs.day.value}'
  order by timestamp desc
```

```sql compressor_usage_day
  select 
    created_date as timestamp,
    compressor_heating,
    compressor_water
  from smarthome_dwh.heatpump_compressor_usage
  where strftime(created_date, '%Y-%m-%d') like '${inputs.day.value}'
  order by timestamp desc
```

```sql compressor_usage_last_7_days
  select 
    created_date as timestamp,
    compressor_heating,
    compressor_water
  from smarthome_dwh.heatpump_compressor_usage
  where created_date between current_date() - INTERVAL 7 DAY and current_date()
  order by timestamp desc
```

<LastRefreshed/>

## Overview

<BigValue 
  data={heat_quantities_current_year} 
  value=heat_quantity_heating
  fmt=num0
/>

<BigValue 
  data={heat_quantities_current_year} 
  value=heat_quantity_water
  fmt=num0
/>

<LineChart
    data={heat_quantities_last_13_month}
    title="Heat Quantities last 13 months"
    x=month
    y={['heat_quantity_heating', 'heat_quantity_water']}
    xFmt="yyyy-mm"
    yFmt=num0
/>

<LineChart
    data={heat_quantities_last_month}
    title="Heat Quantities last month"
    x=day
    y={['heat_quantity_heating', 'heat_quantity_water']}
    xFmt="yyyy-mm-dd"
    yFmt=num0
/>

<LineChart
    data={meter_heat_quantities_last_13_month}
    title="Heat Quantities External Meter last 13 months"
    x=month
    y={['heat_quantity']}
    xFmt="yyyy-mm"
    yFmt=num0
/>

<LineChart
    data={temperatures_last_7_days}
    title="Temperatures last 7 days"
    x=timestamp
    y={['temp_ruecklauf', 'temp_ruecklauf_soll', 'temp_vorlauf', 'temp_delta_t']}
    xFmt="yyyy-mm-dd hh:mm:s"
    yFmt=num2
/>

<LineChart
    data={compressor_usage_last_7_days}
    title="Compressors usage for last 7 days"
    x=timestamp
    y={['compressor_heating', 'compressor_water']}
    xFmt="yyyy-mm-dd hh:mm:s"
    yFmt=num1
/>

## Yearly

<Dropdown data={years} name=year value=year>
</Dropdown>

<LineBreak/>

<Grid cols=2>
<BarChart 
    data={heat_quantities_yearly}
    title="Heat Quantities Heating Per Year"
    x=year
    y=heat_quantity_heating
    xFmt=yyyy
    sort=false
/>

<BarChart 
    data={heat_quantities_yearly}
    title="Heat Quantities Water Per Year"
    x=year
    y=heat_quantity_water
    xFmt=yyyy
    sort=false
/>
</Grid>

<LineChart
    data={heat_quantities_monthly}
    title="Heat Quantities {inputs.year.label}"
    x=month
    y={['heat_quantity_heating', 'heat_quantity_water']}
    xFmt="yyyy-mm-dd"
    yFmt=num1
/>

## Monthly

<Dropdown data={months} name=month value=month>
</Dropdown>

<LineBreak/>

<BigValue 
  data={heat_quantities_month} 
  value=heat_quantity_heating
  sparkline=month
  fmt=num0
/>

<BigValue 
  data={heat_quantities_month} 
  value=heat_quantity_water
  sparkline=month
  fmt=num0
/>

<LineChart
    data={heat_quantities_daily}
    title="Heat Quantities {inputs.month.label}"
    x=day
    y={['heat_quantity_heating', 'heat_quantity_water']}
    xFmt="yyyy-mm-dd"
    yFmt=num0
/>

## Daily

<Dropdown data={days} name=day value=day>
</Dropdown>

<LineBreak/>

<BigValue 
  data={heat_quantities_daily} 
  value=heat_quantity_heating
  sparkline=day
  fmt=num0
/>

<BigValue 
  data={heat_quantities_daily} 
  value=heat_quantity_water
  sparkline=day
  fmt=num0
/>

<LineChart
    data={heatpump_temperatures_day}
    title="Temperatures Heatpump {inputs.day.label}"
    x=timestamp
    y={['temp_ruecklauf', 'temp_ruecklauf_soll', 'temp_vorlauf', 'temp_delta_t']}
    xFmt="yyyy-mm-dd hh:mm:s"
    yFmt=num2
    connectGroup=daily
/>

<LineChart
    data={outside_temperatures_day}
    title="Temperatures Outside {inputs.day.label}"
    x=timestamp
    y={['temp_outside']}
    xFmt="yyyy-mm-dd hh:mm:s"
    yFmt=num2
    connectGroup=daily
/>

<LineChart
    data={heatpump_temperatures_day}
    title="Temperatures Water {inputs.day.label}"
    x=timestamp
    y={['temp_water', 'temp_water_soll']}
    xFmt="yyyy-mm-dd hh:mm:s"
    yFmt=num2
    connectGroup=daily
/>

<LineChart
    data={heat_quantities_day}
    title="Heat Quantities {inputs.day.label}"
    x=timestamp
    y={['heat_quantity_heating', 'heat_quantity_water']}
    xFmt="yyyy-mm-dd"
    yFmt=num0
    connectGroup=daily
/>

<LineChart
    data={compressor_usage_day}
    title="Compressors usage {inputs.day.label}"
    x=timestamp
    y={['compressor_heating', 'compressor_water']}
    xFmt="yyyy-mm-dd hh:mm:s"
    yFmt=num2
    connectGroup=daily
/>

