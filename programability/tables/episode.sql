CREATE TABLE episode
(
 id int 	auto_increment not null
,season int not null
,episode int not null
,title varchar(255) not null
,director varchar(255) null
,writer varchar(255) null
,viewers varchar(15) null
,summary varchar(1500) null

,primary key(id)
);