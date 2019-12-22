select area_id,
       round(avg(
                     case
                         when compensation_from is not null and compensation_gross is false then
                             compensation_from
                         when compensation_from is not null and compensation_gross is true then
                             compensation_from * 0.87 end), 2) as fromAvg,
       round(avg(
                     case
                         when compensation_to is not null and compensation_gross is false then
                             compensation_to
                         when compensation_to is not null and compensation_gross is true then
                             compensation_to * 0.87 end), 2)   as toAvg,

       round(avg(
                     case
                         when compensation_to is not null and compensation_from is not null and compensation_gross is false then
                             compensation_to-compensation_from
                         when compensation_to is not null and compensation_from is not null and compensation_gross is true then
                             (compensation_to - compensation_from) * 0.87 end), 2)   as medAvg
from vacancy_body
group by area_id
order by area_id




