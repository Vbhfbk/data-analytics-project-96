--1.Считаем визиты и уникальных посетителей с выходными
select
	to_char(visit_date, 'YYYY-MM-DD') as visit_date,
	case
		when to_char(visit_date, 'ID') = '1' then 'пн'
		when to_char(visit_date, 'ID') = '2' then 'вт'
		when to_char(visit_date, 'ID') = '3' then 'ср'
		when to_char(visit_date, 'ID') = '4' then 'чт'
		when to_char(visit_date, 'ID') = '5' then 'пт'
		when to_char(visit_date, 'ID') = '6' then 'сб'
		else 'вс' end,
	to_char(visit_date, 'W') as number_of_week,
	case when to_char(visit_date, 'ID') in ('6', '7') or to_char(visit_date, 'YYYY-MM-DD') = '2023-06-12' then 'выходной' end as holyday_check,
	count(visitor_id) as visits,
	count(distinct visitor_id) as unique_visitors,
	round(cast(count(visitor_id) as DECIMAL) / cast(count(distinct visitor_id) as DECIMAL), 2) as avg_visits
from sessions
group by
    	to_char(visit_date, 'YYYY-MM-DD'),
    	case
			when to_char(visit_date, 'ID') = '1' then 'пн'
			when to_char(visit_date, 'ID') = '2' then 'вт'
			when to_char(visit_date, 'ID') = '3' then 'ср'
			when to_char(visit_date, 'ID') = '4' then 'чт'
			when to_char(visit_date, 'ID') = '5' then 'пт'
			when to_char(visit_date, 'ID') = '6' then 'сб'
			else 'вс' end,
    	to_char(visit_date, 'W'),
    	case when to_char(visit_date, 'ID') in ('6', '7') or to_char(visit_date, 'YYYY-MM-DD') = '2023-06-12' then 'выходной' end;

--2. Посещаемость сайта в течение суток в разрезе дней недели
select
	to_char(visit_date, 'YYYY-MM-DD') as visit_date,
	to_char(visit_date, 'HH24') as hour,
	to_char(visit_date, 'ID'), 
	case
		when to_char(visit_date, 'ID') = '1' then 'понедельник'
		when to_char(visit_date, 'ID') = '2' then 'вторник'
		when to_char(visit_date, 'ID') = '3' then 'среда'
		when to_char(visit_date, 'ID') = '4' then 'четверг'
		when to_char(visit_date, 'ID') = '5' then 'пятница'
		when to_char(visit_date, 'ID') = '6' then 'суббота'
		else 'воскресенье' end as day_of_week,
	to_char(visit_date, 'W') as number_of_week,	
	count(visitor_id) as visits,
	count(distinct visitor_id) as unique_visitors,
	round(cast(count(visitor_id) as decimal) / cast(count(distinct visitor_id) as decimal), 2) as avg_visits
from sessions
group by
    	to_char(visit_date, 'YYYY-MM-DD'),
    	case
			when to_char(visit_date, 'ID') = '1' then 'понедельник'
			when to_char(visit_date, 'ID') = '2' then 'вторник'
			when to_char(visit_date, 'ID') = '3' then 'среда'
			when to_char(visit_date, 'ID') = '4' then 'четверг'
			when to_char(visit_date, 'ID') = '5' then 'пятница'
			when to_char(visit_date, 'ID') = '6' then 'суббота'
			else 'воскресенье' end,
    	to_char(visit_date, 'HH24'),
    	to_char(visit_date, 'ID'),
    	to_char(visit_date, 'W');

--3. Посещаемость сайта в течение суток
select
	to_char(visit_date, 'YYYY-MM-DD') as visit_date,
	to_char(visit_date, 'HH24') as hour,
	to_char(visit_date, 'ID') as day_of_week,
	to_char(visit_date, 'W') as number_of_week,	
	count(visitor_id) as visits,
	count(distinct visitor_id) as unique_visitors,
	round(cast(count(visitor_id) as decimal) / cast(count(distinct visitor_id) as decimal), 2) as avg_visits
from sessions
group by
    	to_char(visit_date, 'YYYY-MM-DD'),
    	to_char(visit_date, 'HH24'),
    	to_char(visit_date, 'ID'),
    	to_char(visit_date, 'W');

--4. Посещаемость сайта по дням недели
select
	to_char(visit_date, 'YYYY-MM-DD') as visit_date,
	to_char(visit_date, 'HH24') as hour,
	to_char(visit_date, 'ID') as day_of_week,
	to_char(visit_date, 'W') as number_of_week,	
	count(visitor_id) as visits,
	count(distinct visitor_id) as unique_visitors,
	round(cast(count(visitor_id) as decimal) / cast(count(distinct visitor_id) as decimal), 2) as avg_visits
from sessions
group by
    	to_char(visit_date, 'YYYY-MM-DD'),
    	to_char(visit_date, 'HH24'),
    	to_char(visit_date, 'ID'),
    	to_char(visit_date, 'W');

--5. Посещаемость сайта по неделям в течение месяца
select
	to_char(visit_date, 'YYYY-MM-DD') as visit_date,
	to_char(visit_date, 'HH24') as hour,
	to_char(visit_date, 'ID'), 
	case
		when to_char(visit_date, 'ID') = '1' then 'понедельник'
		when to_char(visit_date, 'ID') = '2' then 'вторник'
		when to_char(visit_date, 'ID') = '3' then 'среда'
		when to_char(visit_date, 'ID') = '4' then 'четверг'
		when to_char(visit_date, 'ID') = '5' then 'пятница'
		when to_char(visit_date, 'ID') = '6' then 'суббота'
		else 'воскресенье' end as day_of_week,
		case
		  when visit_date < '2023-06-05'  then '1'
		  when visit_date < '2023-06-12'  then '2'
		  when visit_date < '2023-06-19'  then '3'
		  when visit_date < '2023-06-26'  then '4'
		  else '5' end as number_of_week,		
	count(visitor_id) as visits,
	count(distinct visitor_id) as unique_visitors,
	round(cast(count(visitor_id) as decimal) / cast(count(distinct visitor_id) as decimal), 2) as avg_visits
from sessions
group by
    	to_char(visit_date, 'YYYY-MM-DD'),
    	case
			when to_char(visit_date, 'ID') = '1' then 'понедельник'
			when to_char(visit_date, 'ID') = '2' then 'вторник'
			when to_char(visit_date, 'ID') = '3' then 'среда'
			when to_char(visit_date, 'ID') = '4' then 'четверг'
			when to_char(visit_date, 'ID') = '5' then 'пятница'
			when to_char(visit_date, 'ID') = '6' then 'суббота'
			else 'воскресенье' end,
    	to_char(visit_date, 'HH24'),
    	to_char(visit_date, 'ID'),
    	case
	      when visit_date < '2023-06-05'  then '1'
		    when visit_date < '2023-06-12'  then '2'
		    when visit_date < '2023-06-19'  then '3'
		    when visit_date < '2023-06-26'  then '4'
		  else '5' end;

--6. Топ-10 каналов привлечения по количеству посетителей сайта
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
),

result as (
select
		to_char(t.visit_date, 'YYYY-MM-DD') as visit_date,
		to_char(t.visit_date, 'ID') as day_of_week,
		to_char(t.visit_date, 'W') as number_of_week,
		count(distinct t.visitor_id) as visitors_count,
		t.utm_source,
    	t.utm_medium,
    	t.utm_campaign,
    	coalesce(y.summ, v.summ) as total_cost,
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
    	to_char(t.visit_date, 'ID'),
    	to_char(t.visit_date, 'W'),
    	t.utm_source,
    	t.utm_medium,
    	t.utm_campaign,
    	coalesce(y.summ, v.summ)
),

total_visits as (
	select
		count(visitor_id) as total_visits,
		count(distinct visitor_id) as total_unique_visitors
	from sessions
),

total_leads as (
	select
		count(distinct lead_id) as total_leads,
		sum(case when closing_reason = 'Успешная продажа' then 1 else 0 end) as total_purchases_count,
		sum(amount) as total_amount
	from leads
),

total_cost as (
	select sum(total_cost) as total_cost
	from result
)

select
	source,
	count(visitor_id) as visits, 
	count(distinct visitor_id) as unique_visitors,
	round(cast(count(visitor_id) as decimal) / cast(count(distinct visitor_id) as decimal), 2) as avg_visits,
	count(distinct lead_id) as leads,
	round(cast(count(visitor_id) as decimal) * 100 / cast(min(tv.total_visits) as decimal), 2) as visits_percent,
	round(cast(count(distinct visitor_id) as decimal) * 100 / cast(min(tv.total_unique_visitors) as decimal), 2) as unique_visitors_percent,
	round(cast(count(distinct lead_id) as decimal) * 100 / cast(max(tl.total_leads) as decimal), 2) as leads_percent
from sessions
left join leads
	using (visitor_id)
cross join total_visits as tv
cross join total_leads as tl
group by source
order by count(visitor_id) desc
limit 10;

--7. Топ-4 каналов привлечения посетителей сайта в течение месяца
select
	to_char(visit_date, 'YYYY-MM-DD') as visit_date,
	to_char(visit_date, 'HH24') as hour,
	to_char(visit_date, 'ID') as day_of_week,
	to_char(visit_date, 'W') as number_of_week,
	source as utm_source,
  	count(visitor_id) as visits,
	count(distinct visitor_id) as unique_visitors,
	round(cast(count(visitor_id) as DECIMAL) / cast(count(distinct visitor_id) as DECIMAL), 2) as avg_visits
from sessions
group by
    	to_char(visit_date, 'YYYY-MM-DD'),
    	to_char(visit_date, 'HH24'),
    	to_char(visit_date, 'ID'),
    	to_char(visit_date, 'W'),
    	source;

--8. Топ-4 каналов привлечения посетителей сайта в течение недели
select
	to_char(visit_date, 'YYYY-MM-DD') as visit_date,
	to_char(visit_date, 'HH24') as hour,
	to_char(visit_date, 'ID') as day_of_week,
	to_char(visit_date, 'W') as number_of_week,
	source as utm_source,
	count(visitor_id) as visits,
	count(distinct visitor_id) as unique_visitors,
	round(cast(count(visitor_id) as DECIMAL) / cast(count(distinct visitor_id) as DECIMAL), 2) as avg_visits
from sessions
group by
    	to_char(visit_date, 'YYYY-MM-DD'),
    	to_char(visit_date, 'HH24'),
    	to_char(visit_date, 'ID'),
    	to_char(visit_date, 'W'),
    	source;

--9. Топ-4 каналов привлечения по неделям в течение месяца
select
	to_char(visit_date, 'YYYY-MM-DD') as visit_date,
	to_char(visit_date, 'HH24') as hour,
	to_char(visit_date, 'ID') as day_of_week,
		case
		when visit_date < '2023-06-05'  then '1'
		when visit_date < '2023-06-12'  then '2'
		when visit_date < '2023-06-19'  then '3'
		when visit_date < '2023-06-26'  then '4'
		else '5' end as number_of_week,
	source as utm_source,
	count(visitor_id) as visits,
	count(distinct visitor_id) as unique_visitors,
	case when to_char(visit_date, 'ID') in ('6', '7') or to_char(visit_date, 'YYYY-MM-DD') = '2023-06-12' then 'выходной' end as holyday_check
from sessions
group by
    	to_char(visit_date, 'YYYY-MM-DD'),
    	to_char(visit_date, 'HH24'),
    	to_char(visit_date, 'ID'),
    		case
		when visit_date < '2023-06-05'  then '1'
		when visit_date < '2023-06-12'  then '2'
		when visit_date < '2023-06-19'  then '3'
		when visit_date < '2023-06-26'  then '4'
		else '5' end,
    	case when to_char(visit_date, 'ID') in ('6', '7') or to_char(visit_date, 'YYYY-MM-DD') = '2023-06-12' then 'выходной' end,
    	source;

--10. Топ-10 каналов по лидогенерации
select
	source,
	count(visitor_id) as visits, 
	count(distinct visitor_id) as unique_visitors,
	round(cast(count(visitor_id) as decimal) / cast(count(distinct visitor_id) as decimal), 2) as avg_visits,
	count(distinct lead_id) as leads
from sessions
left join leads
	using (visitor_id)
group by source
order by count(visitor_id) desc
limit 10;

--11. Каналы лидогенерации (по модели last paid click)
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
	to_char(t.created_at, 'YYYY-MM-DD') as visit_date,
	t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    count(distinct t.visitor_id) as visitors_count,
   	coalesce(y.summ, v.summ) as total_cost,
	count(distinct t.lead_id) as leads_count,
	sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end) as purchases_count,
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
where coalesce(y.summ, v.summ) is not null
group by
    to_char(t.created_at, 'YYYY-MM-DD'),
    t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    coalesce(y.summ, v.summ)
order by
    sum(t.amount) desc nulls last,
    to_char(t.created_at, 'YYYY-MM-DD') asc,
    count(distinct t.visitor_id) desc,
    t.utm_source asc,
    t.utm_medium asc,
    t.utm_campaign asc;

--12. Работа каналов лидогенерации в течение месяца (по модели last paid click)
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
	to_char(t.created_at, 'YYYY-MM-DD') as visit_date,
	case
			when to_char(visit_date, 'ID') = '1' then 'понедельник'
			when to_char(visit_date, 'ID') = '2' then 'вторник'
			when to_char(visit_date, 'ID') = '3' then 'среда'
			when to_char(visit_date, 'ID') = '4' then 'четверг'
			when to_char(visit_date, 'ID') = '5' then 'пятница'
			when to_char(visit_date, 'ID') = '6' then 'суббота'
			else 'воскресенье' end,
	case when to_char(t.created_at, 'ID') in ('6', '7') or to_char(t.created_at, 'YYYY-MM-DD') = '2023-06-12' then 'выходной' end as holyday_check,
	t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    count(distinct t.visitor_id) as visitors_count,
   	coalesce(y.summ, v.summ) as total_cost,
	count(distinct t.lead_id) as leads_count,
	sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end) as purchases_count,
	sum(t.amount) as revenue
from t
left join ya as y
    on
        to_char(t.created_at, 'YYYY-MM-DD') = y.campaign_date
        and t.utm_source = y.utm_source
        and t.utm_medium = y.utm_medium
        and t.utm_campaign = y.utm_campaign
left join vk as v
    on
        to_char(t.created_at, 'YYYY-MM-DD') = v.campaign_date
        and t.utm_source = v.utm_source
        and t.utm_medium = v.utm_medium
        and t.utm_campaign = v.utm_campaign
where coalesce(y.summ, v.summ) is not null
group by
    to_char(t.created_at, 'YYYY-MM-DD'),
    case
			when to_char(visit_date, 'ID') = '1' then 'понедельник'
			when to_char(visit_date, 'ID') = '2' then 'вторник'
			when to_char(visit_date, 'ID') = '3' then 'среда'
			when to_char(visit_date, 'ID') = '4' then 'четверг'
			when to_char(visit_date, 'ID') = '5' then 'пятница'
			when to_char(visit_date, 'ID') = '6' then 'суббота'
			else 'воскресенье' end,
		case when to_char(t.created_at, 'ID') in ('6', '7') or to_char(t.created_at, 'YYYY-MM-DD') = '2023-06-12' then 'выходной' end,
    t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    coalesce(y.summ, v.summ)
order by
    sum(t.amount) desc nulls last,
    to_char(t.created_at, 'YYYY-MM-DD') asc,
    count(distinct t.visitor_id) desc,
    t.utm_source asc,
    t.utm_medium asc,
    t.utm_campaign asc;

--14. Работа каналов лидогенерации в течение недели (по модели last paid click)
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
	to_char(t.created_at, 'YYYY-MM-DD') as visit_date,
	to_char(t.created_at, 'ID') as day_of_week_number,
	case
			when to_char(t.created_at, 'ID') = '1' then 'понедельник'
			when to_char(t.created_at, 'ID') = '2' then 'вторник'
			when to_char(t.created_at, 'ID') = '3' then 'среда'
			when to_char(t.created_at, 'ID') = '4' then 'четверг'
			when to_char(t.created_at, 'ID') = '5' then 'пятница'
			when to_char(t.created_at, 'ID') = '6' then 'суббота'
			else 'воскресенье' end  as day_of_week,
	case when to_char(t.created_at, 'ID') in ('6', '7') or to_char(t.created_at, 'YYYY-MM-DD') = '2023-06-12' then 'выходной' end as holyday_check,
	case
		  when t.created_at < '2023-06-05'  then '1'
		  when t.created_at < '2023-06-12'  then '2'
		  when t.created_at < '2023-06-19'  then '3'
		  when t.created_at < '2023-06-26'  then '4'
		  else '5' end as number_of_week,
	  t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    count(distinct t.visitor_id) as visitors_count,
   	coalesce(y.summ, v.summ) as total_cost,
	count(distinct t.lead_id) as leads_count,
	sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end) as purchases_count,
	sum(t.amount) as revenue
from t
left join ya as y
    on
        to_char(t.created_at, 'YYYY-MM-DD') = y.campaign_date
        and t.utm_source = y.utm_source
        and t.utm_medium = y.utm_medium
        and t.utm_campaign = y.utm_campaign
left join vk as v
    on
        to_char(t.created_at, 'YYYY-MM-DD') = v.campaign_date
        and t.utm_source = v.utm_source
        and t.utm_medium = v.utm_medium
        and t.utm_campaign = v.utm_campaign
where coalesce(y.summ, v.summ) is not null
group by
    to_char(t.created_at, 'YYYY-MM-DD'),
    to_char(t.created_at, 'ID'),
    case
			when to_char(t.created_at, 'ID') = '1' then 'понедельник'
			when to_char(t.created_at, 'ID') = '2' then 'вторник'
			when to_char(t.created_at, 'ID') = '3' then 'среда'
			when to_char(t.created_at, 'ID') = '4' then 'четверг'
			when to_char(t.created_at, 'ID') = '5' then 'пятница'
			when to_char(t.created_at, 'ID') = '6' then 'суббота'
			else 'воскресенье' end,
		case when to_char(t.created_at, 'ID') in ('6', '7') or to_char(t.created_at, 'YYYY-MM-DD') = '2023-06-12' then 'выходной' end,
		case
		  when t.created_at < '2023-06-05'  then '1'
		  when t.created_at < '2023-06-12'  then '2'
		  when t.created_at < '2023-06-19'  then '3'
		  when t.created_at < '2023-06-26'  then '4'
		  else '5' end,		
    t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    coalesce(y.summ, v.summ)
order by
    sum(t.amount) desc nulls last,
    to_char(t.created_at, 'YYYY-MM-DD') asc,
    count(distinct t.visitor_id) desc,
    t.utm_source asc,
    t.utm_medium asc,
    t.utm_campaign asc;

--15. Работа каналов лидогенерации по неделям в течение месяца (по модели last paid click)
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
	to_char(t.created_at, 'YYYY-MM-DD') as visit_date,
	to_char(t.created_at, 'ID') as day_of_week_number,
	case
			when to_char(t.created_at, 'ID') = '1' then 'понедельник'
			when to_char(t.created_at, 'ID') = '2' then 'вторник'
			when to_char(t.created_at, 'ID') = '3' then 'среда'
			when to_char(t.created_at, 'ID') = '4' then 'четверг'
			when to_char(t.created_at, 'ID') = '5' then 'пятница'
			when to_char(t.created_at, 'ID') = '6' then 'суббота'
			else 'воскресенье' end  as day_of_week,
	case when to_char(t.created_at, 'ID') in ('6', '7') or to_char(t.created_at, 'YYYY-MM-DD') = '2023-06-12' then 'выходной' end as holyday_check,
	case
		  when t.created_at < '2023-06-05'  then '1'
		  when t.created_at < '2023-06-12'  then '2'
		  when t.created_at < '2023-06-19'  then '3'
		  when t.created_at < '2023-06-26'  then '4'
		  else '5' end as number_of_week,
	  t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    count(distinct t.visitor_id) as visitors_count,
   	coalesce(y.summ, v.summ) as total_cost,
	count(distinct t.lead_id) as leads_count,
	sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end) as purchases_count,
	sum(t.amount) as revenue
from t
left join ya as y
    on
        to_char(t.created_at, 'YYYY-MM-DD') = y.campaign_date
        and t.utm_source = y.utm_source
        and t.utm_medium = y.utm_medium
        and t.utm_campaign = y.utm_campaign
left join vk as v
    on
        to_char(t.created_at, 'YYYY-MM-DD') = v.campaign_date
        and t.utm_source = v.utm_source
        and t.utm_medium = v.utm_medium
        and t.utm_campaign = v.utm_campaign
where coalesce(y.summ, v.summ) is not null
group by
    to_char(t.created_at, 'YYYY-MM-DD'),
    to_char(t.created_at, 'ID'),
    case
			when to_char(t.created_at, 'ID') = '1' then 'понедельник'
			when to_char(t.created_at, 'ID') = '2' then 'вторник'
			when to_char(t.created_at, 'ID') = '3' then 'среда'
			when to_char(t.created_at, 'ID') = '4' then 'четверг'
			when to_char(t.created_at, 'ID') = '5' then 'пятница'
			when to_char(t.created_at, 'ID') = '6' then 'суббота'
			else 'воскресенье' end,
		case when to_char(t.created_at, 'ID') in ('6', '7') or to_char(t.created_at, 'YYYY-MM-DD') = '2023-06-12' then 'выходной' end,
		case
		  when t.created_at < '2023-06-05'  then '1'
		  when t.created_at < '2023-06-12'  then '2'
		  when t.created_at < '2023-06-19'  then '3'
		  when t.created_at < '2023-06-26'  then '4'
		  else '5' end,		
    t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    coalesce(y.summ, v.summ)
order by
    sum(t.amount) desc nulls last,
    to_char(t.created_at, 'YYYY-MM-DD') asc,
    count(distinct t.visitor_id) desc,
    t.utm_source asc,
    t.utm_medium asc,
    t.utm_campaign asc;

--16. Строим воронку продаж
select
	'total_visits' as level,
	count(visitor_id) as count
from sessions
union all
select
	'total_leads' as level,
count(distinct lead_id) as count
	from leads
union all
select
	'total_purchases' as level,
	sum(case when closing_reason = 'Успешная продажа' then 1 else 0 end) as count
from leads;

--16. Считаем конверсии
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
),

result as (
select
	t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    count(distinct t.visitor_id) as visitors_count,
    coalesce(y.summ, v.summ) as cost,
    count(distinct t.lead_id) as leads_count,
        round(cast(count(distinct t.lead_id) as decimal) * 100 / cast(count(distinct t.visitor_id) as decimal), 2) as users_to_leads_percent,
    sum(
        case when t.closing_reason = 'Успешная продажа' then 1 else 0 end
    ) as purchases_count,
    case
    	when sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end) = 0 then 0
    	else round(cast(sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end ) as decimal) * 100 / cast(count(distinct t.lead_id) as decimal), 2) 
    end as leads_to_purchases_percent,
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
order by
    count(distinct t.visitor_id) desc,
    t.utm_source asc
)

select
	utm_source,
    sum(visitors_count) as total_visitors,
   	sum(cost) as total_cost,
    sum(leads_count) as total_leads,
    round(cast(sum(leads_count) as decimal) * 100 / cast(sum(visitors_count) as decimal), 2) as users_to_leads_percent,
    case
    	when sum(purchases_count) = 0 then 0
    	else round(cast(sum(purchases_count) as decimal) * 100 / cast(sum(leads_count) as decimal), 2) 
    end as leads_to_purchases_percent,
    sum(purchases_count) as total_purchases,
    sum(revenue) as total_revenue
from result
group by utm_source
order by sum(visitors_count) desc
limit 2;

--17. Считаем окупаемость
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
),

result as (
select
	t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    count(distinct t.visitor_id) as visitors_count,
    coalesce(y.summ, v.summ) as cost,
    count(distinct t.lead_id) as leads_count,
        round(cast(count(distinct t.lead_id) as decimal) * 100 / cast(count(distinct t.visitor_id) as decimal), 2) as users_to_leads_percent,
    sum(
        case when t.closing_reason = 'Успешная продажа' then 1 else 0 end
    ) as purchases_count,
    case
    	when sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end) = 0 then 0
    	else round(cast(sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end ) as decimal) * 100 / cast(count(distinct t.lead_id) as decimal), 2) 
    end as leads_to_purchases_percent,
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
order by
    count(distinct t.visitor_id) desc,
    t.utm_source asc
)

select
	utm_source,
  sum(visitors_count) as total_visitors,
   sum(cost) as total_cost,
  sum(leads_count) as total_leads,
  round(cast(sum(leads_count) as decimal) * 100 / cast(sum(visitors_count) as decimal), 2) as users_to_leads_percent,
  case
    when sum(purchases_count) = 0 then 0
    else round(cast(sum(purchases_count) as decimal) * 100 / cast(sum(leads_count) as decimal), 2) 
  end as leads_to_purchases_percent,
  sum(purchases_count) as total_purchases,
  sum(revenue) - sum(cost) as total_profit,
  sum(revenue) as total_revenue,
  case
    when sum(purchases_count) = 0 then 0
    else round((sum(revenue) - sum(cost)) * 100 / sum(cost), 2) 
  end as roi
from result
group by utm_source
order by sum(visitors_count) desc
limit 2;

--18. Считаем основные метрики
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
),

result as (
select
	t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    count(distinct t.visitor_id) as visitors_count,
    coalesce(y.summ, v.summ) as cost,
    count(distinct t.lead_id) as leads_count,
        round(cast(count(distinct t.lead_id) as decimal) * 100 / cast(count(distinct t.visitor_id) as decimal), 2) as users_to_leads_percent,
    sum(
        case when t.closing_reason = 'Успешная продажа' then 1 else 0 end
    ) as purchases_count,
    case
    	when sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end) = 0 then 0
    	else round(cast(sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end ) as decimal) * 100 / cast(count(distinct t.lead_id) as decimal), 2) 
    end as leads_to_purchases_percent,
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
order by
    count(distinct t.visitor_id) desc,
    t.utm_source asc
)

select
	utm_source,
    sum(visitors_count) as total_visitors,
   	sum(cost) as total_cost,
    sum(leads_count) as total_leads,
    round(cast(sum(leads_count) as decimal) * 100 / cast(sum(visitors_count) as decimal), 2) as users_to_leads_percent,
    case
    	when sum(purchases_count) = 0 then 0
    	else round(cast(sum(purchases_count) as decimal) * 100 / cast(sum(leads_count) as decimal), 2) 
    end as leads_to_purchases_percent,
    sum(purchases_count) as total_purchases,
    sum(revenue) as total_revenue,
    case
    	when sum(purchases_count) = 0 then 0
    	else round((sum(revenue) - sum(cost)) * 100 / sum(cost), 2) 
  	end as roi,
  	case when sum(visitors_count) = 0 then 0 else round(sum(cost) / sum(visitors_count), 2) end as cpu,
   	case when sum(leads_count) = 0 then 0 else round(sum(cost) / sum(leads_count), 2) end as cpl,
   	case when sum(purchases_count) = 0 then 0 else round(sum(cost) / sum(purchases_count), 2) end as cppu
from result
group by utm_source 
order by sum(visitors_count) desc
limit 2;

--23. Основные данные по проведённым промокампаниям
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
),

result as (
select
	t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    count(distinct t.visitor_id) as visitors_count,
    coalesce(y.summ, v.summ) as cost,
    count(distinct t.lead_id) as leads_count,
        round(cast(count(distinct t.lead_id) as decimal) * 100 / cast(count(distinct t.visitor_id) as decimal), 2) as users_to_leads_percent,
    sum(
        case when t.closing_reason = 'Успешная продажа' then 1 else 0 end
    ) as purchases_count,
    case
    	when sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end) = 0 then 0
    	else round(cast(sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end ) as decimal) * 100 / cast(count(distinct t.lead_id) as decimal), 2) 
    end as leads_to_purchases_percent,
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
order by
    count(distinct t.visitor_id) desc,
    t.utm_source asc
)

select
	utm_source,
    utm_medium,
    utm_campaign,
    sum(visitors_count) as total_visitors,
   	sum(cost) as total_cost,
    sum(leads_count) as total_leads,
    round(cast(sum(leads_count) as decimal) * 100 / cast(sum(visitors_count) as decimal), 2) as users_to_leads_percent,
    case
    	when sum(purchases_count) = 0 then 0
    	else round(cast(sum(purchases_count) as decimal) * 100 / cast(sum(leads_count) as decimal), 2) 
    end as leads_to_purchases_percent,
    sum(purchases_count) as total_purchases,
    coalesce(sum(revenue), 0) as total_revenue,
    coalesce(sum(revenue), 0) - sum(cost) as total_profit,
    case
    	when sum(purchases_count) = 0 then 0
    	else round((sum(revenue) - sum(cost)) * 100 / sum(cost), 2) 
  	end as roi,
  	case when sum(visitors_count) = 0 then 0 else round(sum(cost) / sum(visitors_count), 2) end as cpu,
   	case when sum(leads_count) = 0 then 0 else round(sum(cost) / sum(leads_count), 2) end as cpl,
   	case when sum(purchases_count) = 0 then 0 else round(sum(cost) / sum(purchases_count), 2) end as cppu
from result
group by
    utm_source,
  	utm_medium,
    utm_campaign
having sum(cost) > 0
order by sum(revenue) - sum(cost) desc;

--22. Основные данные по каналам привлечения
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
),

result as (
select
	t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    count(distinct t.visitor_id) as visitors_count,
    coalesce(y.summ, v.summ) as cost,
    count(distinct t.lead_id) as leads_count,
        round(cast(count(distinct t.lead_id) as decimal) * 100 / cast(count(distinct t.visitor_id) as decimal), 2) as users_to_leads_percent,
    sum(
        case when t.closing_reason = 'Успешная продажа' then 1 else 0 end
    ) as purchases_count,
    case
    	when sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end) = 0 then 0
    	else round(cast(sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end ) as decimal) * 100 / cast(count(distinct t.lead_id) as decimal), 2) 
    end as leads_to_purchases_percent,
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
order by
    count(distinct t.visitor_id) desc,
    t.utm_source asc
)

select
	utm_source,
    sum(visitors_count) as total_visitors,
   	sum(cost) as total_cost,
    sum(leads_count) as total_leads,
    round(cast(sum(leads_count) as decimal) * 100 / cast(sum(visitors_count) as decimal), 2) as users_to_leads_percent,
    case
    	when sum(purchases_count) = 0 then 0
    	else round(cast(sum(purchases_count) as decimal) * 100 / cast(sum(leads_count) as decimal), 2) 
    end as leads_to_purchases_percent,
    sum(purchases_count) as total_purchases,
    sum(revenue) as total_revenue,
    sum(revenue) - sum(cost) as total_profit,
    case
    	when sum(purchases_count) = 0 then 0
    	else round((sum(revenue) - sum(cost)) * 100 / sum(cost), 2) 
  	end as roi,
  	case when sum(visitors_count) = 0 then 0 else round(sum(cost) / sum(visitors_count), 2) end as cpu,
   	case when sum(leads_count) = 0 then 0 else round(sum(cost) / sum(leads_count), 2) end as cpl,
   	case when sum(purchases_count) = 0 then 0 else round(sum(cost) / sum(purchases_count), 2) end as cppu
from result
group by utm_source
having sum(purchases_count) > 0 and sum(cost) > 0
order by sum(revenue) - sum(cost) desc;

--24. Считаем данные для воронок продаж
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
),

result as (
select
	t.utm_source,
    t.utm_medium,
    t.utm_campaign,
    count(distinct t.visitor_id) as visitors_count,
    coalesce(y.summ, v.summ) as cost,
    count(distinct t.lead_id) as leads_count,
        round(cast(count(distinct t.lead_id) as decimal) * 100 / cast(count(distinct t.visitor_id) as decimal), 2) as users_to_leads_percent,
    sum(
        case when t.closing_reason = 'Успешная продажа' then 1 else 0 end
    ) as purchases_count,
    case
    	when sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end) = 0 then 0
    	else round(cast(sum(case when t.closing_reason = 'Успешная продажа' then 1 else 0 end ) as decimal) * 100 / cast(count(distinct t.lead_id) as decimal), 2) 
    end as leads_to_purchases_percent,
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
order by
    count(distinct t.visitor_id) desc,
    t.utm_source asc
)

select
	'Посетители' as level,
	(select count(visitor_id)
	from sessions) as total,
	(select sum(visitors_count)
	from result
	where utm_source = 'yandex') as yandex,
	(select sum(visitors_count)
	from result
	where utm_source = 'vk') as vk
from result
union
select
	'Лиды' as level,
	(select count(distinct lead_id)
	from leads) as total,
	(select sum(leads_count)
	from result
	where utm_source = 'yandex') as yandex,
	(select sum(leads_count)
	from result
	where utm_source = 'vk') as vk
from result
union
select
	'Продажи' as level,
	(select sum(case when closing_reason = 'Успешная продажа' then 1 else 0 end)
	from leads) as total,
	(select sum(purchases_count)
	from result
	where utm_source = 'yandex') as yandex,
	(select sum(purchases_count)
	from result
	where utm_source = 'vk') as vk
from result;

--27. Считаем данные по расходам на кампании
    select
        utm_source,
        utm_medium,
        utm_campaign,
        campaign_name,
        to_char(campaign_date, 'YYYY-MM-DD') as campaign_date,
        sum(daily_spent) as summ
    from ya_ads
    group by
        utm_source,
        utm_medium,
        utm_campaign,
        campaign_name,
        to_char(campaign_date, 'YYYY-MM-DD')
	union
	select
        utm_source,
        utm_medium,
        utm_campaign,
        campaign_name,
       	to_char(campaign_date, 'YYYY-MM-DD') as campaign_date,
        sum(daily_spent) as summ
    from vk_ads
    group by
        utm_source,
        utm_medium,
        utm_campaign,
        campaign_name,
        to_char(campaign_date, 'YYYY-MM-DD')
    order by 1, 2, 3, 4, 5;