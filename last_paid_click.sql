with paid_click_leads as (
    select distinct on (l.visitor_id)
        l.visitor_id,
        l.lead_id,
        l.created_at,
        l.amount,
        l.closing_reason,
        l.status_id,
        s.visit_date
    from sessions as s
    left join leads as l
        on s.visitor_id = l.visitor_id and s.visit_date <= l.created_at
    where
        l.lead_id is not null and s.medium != 'organic'
    order by l.visitor_id asc, s.visit_date desc
),

sessions_with_paid_click_leads as (
    select distinct on (ss.visitor_id)
        ss.visitor_id,
        ss.visit_date,
        ss.source as utm_source,
        ss.medium as utm_medium,
        ss.campaign as utm_campaign,
        p.lead_id,
        p.created_at,
        p.amount,
        p.closing_reason,
        p.status_id
    from sessions as ss
    left join paid_click_leads as p
        on ss.visitor_id = p.visitor_id and ss.visit_date = p.visit_date
    order by ss.visitor_id asc, p.created_at desc nulls last
)

select *
from sessions_with_paid_click_leads
order by
    amount desc nulls last,
    visit_date asc,
    utm_source asc,
    utm_medium asc,
    utm_campaign asc;