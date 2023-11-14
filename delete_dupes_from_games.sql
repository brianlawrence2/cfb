with cte as (
    select
        id,
        row_number() over(partition by id order by id) rownum
    from games
)

delete
--select *
from games
where exists (
    select 1
    from cte
    where games.id = cte.id
    and rownum > 1
)
