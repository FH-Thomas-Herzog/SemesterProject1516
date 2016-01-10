package at.fh.ooe.ufo.data.generator;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.net.URL;
import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.AbstractMap.SimpleEntry;
import java.util.Base64;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Objects;
import java.util.Random;

import org.mindrot.jbcrypt.BCrypt;

import freemarker.template.Configuration;
import freemarker.template.Template;

public class TestDataGenerator {

	private static final String ROOT_LOCATION = "META-INF/resources/";
	private static final String ROOT_FTL_TEMPLATE = "META-INF/templates/";
	private static final String CATEGORY_DATA = "categories.csv";
	private static final String COUNTRIES_DATA = "countries.csv";
	private static final String ARTIST_DATA = "artist.csv";
	private static final String VENUE_DATA = "venue.csv";

	private static final String FTL_TEMPLATE = "test-data-template.ftl";

	private static final String IMAGE_TYPE = "jpg";
	private static final String IMAGE_FILE = "add-user-icon." + IMAGE_TYPE;

	private static final String SEPARATOR = ";";
	private static final String DEFAULT_PASSWORD = "123";
	private static final SecureRandom SECURE_RANDOM = new SecureRandom();
	private static final String PASSWORD_ENCRYPTED = BCrypt.hashpw(DEFAULT_PASSWORD, BCrypt.gensalt(10, SECURE_RANDOM));
	private static final int DAYS_COUNT = 5;

	public static class Performance {

		private Calendar startCal;
		private final int venueCount;
		private final Random random = new Random();
		boolean toogle = Boolean.FALSE;
		private int hourOffset = 0;
		private int initDay = 0;
		private int offset = 0;
		private int startHour = 8;
		private boolean start = Boolean.FALSE;
		private int currentVenueId = 1;

		public Performance(int venueCount) {
			super();
			this.venueCount = venueCount;
			startCal = Calendar.getInstance(Locale.GERMAN);
			startCal.set(2016, Calendar.JANUARY, Calendar.MONDAY, startHour, 0, 0);
			initDay = startCal.get(Calendar.DAY_OF_YEAR);
			reset();
		}

		public void reset() {
			hourOffset = 0;
			if (start) {
				startCal.add(Calendar.DAY_OF_YEAR, 1);
			} else {
				start = Boolean.TRUE;
			}
			startCal.set(Calendar.HOUR_OF_DAY, startHour);
			startCal.set(Calendar.MILLISECOND, 0);
			startCal.set(Calendar.SECOND, 0);
			startCal.set(Calendar.MINUTE, 0);
		}

		public void toggle() {
			if (offset == 1) {
				offset = 0;
				startHour = 8;
				initDay = startCal.get(Calendar.DAY_OF_YEAR);
				start = Boolean.FALSE;
			} else {
				currentVenueId++;
				currentVenueId = (currentVenueId < venueCount) ? currentVenueId : 1;
				offset = 1;
				startHour = 9;
			}
			startCal.set(Calendar.DAY_OF_YEAR, initDay);
			reset();
		}

		public String getStartDate() {
			startCal.add(Calendar.HOUR_OF_DAY, hourOffset);
			hourOffset += 2;
			return format(startCal);
		}

		public String getEndDate() {
			final Calendar cal = (Calendar) startCal.clone();
			cal.add(Calendar.HOUR, 1);
			return format(cal);
		}

		public String format(Calendar cal) {
			return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", new Locale("de", "DE")).format(cal.getTime());
		}

		public int getVenueId() {
			return currentVenueId;
		}
	}

	public static class Venue {
		private final String name;
		private final String street;
		private final String zip;
		private final String city;
		private final String gps;

		public Venue(String name, String street, String zip, String city, String gps) {
			super();
			this.name = name;
			this.street = street;
			this.zip = zip;
			this.city = city;
			this.gps = gps;
		}

		public String getName() {
			return name;
		}

		public String getStreet() {
			return street;
		}

		public String getZip() {
			return zip;
		}

		public String getCity() {
			return city;
		}

		public String getGps() {
			return gps;
		}
	}

	public static class Artist {
		private final String firstName;
		private final String lastName;
		private final String email;
		private final String countryCode;
		private final String image = DEFAULT_IMAGE;
		private final String imageFileType = IMAGE_TYPE;
		private final String url;
		private int artistCategoryId;
		private int artistGroupId;

		private List<Venue> venues = new LinkedList<>();

		private final Random random = new Random();

		private static final String DEFAULT_IMAGE;
		private static final String DEFAULT_URL = "<rootServer>/UFO/Common/defaultLink.xhtml";

		static {
			final URL url = getResourceURL(ROOT_LOCATION + IMAGE_FILE);
			final File file = new File(URLDecoder.decode(url.getPath()));
			try (final BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file))) {
				try (final ByteArrayOutputStream bos = new ByteArrayOutputStream(1014)) {
					byte[] data = new byte[1024];
					int length = 0;
					while ((length = bis.read(data)) != -1) {
						bos.write(data, 0, length);
					}
					DEFAULT_IMAGE = Base64.getEncoder().encodeToString(bos.toByteArray());
				}
			} catch (Exception e) {
				throw new IllegalStateException(e);
			}
		}

		public Artist(String name, String email, String countryCode) {
			super();
			this.email = email;
			this.countryCode = countryCode;
			this.url = DEFAULT_URL;
			String[] splitName = name.split(" ");
			if (splitName.length == 2) {
				firstName = splitName[0];
				lastName = splitName[1];
			} else {
				firstName = name;
				lastName = "";
			}
		}

		public int getArtistGroupId(int max) {
			return (artistGroupId = ((int) (random.nextInt(1000) % max)));
		}

		public int getArtistCategoryId(int max) {
			return (artistCategoryId = ((int) (random.nextInt(1000) % max)));
		}

		public int getArtistCategoryId() {
			return artistCategoryId;
		}

		public int getArtistGroupId() {
			return artistGroupId;
		}

		public String getFirstName() {
			return firstName;
		}

		public String getLastName() {
			return lastName;
		}

		public String getEmail() {
			return email;
		}

		public String getCountryCode() {
			return countryCode;
		}

		public String getImage() {
			return (image != null) ? ("'" + image + "'") : getNullString();
		}

		public String getImageFileType() {
			return (imageFileType != null) ? ("'" + imageFileType + "'") : getNullString();
		}

		public String getUrl() {
			return (url != null) ? ("'" + url + "'") : getNullString();
		}

		public String getPassword() {
			return PASSWORD_ENCRYPTED;
		}

		public String getNullString() {
			return "NULL";
		}
	}

	public static void main(String args[]) throws Throwable {
		final List<Entry<String, String>> countries = loadCountryData();
		final List<Entry<String, String>> categories = loadCategoryData();
		final List<Entry<String, String>> artistCategroies = loadArtistCategoryData();
		final List<Entry<String, String>> artistGroups = loadArtistGroupData();
		final List<Artist> artists = loadArtistData();
		final List<Venue> venues = loadVEnueData();

		final Map<String, Object> parameters = new HashMap<>();
		parameters.put("artistCategoryCount", categories.size());
		parameters.put("artistGroupCount", artistGroups.size());
		parameters.put("venuesCount", venues.size());
		parameters.put("performanceCount", 4);
		parameters.put("daysCount", DAYS_COUNT);
		parameters.put("categories", categories);
		parameters.put("countries", countries);
		parameters.put("artistCategories", artistCategroies);
		parameters.put("artistGroups", artistGroups);
		parameters.put("artists", artists);
		parameters.put("venues", venues);
		parameters.put("performance", new Performance(venues.size()));
		parameters.put("adminPassword", PASSWORD_ENCRYPTED);

		final Configuration config = new Configuration();
		config.setClassLoaderForTemplateLoading(TestDataGenerator.class.getClassLoader(), "");

		final Template template = config.getTemplate(ROOT_FTL_TEMPLATE + FTL_TEMPLATE);
		template.setAutoFlush(true);

		try (final BufferedWriter br = new BufferedWriter(new FileWriter(new File("C:/ufo-test-data.sql")))) {
			template.process(parameters, br);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static List<Entry<String, String>> loadCountryData() {
		final List<String[]> data = readData(ROOT_LOCATION + COUNTRIES_DATA);
		final List<Entry<String, String>> entries = new LinkedList<>();

		for (String[] string : data) {
			entries.add(new SimpleEntry<String, String>(string[0], string[1]));
		}

		return entries;
	}

	private static List<Entry<String, String>> loadCategoryData() {
		final List<String[]> data = readData(ROOT_LOCATION + CATEGORY_DATA);
		final List<Entry<String, String>> entries = new LinkedList<>();

		for (String[] string : data) {
			entries.add(new SimpleEntry<String, String>(string[0], string[1]));
		}

		return entries;
	}

	private static List<Artist> loadArtistData() {
		final List<String[]> data = readData(ROOT_LOCATION + ARTIST_DATA);
		final List<Artist> entries = new LinkedList<>();

		for (String[] string : data) {
			entries.add(new Artist(string[0], string[1], string[2]));
		}

		return entries;
	}

	private static List<Entry<String, String>> loadArtistCategoryData() {
		final List<Entry<String, String>> items = new LinkedList<>();
		items.add(new SimpleEntry<>("Straßenkünstler", "Straßenkünstlergrupper"));
		items.add(new SimpleEntry<>("Komödiant", "Komödie"));
		items.add(new SimpleEntry<>("Dichter", "Dichtung"));
		items.add(new SimpleEntry<>("Theater", "Theater"));

		return items;
	}

	private static List<Entry<String, String>> loadArtistGroupData() {
		final List<Entry<String, String>> items = new LinkedList<>();
		items.add(new SimpleEntry<>("Einzelkünstler", "Einzelkünstler"));
		items.add(new SimpleEntry<>("Die Tümpler", "Comedy aus Wien"));
		items.add(new SimpleEntry<>("Linzer Dichtergruppe", "5 Dichter aus Linz"));

		return items;
	}

	private static List<Venue> loadVEnueData() {
		final List<String[]> data = readData(ROOT_LOCATION + VENUE_DATA);
		final List<Venue> entries = new LinkedList<>();

		for (String[] string : data) {
			entries.add(new Venue(string[0], string[1], string[2], string[3], string[5]));
		}

		return entries;
	}

	private static List<String[]> readData(final String fileName) {
		System.out.println("Loading '" + fileName + "'");
		URL fileUrl = getResourceURL(fileName);
		Objects.requireNonNull(fileUrl, "File could not be found");

		final List<String[]> items = new LinkedList<>();
		try (final BufferedReader br = new BufferedReader(
				new FileReader(new File(URLDecoder.decode(fileUrl.getFile(), "UTF-8"))))) {
			String line = null;
			while ((line = br.readLine()) != null) {
				if (!line.startsWith("--")) {
					items.add(line.replace("\'", "\\'").split(SEPARATOR));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return items;
	}

	private static URL getResourceURL(final String resourceName) {
		final URL url = TestDataGenerator.class.getClassLoader().getResource(resourceName);
		Objects.requireNonNull(url, "Resource not found. resource: " + resourceName);
		return url;
	}
}
