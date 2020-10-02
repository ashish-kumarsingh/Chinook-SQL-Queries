use chinook;

select * from Invoice;

/*a. Total sales */
select sum(Total) as Total_sales from invoice;

/*b. Total sales by country – ranked */

    select DENSE_RANK() OVER  (order by sum(total) desc) as Ranking,
    customer.Country, sum(total) as Total_Sales from invoice 
    join Customer on Customer.customerid=Invoice.CustomerId
    group by customer.Country;

/*c. Total sales by country, state & city*/

select customer.Country,coalesce(customer.state,' ') as State, customer.City, 
sum(total) as Total_Sales from invoice 
join Customer on Customer.customerid=Invoice.CustomerId
group by customer.Country,Customer.state,customer.City
order by customer.country;

/*d. Total sales by customer – ranked*/

select DENSE_RANK() OVER  (order by sum(total) desc) as Ranking,
CONCAT(CONCAT(LastName,' '),FirstName) as Name,
sum(total) as Total_Sales from invoice 
join Customer on Customer.customerid=Invoice.CustomerId
group by LastName,FirstName;


/*Total sales by artist – ranked*/

select DENSE_RANK()OVER(order by sum(InvoiceLine.unitprice) desc) as Ranking,artist.name,
sum(InvoiceLine.unitprice)as Total_Sales from InvoiceLine
join track on Track.TrackId=InvoiceLine.TrackId
join album on album.AlbumId=track.AlbumId
join artist on Artist.ArtistId=Album.artistid
group by artist.name;

/*f.Total sales by artist & their albums*/
select Album.Title, artist.name as Artist_Name,
sum(InvoiceLine.quantity * InvoiceLine.unitprice) as Total_Sales  from InvoiceLine
join track on Track.TrackId=InvoiceLine.TrackId
join album on album.AlbumId=track.AlbumId	
join artist on album.artistid=artist.artistid
group by Album.Title, artist.name
order by Total_sales desc;

/*g.Total sales by sales person (employee)*/
select CONCAT(CONCAT(e.LastName,' '),e.FirstName) as Name,
sum(total) as Total_Sales  from Invoice	
join Customer on Customer.customerid=Invoice.CustomerId
join Employee e on e.EmployeeId=customer.SupportRepId
group by e.Lastname,e.FirstName
order by Total_Sales desc;

select * from employee;
/*h.Total tracks bought and total cost by media type*/
select MediaType.name,sum(il.quantity * il.unitprice) as Total_Sales,
count(il.Quantity) as Quantity from InvoiceLine il
join track on Track.TrackId=il.TrackId
join MediaType on MediaType.MediaTypeId=track.MediaTypeId	
group by MediaType.name,il.Quantity
order by Total_Sales desc;




