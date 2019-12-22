
select name from vacancy_body left join
(select vacancy.vacancy_id,vacancy.vacancy_body_id,
       case
           when (r.reply_time <= vacancy.creation_time + '5 day'::interval)
               then count(r.cv_id)
           else 0 end as repliesCount
from vacancy
         left outer join replies r on vacancy.vacancy_id = r.vacancy_id
group by vacancy.vacancy_id, r.reply_time) as repliesCounts on repliesCounts.vacancy_body_id=vacancy_body.vacancy_body_id
where repliesCounts.repliesCount<5
order by name asc;


