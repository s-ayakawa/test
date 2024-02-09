select
        "成約日",
        count("契約ID") as "成約数"
from
(
    select
        t1.contract_id as "契約ID",
        date_format(t1.contract_entry_datetime, '%Y/%m/%d') as "成約日"
    from
        prod_kintojpn_view.view_rdb_contract as t1 /* 契約 */
    where
        t1.contract_entry_datetime >= date_add('month', -1, current_date)
        and t1.delete_flag = 0
        and t1.contract_status_sv in ('009', '010', '011', '101', '902', '903')
        and t1.contract_plan_detail_sv not in (9,10,11,12)
)
group by "成約日"
order by "成約日"