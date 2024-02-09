select
    "月",
    col_003 as "計画",
    "成約数" as "実績",
    cast("成約数" as float) / cast(col_003 as float) * 100 as "計画対比"
from
(
    select
            "成約日" as "月",
            count("契約ID") as "成約数"
    from
    (
        select
            t1.contract_id as "契約ID",
            date_format(t1.contract_entry_datetime, '%Y年%m月') as "成約日"
        from
            prod_kintojpn_view.view_rdb_contract as t1 /* 契約 */
        where
            t1.contract_entry_datetime >= date_add('month', -10, current_date)
            and t1.delete_flag = 0
            and t1.contract_status_sv in ('009', '010', '011', '101', '902', '903')
            and t1.contract_plan_detail_sv not in (9,10,11,12)
    )
    group by "成約日"
) as table1
left join (select * from prod_nicola_user.V_0002KG74SZXDK12CXCG2NK1KG1 where col_002='見直し計画') as table2 on table1."月"= table2.col_001
order by "月"