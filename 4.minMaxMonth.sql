select cvmax.CVmonth, vacMax.vacMonth
from (select extract(month from creation_time) as CVmonth, count(user_id) as cvs
      from users_cv
      group by CVmonth
      order by cvs desc
      limit 1) as cvmax,
        (select extract(month from creation_time) as vacMonth, count(vacancy_id) as vacancies
      from vacancy
      group by vacMonth
      order by vacancies desc
      limit 1) as vacMax;



-- select vacMonth
-- from (select extract(month from creation_time) as vacMonth, count(vacancy_id) as vacancies
--       from vacancy
--       group by vacMonth
--       order by vacancies desc
--       limit 1) as vacMax;


-- select vacMax.vacMonth, vacMax.vacancies, cvmax.cvs
-- from (select extract(month from creation_time) as CVmonth, count(user_id) as cvs
--       from users_cv
--       group by CVmonth
--       order by cvs desc) as cvmax
--          inner join (select extract(month from creation_time) as vacMonth, count(vacancy_id) as vacancies
--                       from vacancy
--                       group by vacMonth
--                       order by vacancies)as vacMax on cvmax.CVmonth = vacMax.vacMonth
