select
  t1.event_date_local as "date",
  t1.default_channel_group_ga4_nondirect as "default_channel_group_ga4_nondirect",
  count(tealium_unique_session_id)
from
  prod_kintojpn_view.view_wlog_tealium_allevents_basic as t1 /* TealiumWebログ(本番全ログ) */
where
  t1.event_date_local >= date'2024-02-01'
  and t1.pageurl_domain = 'kinto-jp.com'
  and t1.udo_tealium_event = 'view'
group by
  t1.event_date_local,
  t1.default_channel_group_ga4_nondirect
order by
  t1.event_date_local