delete from ufo.performance;
commit;
delete from ufo.venue;
commit;
delete from ufo.artist;
commit;
delete from ufo.artist_category;
commit;
delete from ufo.artist_group;
commit;
update ufo.user set creation_user_id=null;
update ufo.user set modification_user_id=null;
delete from ufo.user;
commit;