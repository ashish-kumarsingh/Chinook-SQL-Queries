use chinook;

select * from Invoice;
select * from employee;

/*a. Total sales */
select sum (total) as Total_sales from invoice;

/*b. Total sales by country – ranked */

select DENSE_RANK() OVER  (order by sum (total) desc) as Ranking,
customer.Country, sum (total) as Total_Sales from invoice 
join Customer on Customer.customerid=Invoice.CustomerId
group by customer.Country;

/*c. Total sales by country, state & city*/

select customer.Country,Customer.state, customer.City, sum (total) as Total_Sales from invoice 
join Customer on Customer.customerid=Invoice.CustomerId
group by customer.Country,Customer.state,customer.City
order by customer.country;

/*d. Total sales by customer – ranked*/

select DENSE_RANK() OVER  (order by sum (total) desc) as Ranking,CONCAT_WS(' ',LastName,FirstName) as Name,
 sum (total) as Total_Sales from invoice 
join Customer on Customer.customerid=Invoice.CustomerId
group by LastName,FirstName;


/*e. Total sales by artist – ranked*/

select DENSE_RANK() OVER  (order by sum (il.unitprice) desc) as Ranking,artist.name,
sum (il.unitprice)as Total_Sales   from InvoiceLine as il
join track on Track.TrackId=il.TrackId
join album on album.AlbumId=track.AlbumId
join artist on Artist.ArtistId=Album.artistid
group by artist.name;

/*f.Total sales by artist & their albums*/
select Album.Title, album.ArtistId,DENSE_RANK() OVER  (order by sum (il.quantity * il.unitprice) desc) as Ranking,
sum (il.quantity * il.unitprice) as Total_Sales  from InvoiceLine as il
join track on Track.TrackId=il.TrackId
join album on album.AlbumId=track.AlbumId	
group by Album.Title,album.ArtistId;

/*g.Total sales by sales person (employee)*/
select CONCAT_WS(' ',e.LastName,e.FirstName) as Name,
sum (total) as Total_Sales  from Invoice	
join Customer on Customer.customerid=Invoice.CustomerId
join Employee as e on e.EmployeeId=customer.SupportRepId
group by e.Lastname,e.FirstName;


/*h.Total tracks bought and total cost by media type*/
select MediaType.name,sum (il.quantity * il.unitprice) as Total_Sales ,count(il.Quantity) as Quantity
from InvoiceLine as il
join track on Track.TrackId=il.TrackId
join MediaType on MediaType.MediaTypeId=track.MediaTypeId	
group by MediaType.name,il.Quantity
order by Total_Sales desc;




