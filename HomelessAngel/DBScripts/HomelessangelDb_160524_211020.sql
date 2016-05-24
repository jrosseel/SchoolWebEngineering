-- Angel.avgRating [ent3#att1]
create view `angel_avgrating_view` as
select AL1.`userprofile_oid` as `userprofile_oid`, avg(AL5.`score`) as `der_attr`
from  `angel` AL1 
               left outer join `offer` AL2 on AL1.`userprofile_oid`=AL2.`angel_oid`
               left outer join `request` AL3 on AL2.`oid`=AL3.`offer_oid`
               left outer join `transaction` AL4 on AL3.`transaction_oid`=AL4.`oid`
               left outer join `rating` AL5 on AL4.`rating_oid`=AL5.`oid`
group by AL1.`userprofile_oid`;


-- Angel.amtOfItemsGivenAway [ent3#att15]
create view `angel_amtofitemsgivenaway_view` as
select AL1.`userprofile_oid` as `userprofile_oid`, sum(AL3.`amount`) as `der_attr`
from  `angel` AL1 
               left outer join `offer` AL2 on AL1.`userprofile_oid`=AL2.`angel_oid`
               left outer join `request` AL3 on AL2.`oid`=AL3.`offer_oid`
where AL3.`isaccepted` = '1'
group by AL1.`userprofile_oid`;


