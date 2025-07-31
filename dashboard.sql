--считаем долю закрытых лидов от срока
with t as (
    select distinct on (s.visitor_id)
        s.visitor_id,
        s.visit_date,
        l.created_at,
        l.lead_id
    from sessions as s
    left join leads as l
        on
            s.visitor_id = l.visitor_id
            and s.visit_date <= l.created_at
    where s.medium != 'organic'
    order by s.visitor_id asc, s.visit_date desc
)

select
    (date(t.created_at) - date(t.visit_date)) as closing_duration,
    ntile(100)
        over (
        order by date(t.created_at) - date(t.visit_date))
	as percentil_of_duration
from t
where t.lead_id is not null;

--cчитаем данные для воронок продаж
with t as (
    select distinct on (s.visitor_id)
        s.visitor_id,
        s.visit_date,
        s.source as utm_source,
        l.lead_id,
        l.created_at,
        l.closing_reason
    from sessions as s
    left join leads as l
        on
            s.visitor_id = l.visitor_id
            and s.visit_date <= l.created_at
    where s.medium != 'organic'
    order by s.visitor_id asc, s.visit_date desc
),

result as (
    select
        t.utm_source,
        count(distinct t.visitor_id) as visitors_count,
        count(distinct t.lead_id) as leads_count,
        sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end)
		as purchases_count
    from t
    group by t.utm_source
)

select
    'Посетители' as lev,
    (
        select count(s.visitor_id)
        from sessions as s
    ) as total,
    (
        select sum(r.visitors_count)
        from result as r
        where r.utm_source = 'yandex'
    ) as yandex,
    (
        select sum(r.visitors_count)
        from result as r
        where r.utm_source = 'vk'
    ) as vk
from result
union
select
    'Лиды' as lev,
    (
        select count(distinct l.lead_id)
        from leads as l
    ) as total,
    (
        select sum(r.leads_count)
        from result as r
        where r.utm_source = 'yandex'
    ) as yandex,
    (
        select sum(r.leads_count)
        from result as r
        where r.utm_source = 'vk'
    ) as vk
from result
union
select
    'Продажи' as lev,
    (
        select
            sum(
                case
                    when l.closing_reason = 'Успешная продажа' then 1 else 0
                end
            )
        from leads as l
    ) as total,
    (
        select sum(r.purchases_count)
        from result as r
        where r.utm_source = 'yandex'
    ) as yandex,
    (
        select sum(r.purchases_count)
        from result as r
        where r.utm_source = 'vk'
    ) as vk
from result;

--cчитаем основные метрики и конверсии
with t as (
    select distinct on (s.visitor_id)
        s.visitor_id,
        s.visit_date,
        s.source as utm_source,
        s.medium as utm_medium,
        s.campaign as utm_campaign,
        l.lead_id,
        l.created_at,
        l.amount,
        l.closing_reason,
        l.status_id
    from sessions as s
    left join leads as l
        on
            s.visitor_id = l.visitor_id
            and s.visit_date <= l.created_at
    where s.medium != 'organic'
    order by s.visitor_id asc, s.visit_date desc
),

ya as (
    select
        y.utm_source,
        y.utm_medium,
        y.utm_campaign,
        to_char(y.campaign_date, 'YYYY-MM-DD') as campaign_date,
        sum(y.daily_spent) as summ
    from ya_ads as y
    group by
        to_char(y.campaign_date, 'YYYY-MM-DD'),
        y.utm_source,
        y.utm_medium,
        y.utm_campaign
),

vk as (
    select
        v.utm_source,
        v.utm_medium,
        v.utm_campaign,
        to_char(v.campaign_date, 'YYYY-MM-DD') as campaign_date,
        sum(v.daily_spent) as summ
    from vk_ads as v
    group by
        to_char(v.campaign_date, 'YYYY-MM-DD'),
        v.utm_source,
        v.utm_medium,
        v.utm_campaign
),

result as (
    select
        t.utm_source,
        t.utm_medium,
        t.utm_campaign,
        count(distinct t.visitor_id) as visitors_count,
        coalesce(y.summ, v.summ) as costed,
        count(distinct t.lead_id) as leads_count,
        sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end)
        as purchases_count,
        sum(t.amount) as revenue
    from t
    left join ya as y
        on
            to_char(t.visit_date, 'YYYY-MM-DD') = y.campaign_date
            and t.utm_source = y.utm_source
            and t.utm_medium = y.utm_medium
            and t.utm_campaign = y.utm_campaign
    left join vk as v
        on
            to_char(t.visit_date, 'YYYY-MM-DD') = v.campaign_date
            and t.utm_source = v.utm_source
            and t.utm_medium = v.utm_medium
            and t.utm_campaign = v.utm_campaign
    group by
        t.utm_source,
        t.utm_medium,
        t.utm_campaign,
        coalesce(y.summ, v.summ)
)

select
    r.utm_source,
    round(
        cast(sum(r.leads_count) as decimal)
        * 100
        / cast(sum(r.visitors_count) as decimal),
        2
    ) as users_to_leads_percent,
    case
        when sum(r.purchases_count) = 0 then 0
        else
            round(
                cast(sum(r.purchases_count) as decimal)
                * 100
                / cast(sum(r.leads_count) as decimal),
                2
            )
    end as leads_to_purchases_percent,
    case
        when sum(r.purchases_count) = 0 then 0
        else round((sum(r.revenue) - sum(r.costed)) * 100 / sum(r.costed), 2)
    end as roi,
    case
        when sum(r.visitors_count) = 0 then 0 else
            round(sum(r.costed) / sum(r.visitors_count), 2)
    end as cpu,
    case
        when sum(r.leads_count) = 0 then 0 else
            round(sum(r.costed) / sum(r.leads_count), 2)
    end as cpl,
    case
        when sum(r.purchases_count) = 0 then 0 else
            round(sum(r.costed) / sum(r.purchases_count), 2)
    end as cppu
from result as r
group by r.utm_source
order by sum(r.visitors_count) desc
limit 2;
