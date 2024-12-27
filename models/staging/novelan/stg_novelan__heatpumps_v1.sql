with source as (

    select distinct on(zeitstempel) * from {{ source('novelan', 'novelan_heatpump_v1') }}

),

renamed as (

    select
        {{ dbt_date.convert_timezone("datum", "UTC", "Europe/Berlin") }} as created_date,
        zeitstempel as created_at,
        hup,
        zup,
        bup as bupout,
        zw2,
        ma1,
        mz1,
        zip,
        vd1 as vd1out,
        vd2,
        vent,
        av,
        vbs,
        zw1,
        hd,
        nd,
        mot,
        asd,
        evu,
        tfb1,
        tbw,
        ta,
        trlext,
        trl,
        tvl,
        thg,
        twqaus,
        twqein,
        trlsoll as trl_soll,
        tmk1soll,
        ai1div,
        sup,
        fup2,
        ma2,
        mz2,
        ma3,
        mz3,
        fup3,
        zw3,
        slp,
        ao1,
        ao2,
        swt,
        tss,
        tsk,
        tfb2,
        tfb3,
        tee,
        ai1,
        tmk2soll,
        tmk3soll,
        df,
        sphz,
        spwq,
        pth,
        wmstart

    from source

)

select * from renamed