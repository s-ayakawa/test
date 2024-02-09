with toyota as (
    select
        "成約日",
        count("契約ID") as t
    from
        (
            select
                t1.contract_id as "契約ID",
                date_format(t1.contract_entry_datetime, '%Y/%m/%d') as "成約日",
                t3.manufacturer_name as "メーカー名"
            from
                prod_kintojpn_view.view_rdb_contract as t1 /* 契約 */
                inner join prod_kintojpn_view.view_rdb_based_car as t2 on /* 車基本情報 */
                    t2.contract_id = t1.contract_id
                inner join prod_kintojpn_view.view_rdb_m_manufacturer as t3 on /* メーカーマスタ */
                    t3.manufacturer_id = t2.manufacturer_id
            where
                t3.manufacturer_name = 'TOYOTA'
                and t1.contract_entry_datetime >= date_add('month', -1, current_date)
                and t1.delete_flag = 0
                and t1.contract_status_sv in ('009', '010', '011', '101', '902', '903')
                and t1.contract_plan_detail_sv not in (9,10,11,12)
        )
    group by "成約日"
), lexus as (
    select
        "成約日",
        count("契約ID") as l
    from
        (
            select
                t1.contract_id as "契約ID",
                date_format(t1.contract_entry_datetime, '%Y/%m/%d') as "成約日",
                t3.manufacturer_name as "メーカー名"
            from
                prod_kintojpn_view.view_rdb_contract as t1 /* 契約 */
                inner join prod_kintojpn_view.view_rdb_based_car as t2 on /* 車基本情報 */
                    t2.contract_id = t1.contract_id
                inner join prod_kintojpn_view.view_rdb_m_manufacturer as t3 on /* メーカーマスタ */
                    t3.manufacturer_id = t2.manufacturer_id
            where
                t3.manufacturer_name = 'TOYOTA'
                and t1.contract_entry_datetime >= date_add('month', -1, current_date)
                and t1.delete_flag = 0
                and t1.contract_status_sv in ('009', '010', '011', '101', '902', '903')
                and t1.transaction_class_sv IN(1,2,3)
        )
    group by "成約日"
)
select
    toyota."成約日",
    t as contract_plan_detail_sv,
    l as transaction_class_sv
from
    toyota full outer join lexus on toyota."成約日" = lexus."成約日"
order by "成約日"