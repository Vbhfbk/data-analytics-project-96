with ya as (
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
),

count_visit as (
    select
        source as utm_source,
        medium as utm_medium,
        campaign as utm_campaign,
        to_char(visit_date, 'YYYY-MM-DD') as campaign_date,
        count(visitor_id) as visitors_count
    from sessions
    group by to_char(visit_date, 'YYYY-MM-DD'), source, medium, campaign
),

leads_by_marks as (
    select distinct on (l.lead_id)
        s.source as utm_source,
        s.medium as utm_medium,
        s.campaign as utm_campaign,
        l.lead_id,
        l.closing_reason,
        l.amount,
        to_char(s.visit_date, 'YYYY-MM-DD') as campaign_date
    from leads as l
    left join sessions as s
        on l.visitor_id = s.visitor_id
    where s.visitor_id is not null
    order by l.lead_id
)

select
    cv.campaign_date as visit_date,
    cv.utm_source,
    cv.utm_medium,
    cv.utm_campaign,
    cv.visitors_count,
    coalesce(y.summ, 0) + coalesce(v.summ, 0) as total_cost,
    count(lm.lead_id) as leads_count,
    sum(
        case when lm.closing_reason = 'Успешная продажа' then 1 else 0 end
    ) as purchases_count,
    sum(lm.amount) as revenue
from count_visit as cv
left join ya as y
    on
        cv.campaign_date = y.campaign_date
        and cv.utm_source = y.utm_source
        and cv.utm_medium = y.utm_medium
        and cv.utm_campaign = y.utm_campaign
left join vk as v
    on
        cv.campaign_date = v.campaign_date
        and cv.utm_source = v.utm_source
        and cv.utm_medium = v.utm_medium
        and cv.utm_campaign = v.utm_campaign
left join leads_by_marks as lm
    on
        cv.campaign_date = lm.campaign_date
        and cv.utm_source = lm.utm_source
        and cv.utm_medium = lm.utm_medium
        and cv.utm_campaign = lm.utm_campaign
group by
    cv.campaign_date,
    cv.utm_source,
    cv.utm_medium,
    cv.utm_campaign,
    cv.visitors_count,
    coalesce(y.summ, 0) + coalesce(v.summ, 0)
order by
    sum(lm.amount) desc nulls last,
    cv.campaign_date asc,
    cv.visitors_count desc,
    cv.utm_source asc,
    cv.utm_medium asc,
    cv.utm_campaign asc;
