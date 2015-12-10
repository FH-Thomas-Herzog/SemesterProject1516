-- create admin user
INSERT INTO ufo.user(firstname, lastname, username, password, email, user_type) 
VALUES ('Thomas', 'Herzog', 'superuser', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK', 'herzog.thoams81@gmail.com', 0);
SET @userId = LAST_INSERT_ID();

-- create artist groups
INSERT INTO ufo.artist_group (name, description, creation_user_id, modification_user_id) 
VALUES ('Einzelkünstler', 'Einzelkünstler', @userId, @userId);
INSERT INTO ufo.artist_group (name, description, creation_user_id, modification_user_id) 
VALUES ('Die Tümpler', 'Comedy aus Wien', @userId, @userId);
INSERT INTO ufo.artist_group (name, description, creation_user_id, modification_user_id) 
VALUES ('Linzer Dichtergruppe', '5 Dichter aus Linz', @userId, @userId);
SET @artistGroupOffset = LAST_INSERT_ID();

-- create categories
INSERT INTO ufo.artist_category (name, description, creation_user_id, modification_user_id) 
VALUES ('Stra�entheater', 'T', @userId, @userId);
INSERT INTO ufo.artist_category (name, description, creation_user_id, modification_user_id) 
VALUES ('Local Art', 'L', @userId, @userId);
INSERT INTO ufo.artist_category (name, description, creation_user_id, modification_user_id) 
VALUES ('Comedy & Jonglage', 'J', @userId, @userId);
INSERT INTO ufo.artist_category (name, description, creation_user_id, modification_user_id) 
VALUES ('Akrobatik & Tanz', 'A', @userId, @userId);
INSERT INTO ufo.artist_category (name, description, creation_user_id, modification_user_id) 
VALUES ('Luftakrobatik', 'A', @userId, @userId);
INSERT INTO ufo.artist_category (name, description, creation_user_id, modification_user_id) 
VALUES ('Clownerie & Pantomime', 'C', @userId, @userId);
INSERT INTO ufo.artist_category (name, description, creation_user_id, modification_user_id) 
VALUES ('Walkact, Stelzen, Stehstill', 'J', @userId, @userId);
INSERT INTO ufo.artist_category (name, description, creation_user_id, modification_user_id) 
VALUES ('Musik, Samba, Percussion', 'M', @userId, @userId);
INSERT INTO ufo.artist_category (name, description, creation_user_id, modification_user_id) 
VALUES ('Feuerperformances', 'F', @userId, @userId);
INSERT INTO ufo.artist_category (name, description, creation_user_id, modification_user_id) 
VALUES ('Figuren- und Objekttheater', 'T', @userId, @userId);
INSERT INTO ufo.artist_category (name, description, creation_user_id, modification_user_id) 
VALUES ('Kinderprogramm', 'K', @userId, @userId);
SET @artistCategoryOffset = LAST_INSERT_ID();

-- create venues
INSERT INTO ufo.venue(name, description, street, zip, city, country_code, gps_coordinate, creation_user_id, modification_user_id) 
VALUES ('Dreifaltigkeitssäule', 'Dreifaltigkeitssäule', 'Hauptplatz', '4020', 'Linz', 'AT', '48.305996, 14.286406', @userId, @userId);
INSERT INTO ufo.venue(name, description, street, zip, city, country_code, gps_coordinate, creation_user_id, modification_user_id) 
VALUES ('Mader Reisen', 'Mader Reisen', 'Donauradweg', '4040', 'Linz', 'AT', '48.309966, 14.286820', @userId, @userId);
INSERT INTO ufo.venue(name, description, street, zip, city, country_code, gps_coordinate, creation_user_id, modification_user_id) 
VALUES ('Neues Rathaus', 'Neues Rathaus', 'Hauptstraße 2', '4040', 'Linz', 'AT', '48.309728, 14.283816', @userId, @userId);
INSERT INTO ufo.venue(name, description, street, zip, city, country_code, gps_coordinate, creation_user_id, modification_user_id) 
VALUES ('Fa. Mammut', 'Fa. Mammut', 'Neubaustraße 13', '4400', 'Steyr', 'AT', '48.030056, 14.417700', @userId, @userId);
INSERT INTO ufo.venue(name, description, street, zip, city, country_code, gps_coordinate, creation_user_id, modification_user_id) 
VALUES ('Pfarrplatz', 'Pfarrplatz', 'Pfarrplatz', '4040', 'Linz', 'AT', '48.306723, 14.288944', @userId, @userId);
INSERT INTO ufo.venue(name, description, street, zip, city, country_code, gps_coordinate, creation_user_id, modification_user_id) 
VALUES ('Postamt', 'Postamt', 'Zaunmüllerstraße 4', '4020', 'Linz', 'AT', '48.284881, 14.305500', @userId, @userId);
INSERT INTO ufo.venue(name, description, street, zip, city, country_code, gps_coordinate, creation_user_id, modification_user_id) 
VALUES ('Altstadt Linz', 'Altstadt Linz', 'Herrenstraße 13', '4020', 'Linz', 'AT', '48.302677, 14.286698', @userId, @userId);
SET @venueOffset = LAST_INSERT_ID();

-- create artists (freemarker used model holds set category/group id value)
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Anne & Mitja', '', 'annemitja@gmail.com', 'MG', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 2), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Anne & Mitja', '', 'annemitja@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','annemitja@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-08 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-12 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-22 10:41:39', '2015-12-23 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-21 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-26 10:41:39', '2016-01-27 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-08 10:41:39', '2016-01-08 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-29 10:41:39', '2016-01-30 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Anta', 'Agni', 'antaagni@gmail.com', 'MH', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 1), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Anta', 'Agni', 'antaagni@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','antaagni@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-15 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-29 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-29 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-18 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-20 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-12 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-24 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-26 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Barada', 'Street', 'baradastreet@gmail.com', 'AT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 1), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Barada', 'Street', 'baradastreet@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','baradastreet@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-23 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-03 10:41:39', '2016-01-04 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-08 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-23 10:41:39', '2015-12-24 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-11 10:41:39', '2016-01-12 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Batucada Brass Hakuna Ma Samba', '', 'batucadabrasshakunamasamba@gmail.com', 'AT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 2), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Batucada Brass Hakuna Ma Samba', '', 'batucadabrasshakunamasamba@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','batucadabrasshakunamasamba@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-18 10:41:39', '2016-01-19 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-18 10:41:39', '2016-01-19 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-31 10:41:39', '2015-12-31 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-13 10:41:39', '2015-12-13 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-02 10:41:39', '2016-01-02 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Bence Sarkadi Theater of Marionettes ', '', 'bencesarkaditheaterofmarionettes@gmail.com', 'AT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 9), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Bence Sarkadi Theater of Marionettes ', '', 'bencesarkaditheaterofmarionettes@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','bencesarkaditheaterofmarionettes@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-22 10:41:39', '2015-12-23 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-23 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-14 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-07 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-29 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-08 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-16 10:41:39', '2016-01-17 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-15 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Benni', 'Green', 'bennigreen@gmail.com', 'AT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 3), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Benni', 'Green', 'bennigreen@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','bennigreen@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-22 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-21 10:41:39', '2016-01-22 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-11 10:41:39', '2016-01-12 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-17 10:41:39', '2015-12-18 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-02 10:41:39', '2016-01-03 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-04 10:41:39', '2016-01-04 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-28 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Bigolis', 'Teatre', 'bigolisteatre@gmail.com', 'CZ', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 10), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Bigolis', 'Teatre', 'bigolisteatre@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','bigolisteatre@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-21 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-29 10:41:39', '2016-01-30 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-07 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-15 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-13 10:41:39', '2015-12-13 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-29 10:41:39', '2016-01-30 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-15 10:41:39', '2016-01-16 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-17 10:41:39', '2015-12-17 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-16 10:41:39', '2015-12-17 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Blechsalat', '', 'blechsalat@gmail.com', 'AT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 0), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Blechsalat', '', 'blechsalat@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','blechsalat@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-17 10:41:39', '2015-12-18 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-30 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-01 10:41:39', '2016-01-02 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-29 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-08 10:41:39', '2016-01-09 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-25 10:41:39', '2015-12-26 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-15 10:41:39', '2015-12-16 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-31 10:41:39', '2016-01-01 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-25 10:41:39', '2015-12-26 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-15 10:41:39', '2015-12-16 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Box Actor Yaya', '', 'boxactoryaya@gmail.com', 'HU', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 7), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Box Actor Yaya', '', 'boxactoryaya@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','boxactoryaya@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-25 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-15 10:41:39', '2016-01-16 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-16 10:41:39', '2015-12-17 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-25 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-27 10:41:39', '2015-12-28 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Cia.', 'ElOtro', 'cia.elotro@gmail.com', 'AT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 3), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Cia.', 'ElOtro', 'cia.elotro@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','cia.elotro@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-11 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-27 10:41:39', '2015-12-28 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-11 10:41:39', '2016-01-12 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-24 10:41:39', '2016-01-25 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-03 10:41:39', '2016-01-04 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-15 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-25 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-02 10:41:39', '2016-01-03 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-23 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-16 10:41:39', '2016-01-17 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Cia. Jean Philippe Kikolas', '', 'cia.jeanphilippekikolas@gmail.com', 'AT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 6), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Cia. Jean Philippe Kikolas', '', 'cia.jeanphilippekikolas@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','cia.jeanphilippekikolas@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-16 10:41:39', '2016-01-17 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-25 10:41:39', '2016-01-26 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-18 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-25 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-21 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-21 10:41:39', '2016-01-21 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-21 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-12 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-15 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Cia.', 'Passabarret', 'cia.passabarret@gmail.com', 'AT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 8), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Cia.', 'Passabarret', 'cia.passabarret@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','cia.passabarret@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-24 10:41:39', '2016-01-24 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-08 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-24 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-12 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-17 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-23 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-25 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Cia.', 'ZagreB', 'cia.zagreb@gmail.com', 'IT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 8), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Cia.', 'ZagreB', 'cia.zagreb@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','cia.zagreb@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-26 10:41:39', '2016-01-27 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-08 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-01 10:41:39', '2016-01-02 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-15 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-25 10:41:39', '2015-12-26 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-07 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-16 10:41:39', '2015-12-16 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-14 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-14 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-12 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('circoPitanga', '', 'circopitanga@gmail.com', 'AT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 1), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('circoPitanga', '', 'circopitanga@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','circopitanga@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-13 10:41:39', '2015-12-14 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-31 10:41:39', '2016-01-01 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-29 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-14 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-04 10:41:39', '2016-01-05 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-29 10:41:39', '2016-01-30 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-15 10:41:39', '2015-12-16 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Compagnie', 'Antipodes', 'compagnieantipodes@gmail.com', 'SK', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 9), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Compagnie', 'Antipodes', 'compagnieantipodes@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','compagnieantipodes@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-01 10:41:39', '2016-01-02 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-17 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-20 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-06 10:41:39', '2016-01-07 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Compagnie', 'MOBIL', 'compagniemobil@gmail.com', 'CH', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 4), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Compagnie', 'MOBIL', 'compagniemobil@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','compagniemobil@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-14 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-12 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-21 10:41:39', '2016-01-22 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-20 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-26 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-15 10:41:39', '2015-12-15 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-13 10:41:39', '2015-12-14 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-15 10:41:39', '2015-12-16 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-21 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-13 10:41:39', '2015-12-14 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('DANCEproject', '', 'danceproject@gmail.com', 'AT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 8), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('DANCEproject', '', 'danceproject@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','danceproject@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-26 10:41:39', '2016-01-27 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-27 10:41:39', '2015-12-27 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-13 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-25 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-24 10:41:39', '2016-01-25 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-01 10:41:39', '2016-01-02 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-16 10:41:39', '2016-01-17 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-23 10:41:39', '2015-12-24 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Derek', 'Derek', 'derekderek@gmail.com', 'CZ', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 7), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Derek', 'Derek', 'derekderek@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','derekderek@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-25 10:41:39', '2016-01-26 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-24 10:41:39', '2016-01-25 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-15 10:41:39', '2015-12-16 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-07 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-13 10:41:39', '2015-12-14 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-23 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Die', 'Buschs', 'diebuschs@gmail.com', 'AT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 6), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Die', 'Buschs', 'diebuschs@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','diebuschs@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-12 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-15 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-13 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-21 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-08 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-21 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-12 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Dimitar and Tui (AiO Company)', '', 'dimitarandtui@gmail.com', 'AT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 2), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Dimitar and Tui (AiO Company)', '', 'dimitarandtui@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','dimitarandtui@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-08 10:41:39', '2016-01-08 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-25 10:41:39', '2016-01-26 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-14 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-15 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-21 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-23 10:41:39', '2015-12-24 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-04 10:41:39', '2016-01-05 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Dj Capuzzi & Se�orita X', '', 'djcapuzzisenoritax@gmail.com', 'ES', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 3), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Dj Capuzzi & Se�orita X', '', 'djcapuzzisenoritax@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','djcapuzzisenoritax@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-25 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-04 10:41:39', '2016-01-04 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-21 10:41:39', '2016-01-22 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-24 10:41:39', '2016-01-25 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-20 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-29 10:41:39', '2016-01-30 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-08 10:41:39', '2016-01-09 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-18 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Dr. Bubbles & die Seifenblasenbande', '', 'dr.bubblesdieseifenblasenbande@gmail.com', 'DE', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 1), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Dr. Bubbles & die Seifenblasenbande', '', 'dr.bubblesdieseifenblasenbande@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','dr.bubblesdieseifenblasenbande@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-09 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-26 10:41:39', '2016-01-27 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-25 10:41:39', '2015-12-25 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-21 10:41:39', '2016-01-22 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-30 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-26 10:41:39', '2016-01-27 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-15 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-14 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Duo Kate and Pasi', '', 'duokateandpasi@gmail.com', 'GB', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 5), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Duo Kate and Pasi', '', 'duokateandpasi@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','duokateandpasi@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-18 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-14 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-25 10:41:39', '2015-12-26 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-15 10:41:39', '2016-01-16 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-24 10:41:39', '2016-01-25 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-23 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-25 10:41:39', '2016-01-25 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-22 10:41:39', '2015-12-23 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Duo', 'Looky', 'duolooky@gmail.com', 'IT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 6), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Duo', 'Looky', 'duolooky@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','duolooky@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-31 10:41:39', '2016-01-01 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-22 10:41:39', '2015-12-23 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-21 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-01 10:41:39', '2016-01-01 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-22 10:41:39', '2015-12-23 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-11 10:41:39', '2016-01-12 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-23 10:41:39', '2015-12-24 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Duo', 'Masawa', 'duomasawa@gmail.com', 'IT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 8), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Duo', 'Masawa', 'duomasawa@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','duomasawa@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-04 10:41:39', '2016-01-05 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-01 10:41:39', '2016-01-02 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-20 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-22 10:41:39', '2015-12-23 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-08 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-25 10:41:39', '2016-01-26 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-07 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Eco', 'Commotion', 'ecocommotion@gmail.com', 'LU', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 6), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Eco', 'Commotion', 'ecocommotion@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','ecocommotion@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-23 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-12 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-23 10:41:39', '2015-12-24 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-24 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-18 10:41:39', '2016-01-19 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-03 10:41:39', '2016-01-03 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-29 10:41:39', '2016-01-30 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Eddy', 'Eighty', 'eddyeighty@gmail.com', 'LV', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 8), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Eddy', 'Eighty', 'eddyeighty@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','eddyeighty@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-15 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-22 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-25 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-29 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-21 10:41:39', '2016-01-22 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-13 10:41:39', '2015-12-13 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-15 10:41:39', '2015-12-16 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('El', 'Diabolero', 'eldiabolero@gmail.com', 'LY', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 6), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('El', 'Diabolero', 'eldiabolero@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','eldiabolero@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-25 10:41:39', '2016-01-26 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-15 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-29 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-15 10:41:39', '2015-12-16 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-12 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-25 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-21 10:41:39', '2016-01-22 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-12 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Eric', 'Tarantola', 'erictarantola@gmail.com', 'MA', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 1), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Eric', 'Tarantola', 'erictarantola@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','erictarantola@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-31 10:41:39', '2016-01-01 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-06 10:41:39', '2016-01-07 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-24 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-18 10:41:39', '2016-01-18 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-16 10:41:39', '2016-01-17 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-15 10:41:39', '2016-01-15 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-18 10:41:39', '2016-01-18 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-18 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Fausto', 'Giori', 'faustogiori@gmail.com', 'MC', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 8), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Fausto', 'Giori', 'faustogiori@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','faustogiori@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-17 10:41:39', '2015-12-18 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-20 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-29 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-29 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-15 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-22 10:41:39', '2015-12-23 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('figurentheater', '(isipisi)', 'figurentheaterisipisi@gmail.com', 'MD', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 0), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('figurentheater', '(isipisi)', 'figurentheaterisipisi@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','figurentheaterisipisi@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-24 10:41:39', '2016-01-25 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-28 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-18 10:41:39', '2016-01-19 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-02 10:41:39', '2016-01-03 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('folkshilfe', '', 'folkshilfe@gmail.com', 'ME', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 4), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('folkshilfe', '', 'folkshilfe@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','folkshilfe@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-12 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-08 10:41:39', '2016-01-09 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-29 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-24 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-27 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-15 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Grande Cantagiro Barattoli', '', 'grandecantagirobarattoli@gmail.com', 'AT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 0), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Grande Cantagiro Barattoli', '', 'grandecantagirobarattoli@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','grandecantagirobarattoli@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-31 10:41:39', '2016-01-01 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-04 10:41:39', '2016-01-05 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-13 10:41:39', '2015-12-14 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-03 10:41:39', '2016-01-03 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-13 10:41:39', '2015-12-14 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-20 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-15 10:41:39', '2016-01-15 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Herr', 'Hundertpfund', 'herrhundertpfund@gmail.com', 'IE', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 6), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Herr', 'Hundertpfund', 'herrhundertpfund@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','herrhundertpfund@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-24 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-23 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-11 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-24 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-20 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-23 10:41:39', '2015-12-24 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-06 10:41:39', '2016-01-07 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Herr', 'Konrad', 'herrkonrad@gmail.com', 'MK', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 8), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Herr', 'Konrad', 'herrkonrad@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','herrkonrad@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-20 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-15 10:41:39', '2016-01-16 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-14 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-15 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-29 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-14 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-06 10:41:39', '2016-01-07 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-29 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-22 10:41:39', '2015-12-22 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Hint', '', 'hint@gmail.com', 'ML', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 9), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Hint', '', 'hint@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','hint@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-15 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-06 10:41:39', '2016-01-06 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-24 10:41:39', '2016-01-25 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-29 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-23 10:41:39', '2015-12-23 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-21 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-14 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Hipnopia & Migui Mandala Sol', '', 'hipnopiamiguimandalasol@gmail.com', 'MM', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 8), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Hipnopia & Migui Mandala Sol', '', 'hipnopiamiguimandalasol@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','hipnopiamiguimandalasol@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-25 10:41:39', '2015-12-26 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-08 10:41:39', '2016-01-09 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-24 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-20 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-24 10:41:39', '2016-01-25 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-01 10:41:39', '2016-01-02 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-15 10:41:39', '2015-12-16 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('HoopStep', '', 'hoopstep@gmail.com', 'HK', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 9), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('HoopStep', '', 'hoopstep@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','hoopstep@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-13 10:41:39', '2015-12-14 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-12 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-23 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-12 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-27 10:41:39', '2015-12-28 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-12 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-25 10:41:39', '2016-01-25 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-16 10:41:39', '2016-01-16 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Ian', 'Deadly', 'iandeadly@gmail.com', 'HM', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 8), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Ian', 'Deadly', 'iandeadly@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','iandeadly@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-15 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-29 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-29 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-18 10:41:39', '2016-01-19 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-31 10:41:39', '2016-01-01 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-23 10:41:39', '2015-12-24 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-08 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-25 10:41:39', '2016-01-26 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Kammann', '', 'kammann@gmail.com', 'HN', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 7), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Kammann', '', 'kammann@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','kammann@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-04 10:41:39', '2016-01-05 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-17 10:41:39', '2015-12-18 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-20 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-08 10:41:39', '2016-01-09 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-18 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-11 10:41:39', '2016-01-12 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Kana', '', 'kana@gmail.com', 'HR', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 0), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Kana', '', 'kana@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','kana@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-08 10:41:39', '2016-01-09 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-15 10:41:39', '2016-01-16 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-06 10:41:39', '2016-01-07 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-28 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-31 10:41:39', '2015-12-31 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Katay', 'Santos', 'kataysantos@gmail.com', 'HT', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 7), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Katay', 'Santos', 'kataysantos@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','kataysantos@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-16 10:41:39', '2015-12-17 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-15 10:41:39', '2015-12-15 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-14 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-17 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-25 10:41:39', '2015-12-26 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-06 10:41:39', '2016-01-07 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-29 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Kleines Grusel Gewusel', '', 'kleinesgruselgewusel@gmail.com', 'HU', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 6), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Kleines Grusel Gewusel', '', 'kleinesgruselgewusel@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','kleinesgruselgewusel@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-18 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-29 10:41:39', '2016-01-30 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-02 10:41:39', '2016-01-03 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('La Trocola Circo', '', 'latrocolacirco@gmail.com', 'ID', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 8), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('La Trocola Circo', '', 'latrocolacirco@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','latrocolacirco@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-29 10:41:39', '2016-01-30 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-25 10:41:39', '2016-01-26 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-24 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-29 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-22 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-04 10:41:39', '2016-01-04 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Les Contes d\'Asphalt', '', 'lescontesdasphalt@gmail.com', 'IE', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 7), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Les Contes d\'Asphalt', '', 'lescontesdasphalt@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','lescontesdasphalt@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-03 10:41:39', '2016-01-04 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-20 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-29 10:41:39', '2016-01-29 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-25 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-21 10:41:39', '2016-01-22 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-23 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-14 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Los', 'Galindos', 'losgalindos@gmail.com', 'IL', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 6), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Los', 'Galindos', 'losgalindos@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','losgalindos@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-01 10:41:39', '2016-01-01 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-20 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-15 10:41:39', '2016-01-16 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-12 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-11 10:41:39', '2016-01-12 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-31 10:41:39', '2015-12-31 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-16 10:41:39', '2015-12-17 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-15 10:41:39', '2016-01-16 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Lucy', 'Lou', 'lucylou@gmail.com', 'IM', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 6), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Lucy', 'Lou', 'lucylou@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','lucylou@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-17 10:41:39', '2015-12-18 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-20 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-21 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-15 10:41:39', '2015-12-16 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-19 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-13 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Lumen', 'Invoco', 'lumeninvoco@gmail.com', 'SK', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 10), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Lumen', 'Invoco', 'lumeninvoco@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','lumeninvoco@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-21 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-29 10:41:39', '2016-01-30 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-25 10:41:39', '2015-12-26 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-19 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-01 10:41:39', '2016-01-02 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-06 10:41:39', '2016-01-07 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Lutrek Statues & Clowns', '', 'lutrekstatuesclowns@gmail.com', 'PA', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 10), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Lutrek Statues & Clowns', '', 'lutrekstatuesclowns@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','lutrekstatuesclowns@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-29 10:41:39', '2016-01-30 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-05 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-21 10:41:39', '2016-01-22 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-22 10:41:39', '2015-12-23 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-21 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-21 10:41:39', '2016-01-22 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-03 10:41:39', '2016-01-04 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Mattress', 'Circus', 'mattresscircus@gmail.com', 'PE', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 2), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Mattress', 'Circus', 'mattresscircus@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','mattresscircus@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-12 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-03 10:41:39', '2016-01-04 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-17 10:41:39', '2015-12-18 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-01 10:41:39', '2016-01-02 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-17 10:41:39', '2015-12-18 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-23 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-24 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Maurangas', '', 'maurangas@gmail.com', 'PF', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 0), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Maurangas', '', 'maurangas@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','maurangas@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-02 10:41:39', '2016-01-03 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-29 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-23 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-24 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Mr.', 'Mostacho', 'mr.mostacho@gmail.com', 'PG', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 6), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Mr.', 'Mostacho', 'mr.mostacho@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','mr.mostacho@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-23 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-14 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-31 10:41:39', '2016-01-01 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-30 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-15 10:41:39', '2015-12-16 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-08 10:41:39', '2016-01-09 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-04 10:41:39', '2016-01-05 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Nanirossi', '', 'nanirossi@gmail.com', 'PH', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 0), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Nanirossi', '', 'nanirossi@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','nanirossi@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-20 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-20 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-08 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-15 10:41:39', '2015-12-16 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('OAKLEAF', 'Stelzenkunst', 'oakleafstelzenkunst@gmail.com', 'PK', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 4), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('OAKLEAF', 'Stelzenkunst', 'oakleafstelzenkunst@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','oakleafstelzenkunst@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-26 10:41:39', '2016-01-26 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-18 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-20 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-25 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-23 10:41:39', '2015-12-24 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-08 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-11 10:41:39', '2016-01-12 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-25 10:41:39', '2016-01-25 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Ola', 'Muchin', 'olamuchin@gmail.com', 'PL', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 4), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Ola', 'Muchin', 'olamuchin@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','olamuchin@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-12 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-11 10:41:39', '2016-01-12 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-18 10:41:39', '2016-01-18 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-17 10:41:39', '2015-12-18 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-18 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-28 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-04 10:41:39', '2016-01-05 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Omnivolant', '', 'omnivolant@gmail.com', 'PA', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 7), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Omnivolant', '', 'omnivolant@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','omnivolant@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-29 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-14 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-14 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-31 10:41:39', '2015-12-31 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-18 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-09 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-25 10:41:39', '2015-12-26 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Pallotto', '', 'pallotto@gmail.com', 'PE', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 6), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Pallotto', '', 'pallotto@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','pallotto@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-14 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-08 10:41:39', '2016-01-09 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-23 10:41:39', '2015-12-24 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-13 10:41:39', '2015-12-14 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-15 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-22 10:41:39', '2015-12-23 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-15 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Phoenix LED & Firedancers', '', 'phoenixledfiredancers@gmail.com', 'PF', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 6), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Phoenix LED & Firedancers', '', 'phoenixledfiredancers@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','phoenixledfiredancers@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-26 10:41:39', '2016-01-27 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-08 10:41:39', '2016-01-09 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-25 10:41:39', '2015-12-26 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-26 10:41:39', '2016-01-26 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-26 10:41:39', '2016-01-27 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Puppenb�hne Burattino - Koffertheater', '', 'puppenb�hneburattino-koffertheater@gmail.com', 'PG', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 8), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Puppenb�hne Burattino - Koffertheater', '', 'puppenb�hneburattino-koffertheater@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','puppenb�hneburattino-koffertheater@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-29 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-22 10:41:39', '2015-12-22 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-16 10:41:39', '2016-01-16 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-10 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-23 10:41:39', '2015-12-23 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-30 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-16 10:41:39', '2015-12-17 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-08 10:41:39', '2016-01-09 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-17 10:41:39', '2015-12-18 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Rafael', 'Sorryso', 'rafaelsorryso@gmail.com', 'PH', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 4), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Rafael', 'Sorryso', 'rafaelsorryso@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','rafaelsorryso@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-18 10:41:39', '2016-01-19 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-22 10:41:39', '2015-12-22 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-16 10:41:39', '2015-12-17 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-29 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-29 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-29 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-21 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Rewi & Mr Jeff', '', 'rewimrjeff@gmail.com', 'PK', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 2), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Rewi & Mr Jeff', '', 'rewimrjeff@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','rewimrjeff@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-20 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-24 10:41:39', '2016-01-25 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-21 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-11 10:41:39', '2016-01-12 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-26 10:41:39', '2016-01-27 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-17 10:41:39', '2015-12-18 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-23 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-06 10:41:39', '2016-01-07 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-03 10:41:39', '2016-01-04 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Samuelito', '', 'samuelito@gmail.com', 'PL', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 3), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Samuelito', '', 'samuelito@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','samuelito@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-01 10:41:39', '2016-01-02 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-18 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-04 10:41:39', '2016-01-05 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-19 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-20 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-13 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-29 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Secret', 'Circus', 'secretcircus@gmail.com', 'RO', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 5), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Secret', 'Circus', 'secretcircus@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','secretcircus@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-15 10:41:39', '2016-01-16 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-01 10:41:39', '2016-01-01 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-29 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-16 10:41:39', '2015-12-16 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-14 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-29 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-17 10:41:39', '2016-01-18 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-26 10:41:39', '2016-01-27 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-03 10:41:39', '2016-01-04 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Shining', 'Shadows', 'shiningshadows@gmail.com', 'RS', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 5), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Shining', 'Shadows', 'shiningshadows@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','shiningshadows@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-03 10:41:39', '2016-01-04 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-29 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-20 10:41:39', '2016-01-20 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-28 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-26 10:41:39', '2016-01-27 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-06 10:41:39', '2016-01-07 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('The', 'LEDies', 'theledies@gmail.com', 'RU', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 1), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('The', 'LEDies', 'theledies@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','theledies@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-13 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-03 10:41:39', '2016-01-04 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-24 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-08 10:41:39', '2016-01-09 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-21 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-26 10:41:39', '2016-01-27 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-13 10:41:39', '2015-12-13 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-23 10:41:39', '2015-12-24 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-21 10:41:39', '2016-01-21 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-18 10:41:39', '2016-01-19 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('TheFREAKS', 'Akrobatik-Showteam', 'thefreaksakrobatik-showteam@gmail.com', 'LY', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 10), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('TheFREAKS', 'Akrobatik-Showteam', 'thefreaksakrobatik-showteam@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','thefreaksakrobatik-showteam@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-03 10:41:39', '2016-01-03 11:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-29 10:41:39', '2015-12-30 03:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-18 10:41:39', '2016-01-19 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-23 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-07 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-15 10:41:39', '2016-01-16 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-14 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-27 10:41:39', '2015-12-28 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('TON', '', 'ton@gmail.com', 'MA', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 2), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('TON', '', 'ton@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','ton@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-21 10:41:39', '2016-01-22 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-16 10:41:39', '2015-12-17 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-28 10:41:39', '2016-01-29 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-15 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-05 10:41:39', '2016-01-06 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-15 10:41:39', '2016-01-16 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-24 10:41:39', '2016-01-25 12:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-09 10:41:39', '2016-01-09 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Trini-ty', '', 'trini-ty@gmail.com', 'MC', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 7), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Trini-ty', '', 'trini-ty@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','trini-ty@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-25 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-15 10:41:39', '2016-01-16 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-11 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-15 01:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-22 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-04 10:41:39', '2016-01-05 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-18 10:41:39', '2015-12-19 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-16 10:41:39', '2015-12-16 11:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-12 10:41:39', '2015-12-13 12:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-20 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Urban', 'Safari', 'urbansafari@gmail.com', 'MD', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 5), (@artistGroupOffset - 0), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Urban', 'Safari', 'urbansafari@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','urbansafari@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-24 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-04 10:41:39', '2016-01-05 03:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-03 10:41:39', '2016-01-04 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-01 10:41:39', '2016-01-02 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-13 10:41:39', '2016-01-13 11:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-18 10:41:39', '2016-01-19 12:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-21 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-24 10:41:39', '2016-01-25 01:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-28 10:41:39', '2015-12-28 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Why', 'Walk', 'whywalk@gmail.com', 'ME', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 10), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Why', 'Walk', 'whywalk@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','whywalk@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-27 10:41:39', '2016-01-28 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-24 10:41:39', '2015-12-25 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-07 10:41:39', '2016-01-08 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-11 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-19 10:41:39', '2016-01-20 01:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-10 10:41:39', '2016-01-11 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-31 10:41:39', '2015-12-31 11:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-16 10:41:39', '2016-01-17 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-02 10:41:39', '2016-01-03 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-14 10:41:39', '2015-12-15 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Zirkus', 'Gonzo', 'zirkusgonzo@gmail.com', 'SK', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 4), (@artistGroupOffset - 2), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Zirkus', 'Gonzo', 'zirkusgonzo@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','zirkusgonzo@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-22 10:41:39', '2016-01-23 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-06 10:41:39', '2016-01-06 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-17 10:41:39', '2015-12-18 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-15 01:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-11 10:41:39', '2015-12-12 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-20 10:41:39', '2015-12-21 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-02 10:41:39', '2016-01-03 03:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 02:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-23 10:41:39', '2016-01-24 02:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.artist (firstname, lastname, email, country_code, image, image_file_type, url, artist_category_id, artist_group_id, creation_user_id, modification_user_id) 
VALUES ('Zirkus', 'Morsa', 'zirkusmorsa@gmail.com', 'CH', '/9j/4AAQSkZJRgABAQEAeAB4AAD/4QAiRXhpZgAATU0AKgAAAAgAAQESAAMAAAABAAEAAAAAAAD/7AARRHVja3kAAQAEAAAAVQAA/9sAQwACAQECAQECAgICAgICAgMFAwMDAwMGBAQDBQcGBwcHBgcHCAkLCQgICggHBwoNCgoLDAwMDAcJDg8NDA4LDAwM/9sAQwECAgIDAwMGAwMGDAgHCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAGAAeAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A/fyvyx/4K8f8FGP2gPBn7Z1r8JvgZdR6Npvh3R7TUddv7S30+5vrm6umlKW/+lh440SJInwqiRjLknYV3fp94t8X6T4B8M32ta9qmn6Lo+lwtcXl/f3KW1raRKMs8kjkKigdSxAFfj//AMFX/wDgo18Arj9oXwP4y8G65e+INWhjm0rxDcaZo0vkmBNr20hkkEZmKs0qgxCQEOMlQvP0nC+HhUxilXp80En0vFO2l9GvLU8nOq1SGGaou0umtm+9tmfdn/BKj9o34k/tB/A7WLb4t6b9n8ZeE9UFhJdm3hhbUoHgimimdISYhJ87A+VhMBeFO5R9ReSn9xfyr4m/Z1/4KgfBr4Z/su/CfxBr2vQ+G4vitdXENkdXeK0m82KWaGWSYbiFhjaBIjICyh5YVyS+R9sW84uYVdQRu6g9VPcH6HiuHOcPKGJlNU+SMm7aWWjs7eV0/TY3y2tz0IqUrySV++qur/I8I/4KVfshat+3F+yZrfw/0PxBbeG9Vu7m2vra5uoXmtZZLeUSrFKqkMEZlHzAMUYKwVioB/ETxt/wbkftcWevuraL4L8RCOQ4utN8TRiGQZ6qLhIXx9UBoorTL8+xWDpexpWcb3s11duzXZFYjAUq0/aS32Ps/wDYD/YC/bO+BvhbRfBmoW3wh0jwj4f1V9d0q58TyNrV54Yv3ilge606O2IUyGOebKTOIz5rkYLNu/Vbwpo83h7wvptjc3j6hc2dtHDNdvGI2unVQGkKrwCxBYgcAmiiubMcyqYyftKkYp+Stv8Ae/x3u92XhcLGhHli2/Vn/9k=', 'jpg', '<rootServer>/UFO/Common/defaultLink.xhtml', (@artistCategoryOffset - 0), (@artistGroupOffset - 1), @userId, @userId);
SET @artistId = LAST_INSERT_ID();
-- user for artist
INSERT INTO ufo.user(firstname, lastname, username, password, email, creation_user_id, modification_user_id, user_type) 
VALUES ('Zirkus', 'Morsa', 'zirkusmorsa@gmail.com', '$2a$10$JD8UOiv8E1pUMUnm/i9ESuM2FCF87g/cSQ3bh.F52wfEfmfdzNdZK','zirkusmorsa@gmail.com', @userId, @userId, 1);
-- venues for artists
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-12 10:41:39', '2016-01-13 12:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-24 10:41:39', '2016-01-25 03:41:39', @userId, @userId, @artistId, (@venueOffset - 2));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-14 10:41:39', '2016-01-14 11:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-25 10:41:39', '2015-12-26 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-26 10:41:39', '2015-12-27 12:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2016-01-29 10:41:39', '2016-01-30 03:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-21 10:41:39', '2015-12-22 02:41:39', @userId, @userId, @artistId, (@venueOffset - 4));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-23 10:41:39', '2015-12-24 01:41:39', @userId, @userId, @artistId, (@venueOffset - 1));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-19 10:41:39', '2015-12-20 02:41:39', @userId, @userId, @artistId, (@venueOffset - 3));
INSERT INTO ufo.performance(start_date, end_date, creation_user_id, modification_user_id, artist_id, venue_id) 
VALUES ('2015-12-30 10:41:39', '2015-12-31 02:41:39', @userId, @userId, @artistId, (@venueOffset - 0));
