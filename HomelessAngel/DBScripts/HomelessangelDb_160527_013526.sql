-- Notification_Transaction [rel1]
alter table `transaction`  add column  `notification_oid`  integer;
alter table `transaction`   add index fk_transaction_notification (`notification_oid`), add constraint fk_transaction_notification foreign key (`notification_oid`) references `notification` (`oid`);


