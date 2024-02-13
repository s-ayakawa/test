select
  t1.event_date_local as "date",
  t1.default_channel_group_ga4_nondirect as "default_channel_group_ga4_nondirect",
  count(tealium_unique_session_id)
from
  prod_kintojpn_view.view_wlog_tealium_viewevents_basic as t1 /* TealiumWebログ(本番ページビューイベントのみ) */
where
  t1.event_date_local = Date '2024-01-13'
group by
  t1.event_date_local,
  t1.default_channel_group_ga4_nondirect
order by
  t1.event_date_local