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
  where month between (date_trunc('month', current_date()) - INTERVAL 13 MONTH) and current_date()
  order by month desc;
```

```sql meter_heat_quantities_last_13_month
  select 
    month,
    heat_quantity
  from smarthome_dwh.meter_heat_quantities_monthly
  where month between (date_trunc('month', current_date()) - INTERVAL 13 MONTH) and current_date()
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
    day,
    heat_quantity_heating,
    heat_quantity_water
  from smarthome_dwh.heatpump_heat_quantities_daily
  where strftime(day, '%Y-%m-%d') like '${inputs.day.value}'
  order by day desc;
```

```sql heat_quantities
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

```sql compressor_starts
  select 
    created_date as timestamp,
    compressor_start_heating,
    compressor_start_water
  from smarthome_dwh.heatpump_compressor_starts
  where strftime(created_date, '%Y-%m-%d') like '${inputs.day.value}'
  order by timestamp desc
```

```sql compressor_starts_day
  select 
    day,
    compressor_starts_heating,
    compressor_starts_water
  from smarthome_dwh.heatpump_compressor_starts_daily
  where strftime(day, '%Y-%m-%d') like '${inputs.day.value}'
  order by day desc
```

```sql compressor_starts_daily
  select 
    day,
    compressor_starts_heating,
    compressor_starts_water
  from smarthome_dwh.heatpump_compressor_starts_daily
  where strftime(day, '%Y-%m') like '${inputs.month.value}'
  order by day desc;
```

```sql compressor_starts_last_month
  select 
    day as timestamp,
    compressor_starts_heating,
    compressor_starts_water
  from smarthome_dwh.heatpump_compressor_starts_daily
  where day between current_date() - INTERVAL 1 MONTH and current_date()
  order by timestamp desc
```

```sql compressor_starts_month
  select 
    month,
    compressor_starts_heating,
    compressor_starts_water
  from smarthome_dwh.heatpump_compressor_starts_monthly
  where strftime(month, '%Y-%m') like '${inputs.month.value}'
  order by month desc;
```

```sql compressor_starts_last_13_months
  select 
    month,
    compressor_starts_heating,
    compressor_starts_water
  from smarthome_dwh.heatpump_compressor_starts_monthly
  where month between (date_trunc('month', current_date()) - INTERVAL 13 MONTH) and current_date()
  order by month desc;
```

```sql compressor_starts_yearly
  select 
    strftime(year, '%Y') as year,
    compressor_starts_heating,
    compressor_starts_water
  from smarthome_dwh.heatpump_compressor_starts_yearly
  order by year desc;
```

```sql compressor_starts_current_year
  select 
    strftime(year, '%Y') as year,
    compressor_starts_heating,
    compressor_starts_water
  from smarthome_dwh.heatpump_compressor_starts_yearly
  where strftime(year, '%Y') like date_part('year', current_date())
  order by year desc;
```

```sql compressor_starts_total_month
  select 
    month,
    compressor_starts
  from smarthome_dwh.heatpump_compressor_starts_total_monthly
  where strftime(month, '%Y-%m') like '${inputs.month.value}'
  order by month desc;
```

```sql compressor_starts_total_monthly
  select 
    strftime(month, '%Y-%m') as month,
    compressor_starts
  from smarthome_dwh.heatpump_compressor_starts_total_monthly
  order by month desc;
```

```sql compressor_starts_total_yearly
  select 
    strftime(year, '%Y') as year,
    compressor_starts
  from smarthome_dwh.heatpump_compressor_starts_total_yearly
  order by year desc;
```

```sql compressor_starts_total_current_year
  select 
    strftime(year, '%Y') as year,
    compressor_starts
  from smarthome_dwh.heatpump_compressor_starts_total_yearly
  where strftime(year, '%Y') like date_part('year', current_date())
  order by year desc;
```

<LastRefreshed/>

## Overview

<Grid cols=2>
<BigValue 
  data={heat_quantities_current_year} 
  value=heat_quantity_heating
  title="Heat Quantity Heating YTD"
  fmt=num0
/>

<BigValue 
  data={heat_quantities_current_year} 
  value=heat_quantity_water
  title="Heat Quantity Water YTD"
  fmt=num0
/>
</Grid>

<Grid cols=3>
<BigValue 
  data={compressor_starts_current_year} 
  value=compressor_starts_heating
  title="Compressor Starts Heating YTD"
  fmt=num0
/>

<BigValue 
  data={compressor_starts_current_year} 
  value=compressor_starts_water
  title="Compressor Starts Water YTD"
  fmt=num0
/>

<BigValue 
  data={compressor_starts_total_current_year} 
  value=compressor_starts
  title="Compressor Starts Total YTD"
  fmt=num0
/>
</Grid>

<LineChart
    data={heat_quantities_last_13_month}
    title="Heat Quantity last 13 months"
    x=month
    y={['heat_quantity_heating', 'heat_quantity_water']}
    xFmt="yyyy-mm"
    yFmt=num0
    lineWidth=1    
    connectGroup=monthly
/>

<LineChart
    data={heat_quantities_last_month}
    title="Heat Quantity last month"
    x=day
    y={['heat_quantity_heating', 'heat_quantity_water']}
    xFmt="yyyy-mm-dd"
    yFmt=num0
    lineWidth=1    
    connectGroup=daily
/>

<LineChart
    data={meter_heat_quantities_last_13_month}
    title="Heat Quantity External Meter last 13 months"
    x=month
    y={['heat_quantity']}
    xFmt="yyyy-mm"
    yFmt=num0
    lineWidth=1
    connectGroup=monthly
/>

<LineChart
    data={temperatures_last_7_days}
    title="Temperature last 7 days"
    x=timestamp
    y={['temp_ruecklauf', 'temp_ruecklauf_soll', 'temp_vorlauf', 'temp_delta_t']}
    xFmt="yyyy-mm-dd hh:mm:s"
    yFmt=num2
    lineWidth=1
/>

<LineChart
    data={compressor_starts_last_13_months}
    title="Compressor Starts last 13 months"
    x=month
    y={['compressor_starts_heating', 'compressor_starts_water']}
    xFmt="yyyy-mm"
    yFmt=num0
    lineWidth=1    
    connectGroup=monthly
/>

<LineChart
    data={compressor_starts_last_month}
    title="Compressor Starts last month"
    x=timestamp
    y={['compressor_starts_heating', 'compressor_starts_water']}
    xFmt="yyyy-mm-dd"
    yFmt=num1
    lineWidth=1
    connectGroup=daily
/>

## Yearly

<Dropdown data={years} name=year value=year order="year desc">
</Dropdown>

<LineBreak/>

<Grid cols=2>
<BarChart 
    data={heat_quantities_yearly}
    title="Heat Quantity Heating Per Year"
    x=year
    y=heat_quantity_heating
    xFmt=yyyy
    sort=false
/>

<BarChart 
    data={heat_quantities_yearly}
    title="Heat Quantity Water Per Year"
    x=year
    y=heat_quantity_water
    xFmt=yyyy
    sort=false
/>
</Grid>

<Grid cols=3>
<BarChart 
    data={compressor_starts_yearly}
    title="Compressor Heating Starts Per Year"
    x=year
    y=compressor_starts_heating
    xFmt=yyyy
    sort=false
/>

<BarChart 
    data={compressor_starts_yearly}
    title="Compressor Water Starts Per Year"
    x=year
    y=compressor_starts_water
    xFmt=yyyy
    sort=false
/>

<BarChart 
    data={compressor_starts_total_yearly}
    title="Compressor Starts Total Per Year"
    x=year
    y=compressor_starts
    xFmt=yyyy
    sort=false
/>

</Grid>

<LineChart
    data={heat_quantities_monthly}
    title="Heat Quantity {inputs.year.label}"
    x=month
    y={['heat_quantity_heating', 'heat_quantity_water']}
    xFmt="yyyy-mm-dd"
    yFmt=num1
    lineWidth=1
    connectGroup=yearly
/>

## Monthly

<Dropdown data={months} name=month value=month order="month desc">
</Dropdown>

<LineBreak/>

<Grid cols=2>
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
</Grid>

<Grid cols=3>
<BigValue 
  data={compressor_starts_month} 
  value=compressor_starts_heating
  sparkline=month
  fmt=num0
/>

<BigValue 
  data={compressor_starts_month} 
  value=compressor_starts_water
  sparkline=month
  fmt=num0
/>

<BigValue 
  data={compressor_starts_total_month} 
  value=compressor_starts
  sparkline=month
  fmt=num0
/>
</Grid>

<LineChart
    data={heat_quantities_daily}
    title="Heat Quantity {inputs.month.label}"
    x=day
    y={['heat_quantity_heating', 'heat_quantity_water']}
    xFmt="yyyy-mm-dd"
    yFmt=num0
    lineWidth=1
    connectGroup=daily
/>

<LineChart
    data={compressor_starts_daily}
    title="Compressor Starts {inputs.month.label}"
    x=day
    y={['compressor_starts_heating', 'compressor_starts_water']}
    xFmt="yyyy-mm-dd"
    yFmt=num0
    lineWidth=1    
    connectGroup=daily
/>

## Daily

<Dropdown data={days} name=day value=day order="day desc">
</Dropdown>

<LineBreak/>

<BigValue 
  data={heat_quantities_day} 
  value=heat_quantity_heating
  sparkline=day
  fmt=num0
/>

<BigValue 
  data={heat_quantities_day}
  value=heat_quantity_water
  sparkline=day
  fmt=num0
/>

<BigValue 
  data={compressor_starts_day} 
  value=compressor_starts_heating
  title="Compressor Starts Heating"
  fmt=num0
/>

<BigValue 
  data={compressor_starts_day} 
  value=compressor_starts_water
  title="Compressor Starts Water"
  fmt=num0
/>

<LineChart
    data={heatpump_temperatures_day}
    title="Temperature Heatpump {inputs.day.label}"
    x=timestamp
    y={['temp_ruecklauf', 'temp_ruecklauf_soll', 'temp_vorlauf', 'temp_delta_t']}
    xFmt="yyyy-mm-dd hh:mm:s"
    yFmt=num2
    lineWidth=1
    connectGroup=daily
/>

<LineChart
    data={outside_temperatures_day}
    title="Temperature Outside {inputs.day.label}"
    x=timestamp
    y={['temp_outside']}
    xFmt="yyyy-mm-dd hh:mm:s"
    yFmt=num2
    lineWidth=1
    connectGroup=daily
/>

<LineChart
    data={heatpump_temperatures_day}
    title="Temperature Water {inputs.day.label}"
    x=timestamp
    y={['temp_water', 'temp_water_soll']}
    xFmt="yyyy-mm-dd hh:mm:s"
    yFmt=num2
    lineWidth=1
    connectGroup=daily
/>

<LineChart
    data={heat_quantities}
    title="Heat Quantity {inputs.day.label}"
    x=timestamp
    y={['heat_quantity_heating', 'heat_quantity_water']}
    xFmt="yyyy-mm-dd"
    yFmt=num0
    lineWidth=1    
    connectGroup=daily
/>

<LineChart
    data={compressor_starts}
    title="Compressor Starts {inputs.day.label}"
    x=timestamp
    y={['compressor_start_heating', 'compressor_start_water']}
    xFmt="yyyy-mm-dd hh:mm:s"
    yFmt=num2
    lineWidth=1
    connectGroup=daily
/>

