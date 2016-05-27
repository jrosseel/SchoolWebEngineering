-- Notification_Rejected_Request [rel3]
alter table `request`  add column  `notification_oid_2`  integer;
alter table `request`   add index fk_request_notification_2 (`notification_oid_2`), add constraint fk_request_notification_2 foreign key (`notification_oid_2`) references `notification` (`oid`);


