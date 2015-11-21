-- create admin user
INSERT INTO ufo.user(firstname, lastname, username, email) 
VALUES ('Thomas', 'Herzog', 'het', 'herzog.thoams81@gmail.com');
SET @userId = LAST_INSERT_ID();

-- create artist groups
<#list artistGroups as entry>
INSERT INTO ufo.artist_group (name, description, creation_user_id, modification_user_id) 
VALUES ('${entry.key}', '${entry.value}', @userId, @userId);
</#list>
SET @artistGroupOffset = LAST_INSERT_ID();

-- create categories
<#list categories as entry>
INSERT INTO ufo.artist_category (name, description, creation_user_id, modification_user_id) 
VALUES ('${entry.key}', '${entry.value}', @userId, @userId);
</#list>
SET @artistCategoryOffset = LAST_INSERT_ID();

-- create venues
<#list venues as venue>
INSERT INTO ufo.venue(name, description, street, zip, city, country_code, gps_coordinate, creation_user_id, modification_user_id) 
VALUES ('${venue.name}', '${venue.name}', '${venue.street}', '${venue.zip}', '${venue.city}', '${venue.countryCode}', '${venue.gps}', @userId, @userId);
</#list>
SET @venueOffset = LAST_INSERT_ID();

-- create artists (freemarker used model holds set category/group id value)
<#list artists as artist>
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('${artist.firstName}', '${artist.lastName}', '${artist.email}', '${artist.countryCode}', ${artist.image}, ${artist.imageFileType}, ${artist.url}, (@artistCategoryOffset - ${artist.getArtistCategoryId(artistCategoryCount)}), (@artistGroupOffset - ${artist.getArtistGroupId(artistGroupCount)}), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, email, creation_user_id, modification_user_id) 
VALUES ('${artist.firstName}', '${artist.lastName}', '${artist.email}', '${artist.email}', @userId, @userId);
-- venues for artists
	<#list 1..performanceCount as i>
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('${performance.startDate}', '${performance.endDate}', @userId, @userId, @artistId, (@venueOffset - ${performance.getVenueId(venuesCount)}));
	</#list>
</#list>
