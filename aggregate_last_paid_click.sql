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
        utm_source,
        utm_medium,
        utm_campaign,
        to_char(campaign_date, 'YYYY-MM-DD') as campaign_date,
        sum(daily_spent) as summ
    from ya_ads
    group by
        to_char(campaign_date, 'YYYY-MM-DD'),
        utm_source,
        utm_medium,
        utm_campaign
),

vk as (
    select
        utm_source,
        utm_medium,
        utm_campaign,
        to_char(campaign_date, 'YYYY-MM-DD') as campaign_date,
        sum(daily_spent) as summ
    from vk_ads
    group by
        to_char(campaign_date, 'YYYY-MM-DD'),
        utm_source,
        utm_medium,
        utm_campaign
)

select
	to_char(t.visit_date, 'YYYY-MM-DD') as visit_date,    
	t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    count(distinct t.visitor_id) as visitors_count,
    coalesce(y.summ, v.summ, 0) as total_cost,
    count(distinct t.lead_id) as leads_count,
    sum(
        case when t.closing_reason = 'Успешная продажа' then 1 else 0 end
    ) as purchases_count,
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
    to_char(t.visit_date, 'YYYY-MM-DD'),
    t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    --count(distinct t.visitor_id),
    coalesce(y.summ, v.summ, 0)
order by
    sum(t.amount) desc nulls last,
    to_char(t.visit_date, 'YYYY-MM-DD') asc,
    count(distinct t.visitor_id) desc,
    t.utm_source asc,
    t.utm_medium asc,
    t.utm_campaign asc;