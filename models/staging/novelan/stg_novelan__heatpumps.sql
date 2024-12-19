

with source as (

    select * from {{ source('novelan', 'novelan_heatpump') }}

),

renamed as (

    select
        {{ dbt_date.convert_timezone("datum", "UTC", "Europe/Berlin") }} as created_date,
        zeitstempel as created_at,
        tvl,
        trl,
        twe,
        twa,
        thg,
        tbw,
        tbw_soll,
        tfb1,
        ta,
        mitteltemperatur as ta_average,
        trl_ext,
        trl_soll,
        mk1_soll,
        CAST(REPLACE(REPLACE(wmz_hz, '.', ''), ',', '.') as DOUBLE) AS wmz_hz,
        wmz_bw,
        wmz_sw,
        error_id,
        bivalence,
        demand,
        hdin,
        ndin,
        motin,
        asdin,
        evuin,
        hupout,
        zupout,
        bupout,
        zw2sstout,
        ma1out,
        mz1out,
        zipout,
        vd1out,
        vd2out,
        venout,
        avout,
        vboout,
        zw1out,
        supout,
        fp2out,
        ma2out,
        mz2out,
        ma3out,
        mz3out,
        fp3out,
        zw3sstout,
        slpout,
        swtin,
        tss,
        tsk,
        tfb_2,
        tfb_3,
        tee,
        mk2_soll,
        mk3_soll,
        analogin,
        analogout_1,
        analogout_2,
        sw_stand,
        sw_revision,
        wp_typ,
        df,
        sphz,
        spwq,
        pth,
        wmstart

    from source

)

select * from renamed

