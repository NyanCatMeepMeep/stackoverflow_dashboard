with total_by_day as
(
  select
  date(creation_date) _date,
  count(id) num_posts
  from `bigquery-public-data.stackoverflow.posts_questions`
  where date(creation_date) >= DATE_SUB(CURRENT_DATE(), INTERVAL 1095 DAY)
  group by
  date(creation_date)
)
select
extract(month from _date) _month,
sum(case when extract(year from _date) = 2019 then num_posts else 0 end) as _2019_posts,
sum(case when extract(year from _date) = 2020 then num_posts else 0 end) as _2020_posts
from total_by_day
group by
extract(month from _date);