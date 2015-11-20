package at.fh.ooe.ufo.data.generator;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.net.URL;
import java.util.AbstractMap.SimpleEntry;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Objects;
import java.util.Random;

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

	private static final String SEPARATOR = ";";

	public static class Venue {
		private final String name;
		private final String street;
		private final String zip;
		private final String city;
		private final String countryCode;
		private final String gps;

		public Venue(String name, String street, String zip, String city, String countryCode, String gps) {
			super();
			this.name = name;
			this.street = street;
			this.zip = zip;
			this.city = city;
			this.countryCode = countryCode;
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

		public String getCountryCode() {
			return countryCode;
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
		private final byte[] image;
		private final String imageFileType;
		private int artistCategoryId;
		private int artistGroupId;

		private List<Venue> venues = new LinkedList<>();

		private final Random random = new Random();

		public Artist(String name, String email, String countryCode, byte[] image, String imageFileType) {
			super();
			this.email = email;
			this.countryCode = countryCode;
			this.image = image;
			this.imageFileType = imageFileType;
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
			return (image == null) ? null : ("'X" + image.toString() + "'");
		}

		public String getImageFileType() {
			return imageFileType;
		}

		public String getNullString() {
			return "NULL";
		}

		public void addVenue(Venue venue) {
			venues.add(venue);
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
		parameters.put("maxArtistCategories", categories.size());
		parameters.put("maxArtistGroups", artistGroups.size());
		parameters.put("categories", categories);
		parameters.put("countries", countries);
		parameters.put("artistCategories", artistCategroies);
		parameters.put("artistGroups", artistGroups);
		parameters.put("artists", artists);
		parameters.put("venues", venues);

		URL fileUrl = TestDataGenerator.class.getClassLoader().getResource(ROOT_FTL_TEMPLATE);
		Objects.requireNonNull(fileUrl, "File could not be found");

		final Configuration config = new Configuration();
		config.setClassLoaderForTemplateLoading(TestDataGenerator.class.getClassLoader(), "");

		final Template template = config.getTemplate(ROOT_FTL_TEMPLATE + FTL_TEMPLATE);
		template.setAutoFlush(true);

		try (final BufferedWriter br = new BufferedWriter(new FileWriter(new File("C:/test.sql")))) {
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
			entries.add(new Artist(string[0], string[1], string[2], null, null));
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
			entries.add(new Venue(string[0], string[1], string[2], string[3], string[4], string[5]));
		}

		return entries;
	}

	private static List<String[]> readData(final String fileName) {
		System.out.println("Loading '" + fileName + "'");
		URL fileUrl = TestDataGenerator.class.getClassLoader().getResource(fileName);
		Objects.requireNonNull(fileUrl, "File could not be found");

		final List<String[]> items = new LinkedList<>();
		try (final BufferedReader br = new BufferedReader(new FileReader(new File(fileUrl.getPath())))) {
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
}
