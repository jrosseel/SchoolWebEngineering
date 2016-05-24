-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table `user`  add column  `group_oid`  integer;
alter table `user`   add index fk_user_group_2 (`group_oid`), add constraint fk_user_group_2 foreign key (`group_oid`) references `group` (`oid`);


-- Angel_Address [rel16]
alter table `angel`  add column  `address_oid`  integer;
alter table `angel`   add index fk_angel_address_2 (`address_oid`), add constraint fk_angel_address_2 foreign key (`address_oid`) references `address` (`oid`);


-- User_UserProfile [rel2]
alter table `userprofile`  add column  `user_oid`  integer;
alter table `userprofile`   add index fk_userprofile_user_2 (`user_oid`), add constraint fk_userprofile_user_2 foreign key (`user_oid`) references `user` (`useroid`);


