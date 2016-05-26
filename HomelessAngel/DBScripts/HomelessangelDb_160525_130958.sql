-- Angel.angelName [ent3#att17]
create view `angel_angelname_view` as
select AL1.`userprofile_oid` as `userprofile_oid`, 'anonymous' as `der_attr`
from  `angel` AL1 ;


