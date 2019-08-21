/*1*/
SELECT 
    COUNT(city_id) AS no_of_cities,
    COUNT(DISTINCT state) AS no_of_states
FROM
    city;
    


SELECT 
    state.state, COUNT(city_id)
FROM
    city join state on city.state=state.state_id
GROUP BY state;

/*2*/
SELECT 
    AVG(price) AS average_rent,
    MIN(price) AS minimum_rent,
    MAX(price) AS maximum_rent
FROM
    price;

/*3*/
SELECT 
    round(AVG(ppsq),3) AS average_rent_persqft,
    round(MIN(ppsq),3) AS minimum_rent_persqft,
    round(MAX(ppsq),3) AS maximum_rent_persqft
FROM
    ppsq;

/*4*/
SELECT 
    round(AVG(ppsq),3) AS average_rent_persqft
FROM
    city join ppsq on city.city_id=ppsq.city_city_id
GROUP BY state
HAVING state = 'TX';


/*5*/
SELECT 
    COUNT(*) as no_of_metros
FROM
    (SELECT 
        metro_metro_id
    FROM
        city
    JOIN ppsq ON city.city_id = ppsq.city_city_id and state='TX'
    GROUP BY metro_metro_id , state
    HAVING AVG(ppsq) > (SELECT 
            AVG(ppsq)
        FROM
            city
        JOIN ppsq ON city.city_id = ppsq.city_city_id
        GROUP BY state
        HAVING state = 'TX')) as noofmetros;

/*6*/

select metro, city from city join metro on city.metro_metro_id=metro.metro_id where metro_metro_id in (
SELECT 
    city.metro_metro_id
FROM
    city
        JOIN
    ppsq ON city.city_id = ppsq.city_city_id and state='TX'
        JOIN
    metro ON metro.metro_id = city.metro_metro_id
GROUP BY metro_metro_id , state
HAVING AVG(ppsq) > (SELECT 
        AVG(ppsq)
    FROM
        city
            JOIN
        ppsq ON city.city_id = ppsq.city_city_id
    GROUP BY state
    HAVING state = 'TX'));
    
/*7*/

select * from ((
select avg(price) as avg15
from city c join price p on
c.city_id=p.city_city_id
where p.date='2015-09-01'
group by metro_metro_id, state) as avg15,
(select avg(price) as avg16
from city c join price p on
c.city_id=p.city_city_id
where p.date='2016-09-01'
group by metro_metro_id, state) as avg16);


select c.metro_metro_id,
case when date='2015-09-01' then avg(p.price) end,
case when date='2016-09-01' then (p.price) end
from city c join price p on
c.city_id=p.city_city_id
group by c.metro_metro_id, state;



select mtrid, diff from (select avg15.metro_metro_id as mtrid, (avg16-avg15) as diff 
from 
(select metro_metro_id, avg(price) as avg15
from city c join price p on
c.city_id=p.city_city_id
where p.date='2015-09-01'
and state='TX'
group by metro_metro_id, state) as avg15 join
(select metro_metro_id, avg(price) as avg16
from city c join price p on
c.city_id=p.city_city_id
where p.date='2016-09-01'
and state='TX'
group by metro_metro_id, state) as avg16
on avg15.metro_metro_id=avg16.metro_metro_id) as differ
where diff>=0
group by mtrid
having diff=5;


select metro.metro, diff from (select avg15.metro_metro_id as mtrid, (avg16-avg15) as diff 
from 
(select metro_metro_id, avg(price) as avg15
from city c join price p on
c.city_id=p.city_city_id
where p.date='2015-09-01'
and state='TX'
group by metro_metro_id, state) as avg15 join
(select metro_metro_id, avg(price) as avg16
from city c join price p on
c.city_id=p.city_city_id
where p.date='2016-09-01'
and state='TX'
group by metro_metro_id, state) as avg16
on avg15.metro_metro_id=avg16.metro_metro_id) as differ
join metro on metro.metro_id=differ.mtrid
where diff>=0
group by mtrid
having diff IN (select min(diff) from (
select avg15.metro_metro_id, (avg16-avg15) as diff from (select metro_metro_id, avg(price) as avg15
from city c join price p on
c.city_id=p.city_city_id
join metro m on
c.metro_metro_id=m.metro_id
where p.date='2015-09-01'
and state='TX'
group by metro_metro_id) as avg15 join
(select metro_metro_id, avg(price) as avg16
from city c join price p on
c.city_id=p.city_city_id
join metro m on
c.metro_metro_id=m.metro_id
where p.date='2016-09-01'
and state='TX'
group by metro_metro_id, state) as avg16
on avg15.metro_metro_id=avg16.metro_metro_id) as differ
where diff>0);