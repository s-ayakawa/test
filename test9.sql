select
    col_001
    sum(t2."当初計画") as "当初計画",
    sum(t2."見直し計画") as "見直し計画"
from
(
    select
        col_001,
        (
            case
            when col_002 = '当初計画' then col_003
            end
        ) as "当初計画",
        (
            case
            when col_002 = '見直し計画' then col_003
            end
        ) as "見直し計画"
    from
        prod_nicola_user.V_0002KG74SZXDK12CXCG2NK1KG1
) as t2       
group by
    col_001
order by
    col_001