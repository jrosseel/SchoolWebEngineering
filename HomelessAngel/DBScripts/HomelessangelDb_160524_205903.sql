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
   `oid`  integer  not null,
   `isanomynous`  bit,
   `profession`  varchar(255)
);


-- HomelessPerson [ent4]
create table `homelessperson` (
   `oid`  integer  not null,
   `nickname`  varchar(255),
   `locatedincity`  varchar(255),
   `yearsonstreet`  integer
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


-- Offer_PickupAddress [rel11]
alter table `offer`  add column  `address_oid`  integer;
alter table `offer`   add index fk_offer_address (`address_oid`), add constraint fk_offer_address foreign key (`address_oid`) references `address` (`oid`);
create index `idx_offer_address` on `offer`(`address_oid`);


-- Offer_Request [rel14]
alter table `request`  add column  `offer_oid`  integer;
alter table `request`   add index fk_request_offer (`offer_oid`), add constraint fk_request_offer foreign key (`offer_oid`) references `offer` (`oid`);
create index `idx_request_offer` on `request`(`offer_oid`);


-- Notification_Request [rel26]
alter table `request`  add column  `notification_oid`  integer;
alter table `request`   add index fk_request_notification (`notification_oid`), add constraint fk_request_notification foreign key (`notification_oid`) references `notification` (`oid`);
create index `idx_request_notification` on `request`(`notification_oid`);


-- Offer_Picture [rel6]
alter table `picture`  add column  `offer_oid`  integer;
alter table `picture`   add index fk_picture_offer (`offer_oid`), add constraint fk_picture_offer foreign key (`offer_oid`) references `offer` (`oid`);
create index `idx_picture_offer` on `picture`(`offer_oid`);


-- GEN FK: Angel --> UserProfile
alter table `angel`   add index fk_angel_userprofile (`oid`), add constraint fk_angel_userprofile foreign key (`oid`) references `userprofile` (`oid`);


-- GEN FK: HomelessPerson --> UserProfile
alter table `homelessperson`   add index fk_homelessperson_userprofile (`oid`), add constraint fk_homelessperson_userprofile foreign key (`oid`) references `userprofile` (`oid`);


