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
   `email`  varchar(255),
   `password`  varchar(255),
   `usertype`  integer,
   `name`  varchar(255),
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
   `isdisabled`  bit,
   `disabledreason`  bit,
   `iscancelled`  bit,
   `cancellationdate`  datetime,
   `disableddate`  datetime,
   `birthdate`  date,
  primary key (`oid`)
);


-- Angel [ent3]
create table `angel` (
   `userprofile_oid`  integer  not null,
   `oid`  integer  not null,
   `isanomynous`  bit,
   `profession`  varchar(255),
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
   `seen`  bit,
   `seendate`  datetime,
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
create index `idx_group_module` on `group`(`module_oid`);


-- Group_Module [Group2Module_Module2Group]
create table `group_module` (
   `group_oid`  integer not null,
   `module_oid`  integer not null,
  primary key (`group_oid`, `module_oid`)
);
alter table `group_module`   add index fk_group_module_group (`group_oid`), add constraint fk_group_module_group foreign key (`group_oid`) references `group` (`oid`);
alter table `group_module`   add index fk_group_module_module (`module_oid`), add constraint fk_group_module_module foreign key (`module_oid`) references `module` (`oid`);
create index `idx_group_module_group` on `group_module`(`group_oid`);
create index `idx_group_module_module` on `group_module`(`module_oid`);


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table `user`  add column  `group_oid`  integer;
alter table `user`   add index fk_user_group (`group_oid`), add constraint fk_user_group foreign key (`group_oid`) references `group` (`oid`);
create index `idx_user_group` on `user`(`group_oid`);


-- User_Group [User2Group_Group2User]
create table `user_group` (
   `user_oid`  integer not null,
   `group_oid`  integer not null,
  primary key (`user_oid`, `group_oid`)
);
alter table `user_group`   add index fk_user_group_user (`user_oid`), add constraint fk_user_group_user foreign key (`user_oid`) references `user` (`oid`);
alter table `user_group`   add index fk_user_group_group (`group_oid`), add constraint fk_user_group_group foreign key (`group_oid`) references `group` (`oid`);
create index `idx_user_group_user` on `user_group`(`user_oid`);
create index `idx_user_group_group` on `user_group`(`group_oid`);


-- Angel_Offer [rel1]
alter table `offer`  add column  `angel_oid`  integer;
alter table `offer`   add index fk_offer_angel (`angel_oid`), add constraint fk_offer_angel foreign key (`angel_oid`) references `angel` (`userprofile_oid`);
create index `idx_offer_angel` on `offer`(`angel_oid`);


-- Offer_PickupAddress [rel11]
alter table `offer`  add column  `address_oid`  integer;
alter table `offer`   add index fk_offer_address (`address_oid`), add constraint fk_offer_address foreign key (`address_oid`) references `address` (`oid`);
create index `idx_offer_address` on `offer`(`address_oid`);


-- HomelessPerson_Request [rel13]
alter table `request`  add column  `homelessperson_oid`  integer;
alter table `request`   add index fk_request_homelessperson (`homelessperson_oid`), add constraint fk_request_homelessperson foreign key (`homelessperson_oid`) references `homelessperson` (`userprofile_oid`);
create index `idx_request_homelessperson` on `request`(`homelessperson_oid`);


-- Offer_Request [rel14]
alter table `request`  add column  `offer_oid`  integer;
alter table `request`   add index fk_request_offer (`offer_oid`), add constraint fk_request_offer foreign key (`offer_oid`) references `offer` (`oid`);
create index `idx_request_offer` on `request`(`offer_oid`);


-- UserProfile_Picture [rel18]
alter table `picture`  add column  `userprofile_oid`  integer;
alter table `picture`   add index fk_picture_userprofile (`userprofile_oid`), add constraint fk_picture_userprofile foreign key (`userprofile_oid`) references `userprofile` (`oid`);
create index `idx_picture_userprofile` on `picture`(`userprofile_oid`);


-- User_UserProfile [rel2]
alter table `userprofile`  add column  `user_oid`  integer;
alter table `userprofile`   add index fk_userprofile_user (`user_oid`), add constraint fk_userprofile_user foreign key (`user_oid`) references `user` (`oid`);
create index `idx_userprofile_user` on `userprofile`(`user_oid`);


-- Request_Transaction [rel22]
alter table `request`  add column  `transaction_oid`  integer;
alter table `request`   add index fk_request_transaction (`transaction_oid`), add constraint fk_request_transaction foreign key (`transaction_oid`) references `transaction` (`oid`);
create index `idx_request_transaction` on `request`(`transaction_oid`);


-- Notification_UserProfile [rel25]
alter table `notification`  add column  `oid`  integer;
alter table `userprofile`   add index fk_notification_userprofile (`oid`), add constraint fk_notification_userprofile foreign key (`oid`) references `userprofile` (`oid`);
create index `idx_notification_userprofile` on `userprofile`(`oid`);


-- Notification_Request [rel26]
alter table `request`  add column  `notification_oid`  integer;
alter table `request`   add index fk_request_notification (`notification_oid`), add constraint fk_request_notification foreign key (`notification_oid`) references `notification` (`oid`);
create index `idx_request_notification` on `request`(`notification_oid`);


-- Angel_Address [rel3]
alter table `angel`  add column  `address_oid`  integer;
alter table `angel`   add index fk_angel_address (`address_oid`), add constraint fk_angel_address foreign key (`address_oid`) references `address` (`oid`);
create index `idx_angel_address` on `angel`(`address_oid`);


-- Offer_OfferCategory [rel4]
alter table `offer`  add column  `offercategory_oid`  integer;
alter table `offer_offercategory`   add index fk_offer_offercategory (`offercategory_oid`), add constraint fk_offer_offercategory foreign key (`offercategory_oid`) references `offercategory` (`oid`);
create index `idx_offer_offercategory` on `offer_offercategory`(`offercategory_oid`);


-- Offer_OfferType [rel5]
alter table `offer`  add column  `offertype_oid`  integer;
alter table `offer_offertype`   add index fk_offer_offertype (`offertype_oid`), add constraint fk_offer_offertype foreign key (`offertype_oid`) references `offertype` (`oid`);
create index `idx_offer_offertype` on `offer_offertype`(`offertype_oid`);


-- Offer_Picture [rel6]
alter table `picture`  add column  `offer_oid`  integer;
alter table `picture`   add index fk_picture_offer (`offer_oid`), add constraint fk_picture_offer foreign key (`offer_oid`) references `offer` (`oid`);
create index `idx_picture_offer` on `picture`(`offer_oid`);


-- Offer_DeliveryMethod [rel8]
alter table `offer`  add column  `deliverymethod_oid`  integer;
alter table `offer`   add index fk_offer_deliverymethod (`deliverymethod_oid`), add constraint fk_offer_deliverymethod foreign key (`deliverymethod_oid`) references `deliverymethod` (`oid`);
create index `idx_offer_deliverymethod` on `offer`(`deliverymethod_oid`);


-- Transaction_Rating [rel9]
alter table `rating`  add column  `transaction_oid`  integer;
alter table `rating`   add index fk_rating_transaction (`transaction_oid`), add constraint fk_rating_transaction foreign key (`transaction_oid`) references `transaction` (`oid`);
create index `idx_rating_transaction` on `rating`(`transaction_oid`);


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


