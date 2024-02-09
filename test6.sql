select
  'KINTO' as category,
  t4.manufacturer_name,
  (
    case
    when t3.car_model_name = 'クラウン' and t5.grade_name like 'CROSSOVER%' then 'クラウンクロスオーバー'
    when t3.car_model_name = 'クラウン' and t5.grade_name like 'SPORT%' then 'クラウンスポーツ'
    when t3.car_model_name = 'クラウン' and t5.grade_name like 'Z %' then 'クラウンセダン'
    else t3.car_model_name end
  ) as car_name,
  date_parse(date_format(t1.contract_entry_datetime,'%Y-%m-%d'), '%Y-%m-%d') as order_date,
  concat(substr(cast(year(t1.contract_entry_datetime)*10000+month(t1.contract_entry_datetime)*100+day(t1.contract_entry_datetime) as varchar),1,4),'年') as order_year,
  concat(substr(cast(year(t1.contract_entry_datetime)*10000+month(t1.contract_entry_datetime)*100+day(t1.contract_entry_datetime) as varchar),5,2),'月') as order_month,
  concat(substr(cast(year(t1.contract_entry_datetime)*10000+month(t1.contract_entry_datetime)*100+day(t1.contract_entry_datetime) as varchar),7,2),'日') as order_day,
  year(t1.contract_entry_datetime)*100+month(t1.contract_entry_datetime) as order_yyyymm,
  (
    case
    when t1.commercial_flow_sv = 1 then 'WEB'
    when t1.commercial_flow_sv = 2 then '店頭'
    end
  ) as commercial_flow,
  (
    case
    when t6.contract_sv = 1 then '個人'
    when t6.contract_sv = 2 then '法人'
    end
  ) as contact_sv,  
  count(*) as order_quantity
from
  prod_kintojpn_view.view_rdb_contract t1
  inner join prod_kintojpn_view.view_rdb_based_car t2
  on t1.contract_id = t2.contract_id
  and t2.delete_flag = 0
    left outer join prod_kintojpn_view.view_rdb_m_car_model t3
    on t2.car_model_id = t3.car_model_id
    and t3.delete_flag = 0
      left outer join prod_kintojpn_view.view_rdb_m_manufacturer t4
      on t2.manufacturer_id = t4.manufacturer_id
      and t4.delete_flag = 0
        left outer join prod_kintojpn_view.view_rdb_m_grade t5
        on t2.grade_id = t5.grade_id
        and t5.delete_flag = 0
          left outer join prod_kintojpn_view.view_rdb_member t6
          on t1.member_id = t6.member_id
          and t6.delete_flag = 0
where
  t1.contract_entry_datetime >= date_add('month', -14, current_date)
  and t1.delete_flag = 0
  and t1.contract_status_sv in ('009', '010', '011', '101', '902', '903')
  and t1.contract_plan_detail_sv not in (9,10,11,12)
group by
  1,2,3,4,5,6,7,8,9,10
order by
  1,2,3,4,5,6,7,8,9,10