-- Group [Group]
create table `group` (
   `oid`  integer  not null,
   `groupname`  varchar(255),
  primary key (`oid`)
);


-- Module [Module]
create table `module` (
   `oid`  integer  not null,
   `moduleid`  varchar(255),
   `modulename`  varchar(255),
  primary key (`oid`)
);


-- User [User]
create table `user` (
   `oid`  integer  not null,
   `name`  varchar(255),
   `password`  varchar(255),
   `email`  varchar(255),
   `usertype`  integer,
  primary key (`oid`)
);


-- Request [ent1]
create table `request` (
   `oid`  integer  not null,
   `amount`  integer,
   `isaccepted`  bit,
   `requestedon`  datetime,
  primary key (`oid`)
);


-- OfferCategory [ent10]
create table `offercategory` (
   `oid`  integer  not null,
   `name`  varchar(255),
  primary key (`oid`)
);


-- Picture [ent11]
create table `picture` (
   `oid`  integer  not null,
   `description`  varchar(255),
   `fileloc`  varchar(255),
   `title`  varchar(255),
  primary key (`oid`)
);


-- DeliveryMethod [ent12]
create table `deliverymethod` (
   `oid`  integer  not null,
   `name`  varchar(255),
  primary key (`oid`)
);


-- Rating [ent13]
create table `rating` (
   `oid`  integer  not null,
   `score`  integer,
   `comment`  varchar(255),
  primary key (`oid`)
);


-- Transaction [ent14]
create table `transaction` (
   `oid`  integer  not null,
   `deliverydate`  datetime,
   `iscompleted`  bit,
   `requesteddate`  datetime,
  primary key (`oid`)
);


-- UserProfile [ent2]
create table `userprofile` (
   `oid`  integer  not null,
   `birthdate`  date,
   `isdisabled`  bit,
   `disabledreason`  bit,
   `iscancelled`  bit,
   `cancellationdate`  datetime,
   `disableddate`  datetime,
  primary key (`oid`)
);


-- Angel [ent3]
create table `angel` (
   `userprofile_oid`  integer  not null,
   `oid`  integer  not null,
   `profession`  varchar(255),
   `isanomynous`  bit,
  primary key (`userprofile_oid`)
);


-- HomelessPerson [ent4]
create table `homelessperson` (
   `userprofile_oid`  integer  not null,
   `oid`  integer  not null,
   `nickname`  varchar(255),
   `locatedincity`  varchar(255),
   `yearsonstreet`  integer,
  primary key (`userprofile_oid`)
);


-- Address [ent5]
create table `address` (
   `oid`  integer  not null,
   `street`  varchar(255),
   `hnumber`  varchar(255),
   `postalcode`  varchar(255),
   `city`  varchar(255),
   `country`  varchar(255),
   `bus`  varchar(255),
  primary key (`oid`)
);


-- Notification [ent6]
create table `notification` (
   `oid`  integer  not null,
   `seendate`  datetime,
   `seen`  bit,
   `description`  varchar(255),
   `notificationtype`  integer,
  primary key (`oid`)
);


-- Offer [ent8]
create table `offer` (
   `oid`  integer  not null,
   `isremoved`  bit,
   `removedreason`  varchar(255),
   `amount`  integer,
   `description`  varchar(255),
   `expirydate`  date,
   `creationdate`  datetime,
  primary key (`oid`)
);


-- OfferType [ent9]
create table `offertype` (
   `oid`  integer  not null,
   `name`  varchar(255),
  primary key (`oid`)
);


-- Group_DefaultModule [Group2DefaultModule_DefaultModule2Group]
alter table `group`  add column  `module_oid`  integer;
alter table `group`   add index fk_group_module (`module_oid`), add constraint fk_group_module foreign key (`module_oid`) references `module` (`oid`);


-- Group_Module [Group2Module_Module2Group]
create table `group_module` (
   `group_oid`  integer not null,
   `module_oid`  integer not null,
  primary key (`group_oid`, `module_oid`)
);
alter table `group_module`   add index fk_group_module_group (`group_oid`), add constraint fk_group_module_group foreign key (`group_oid`) references `group` (`oid`);
alter table `group_module`   add index fk_group_module_module (`module_oid`), add constraint fk_group_module_module foreign key (`module_oid`) references `module` (`oid`);


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table `user`  add column  `group_oid`  integer;
alter table `user`   add index fk_user_group (`group_oid`), add constraint fk_user_group foreign key (`group_oid`) references `group` (`oid`);


-- User_Group [User2Group_Group2User]
create table `user_group` (
   `user_oid`  integer not null,
   `group_oid`  integer not null,
  primary key (`user_oid`, `group_oid`)
);
alter table `user_group`   add index fk_user_group_user (`user_oid`), add constraint fk_user_group_user foreign key (`user_oid`) references `user` (`oid`);
alter table `user_group`   add index fk_user_group_group (`group_oid`), add constraint fk_user_group_group foreign key (`group_oid`) references `group` (`oid`);


-- Angel_Offer [rel1]
alter table `offer`  add column  `angel_oid`  integer;
alter table `offer`   add index fk_offer_angel (`angel_oid`), add constraint fk_offer_angel foreign key (`angel_oid`) references `angel` (`userprofile_oid`);


-- Transaction_DeliveryAddress [rel10]
alter table `transaction`  add column  `address_oid`  integer;
alter table `transaction`   add index fk_transaction_address (`address_oid`), add constraint fk_transaction_address foreign key (`address_oid`) references `address` (`oid`);


-- Offer_PickupAddress [rel11]
alter table `offer`  add column  `address_oid`  integer;
alter table `offer`   add index fk_offer_address (`address_oid`), add constraint fk_offer_address foreign key (`address_oid`) references `address` (`oid`);


-- HomelessPerson_Request [rel13]
alter table `request`  add column  `homelessperson_oid`  integer;
alter table `request`   add index fk_request_homelessperson (`homelessperson_oid`), add constraint fk_request_homelessperson foreign key (`homelessperson_oid`) references `homelessperson` (`userprofile_oid`);


-- Offer_Request [rel14]
alter table `request`  add column  `offer_oid`  integer;
alter table `request`   add index fk_request_offer (`offer_oid`), add constraint fk_request_offer foreign key (`offer_oid`) references `offer` (`oid`);


-- UserProfile_Picture [rel18]
alter table `picture`  add column  `userprofile_oid`  integer;
alter table `picture`   add index fk_picture_userprofile (`userprofile_oid`), add constraint fk_picture_userprofile foreign key (`userprofile_oid`) references `userprofile` (`oid`);


-- User_UserProfile [rel2]
alter table `userprofile`  add column  `user_oid`  integer;
alter table `userprofile`   add index fk_userprofile_user (`user_oid`), add constraint fk_userprofile_user foreign key (`user_oid`) references `user` (`oid`);


-- Request_Transaction [rel22]
alter table `request`  add column  `transaction_oid`  integer;
alter table `request`   add index fk_request_transaction (`transaction_oid`), add constraint fk_request_transaction foreign key (`transaction_oid`) references `transaction` (`oid`);


-- Transaction_RequestedAddress [rel23]
create table `transaction_requestedaddress` (
   `transaction_oid`  integer not null,
   `address_oid`  integer not null,
  primary key (`transaction_oid`, `address_oid`)
);
alter table `transaction_requestedaddress`   add index fk_transaction_requestedaddres (`transaction_oid`), add constraint fk_transaction_requestedaddres foreign key (`transaction_oid`) references `transaction` (`oid`);
alter table `transaction_requestedaddress`   add index fk_transaction_requestedaddr_2 (`address_oid`), add constraint fk_transaction_requestedaddr_2 foreign key (`address_oid`) references `address` (`oid`);


-- Notification_UserProfile [rel25]
alter table `userprofile`  add column  `notification_oid`  integer;
alter table `userprofile`   add index fk_userprofile_notification (`notification_oid`), add constraint fk_userprofile_notification foreign key (`notification_oid`) references `notification` (`oid`);


-- Notification_Request [rel26]
alter table `request`  add column  `notification_oid`  integer;
alter table `request`   add index fk_request_notification (`notification_oid`), add constraint fk_request_notification foreign key (`notification_oid`) references `notification` (`oid`);


-- Angel_Address [rel3]
alter table `angel`  add column  `address_oid`  integer;
alter table `angel`   add index fk_angel_address (`address_oid`), add constraint fk_angel_address foreign key (`address_oid`) references `address` (`oid`);


-- Offer_OfferCategory [rel4]
create table `offer_offercategory` (
   `offer_oid`  integer not null,
   `offercategory_oid`  integer not null,
  primary key (`offer_oid`, `offercategory_oid`)
);
alter table `offer_offercategory`   add index fk_offer_offercategory_offer (`offer_oid`), add constraint fk_offer_offercategory_offer foreign key (`offer_oid`) references `offer` (`oid`);
alter table `offer_offercategory`   add index fk_offer_offercategory_offerca (`offercategory_oid`), add constraint fk_offer_offercategory_offerca foreign key (`offercategory_oid`) references `offercategory` (`oid`);


-- Offer_OfferType [rel5]
create table `offer_offertype` (
   `offer_oid`  integer not null,
   `offertype_oid`  integer not null,
  primary key (`offer_oid`, `offertype_oid`)
);
alter table `offer_offertype`   add index fk_offer_offertype_offer (`offer_oid`), add constraint fk_offer_offertype_offer foreign key (`offer_oid`) references `offer` (`oid`);
alter table `offer_offertype`   add index fk_offer_offertype_offertype (`offertype_oid`), add constraint fk_offer_offertype_offertype foreign key (`offertype_oid`) references `offertype` (`oid`);


-- Offer_Picture [rel6]
alter table `picture`  add column  `offer_oid`  integer;
alter table `picture`   add index fk_picture_offer (`offer_oid`), add constraint fk_picture_offer foreign key (`offer_oid`) references `offer` (`oid`);


-- Offer_DeliveryMethod [rel8]
alter table `offer`  add column  `deliverymethod_oid`  integer;
alter table `offer`   add index fk_offer_deliverymethod (`deliverymethod_oid`), add constraint fk_offer_deliverymethod foreign key (`deliverymethod_oid`) references `deliverymethod` (`oid`);


-- Transaction_Rating [rel9]
alter table `rating`  add column  `transaction_oid`  integer;
alter table `rating`   add index fk_rating_transaction (`transaction_oid`), add constraint fk_rating_transaction foreign key (`transaction_oid`) references `transaction` (`oid`);


-- GEN FK: Angel --> UserProfile
alter table `angel`   add index fk_angel_userprofile (`userprofile_oid`), add constraint fk_angel_userprofile foreign key (`userprofile_oid`) references `userprofile` (`oid`);


-- GEN FK: HomelessPerson --> UserProfile
alter table `homelessperson`   add index fk_homelessperson_userprofile (`userprofile_oid`), add constraint fk_homelessperson_userprofile foreign key (`userprofile_oid`) references `userprofile` (`oid`);


-- Angel.avgRating [ent3#att15]
create view `angel_avgrating_view` as
select AL1.`userprofile_oid` as `userprofile_oid`, avg(AL4.`score`) as `der_attr`
from  `angel` AL1 
               left outer join `offer` AL2 on AL1.`userprofile_oid`=AL2.`angel_oid`
               left outer join `request` AL3 on AL2.`oid`=AL3.`offer_oid`
               left outer join `rating` AL4 on AL3.`transaction_oid`=AL4.`transaction_oid`
group by AL1.`userprofile_oid`;


-- Angel.amtOfItemsGivenAway [ent3#att54]
create view `angel_amtofitemsgivenaway_view` as
select AL1.`userprofile_oid` as `userprofile_oid`, sum(AL3.`amount`) as `der_attr`
from  `angel` AL1 
               left outer join `offer` AL2 on AL1.`userprofile_oid`=AL2.`angel_oid`
               left outer join `request` AL3 on AL2.`oid`=AL3.`offer_oid`
where AL3.`isaccepted` = '1'
group by AL1.`userprofile_oid`;


