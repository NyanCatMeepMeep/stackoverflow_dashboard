with total_by_day as
(
  select
  date(creation_date) _date,
  count(id) num_users
  from `bigquery-public-data.stackoverflow.users`
  where date(creation_date) >= DATE_SUB(CURRENT_DATE(), INTERVAL 91 DAY)
  group by
  date(creation_date)
),
last_30_days as
(
select
1 as core,
sum(num_users) as total_users_30
from total_by_day
where _date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
),
last_60_days as
(
select
1 as core,
sum(num_users) as total_users_60
from total_by_day
where _date >= DATE_SUB(CURRENT_DATE(), INTERVAL 60 DAY)
),
last_90_days as
(
select
1 as core,
sum(num_users) as total_users_90
from total_by_day
where _date >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY)
)
select
case when c.total_users_30 is null then 0 else c.total_users_30 end as total_users_30,
case when b.total_users_60 is null then 0 else b.total_users_60 end as total_users_60,
case when a.total_users_90 is null then 0 else a.total_users_90 end as total_users_90
from last_90_days a
left join last_60_days b
on a.core = b.core
left join last_30_days c
on a.core = c.core
