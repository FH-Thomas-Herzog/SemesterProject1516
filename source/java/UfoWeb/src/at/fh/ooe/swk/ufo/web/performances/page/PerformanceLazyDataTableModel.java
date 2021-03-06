package at.fh.ooe.swk.ufo.web.performances.page;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import javax.enterprise.context.Dependent;
import javax.inject.Inject;

import org.primefaces.model.LazyDataModel;
import org.primefaces.model.SortOrder;

import at.fh.ooe.swk.ufo.web.application.bean.LanguageBean;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceColumnModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceLazySorter;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceRowModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;
import at.fh.ooe.swk.ufo.web.performances.model.VenueViewModel;

/**
 * This class represents the lazy data model for performance models.
 * 
 * @author Thomas Herzog <s1310307011@students.fh-hagenberg.at>
 * @date Jan 7, 2016
 */
@Dependent
public class PerformanceLazyDataTableModel extends LazyDataModel<PerformanceRowModel> {

	private static final long serialVersionUID = -4489424237412049760L;

	@Inject
	private LanguageBean languageBean;

	private int dataCount = 0;
	private Calendar date;
	private List<PerformanceColumnModel> columns;
	private List<PerformanceRowModel> rows;
	private List<PerformanceViewModel> performances;
	private Set<Integer> performancestartHours;

	/**
	 * Initializes this data model.
	 * 
	 * @param performances
	 *            the list of performances
	 * @param date
	 *            the table date
	 * 
	 * @throws NullPointerException
	 *             if performances are null
	 * @throws IllegalArgumentException
	 *             if performances list is empty
	 */
	public void init(final Calendar header, final List<PerformanceViewModel> performances) {
		Objects.requireNonNull(performances, "DataTabelSubPage needs performances to be given");
		this.performances = performances;
		if (performances.isEmpty()) {
			throw new IllegalArgumentException("Performances must not be empty");
		}
		this.dataCount = performances.size();
		this.date = header;
		buildRows();
		buildColumns(performances.get(0).getStartDate().get(Calendar.HOUR_OF_DAY),
				performances.get(performances.size() - 1).getStartDate().get(Calendar.HOUR_OF_DAY));
	}

	// ##################################################
	// LazyDataModel methods
	// ##################################################
	@Override
	public List<PerformanceRowModel> load(int first, int pageSize, String sortField, SortOrder sortOrder,
			Map<String, Object> filters) {
		// Copy all rows to work on
		List<PerformanceRowModel> data = new ArrayList<>(rows.size());

		// Apply filters
		if (!filters.isEmpty()) {
			for (PerformanceRowModel row : rows) {
				if (row.containsFilteredValue(filters, columns)) {
					data.add(row);
				}
			}
		} else {
			data.addAll(rows);
		}

		// Apply sorters
		if ((!SortOrder.UNSORTED.equals(sortOrder)) && (sortField != null) && (!sortField.isEmpty())) {
			Integer startHour = null;
			try {
				startHour = columns.get(Integer.valueOf(sortField)).getStartHour();
			} catch (NumberFormatException e) {
			}
			data.sort(new PerformanceLazySorter(startHour,
					(SortOrder.ASCENDING.equals(sortOrder)) ? Boolean.TRUE : Boolean.FALSE));
		}

		// Filter for current page
		final int endIdx = ((first + pageSize) <= data.size()) ? (first + pageSize) : data.size();
		data = data.subList(first, endIdx);
		setRowCount(data.size());

		return data;
	}

	// ##################################################
	// Helper
	// ##################################################
	/**
	 * Builds the rows where each row holds the related venue and a map of
	 * performances mapped to their start hour. The resulting rows filter the
	 * columns later on.
	 */
	private void buildRows() {
		rows = new ArrayList<>();
		performancestartHours = new HashSet<>();

		// Map to venues
		Map<VenueViewModel, List<PerformanceViewModel>> map = performances.parallelStream()
				.collect(Collectors.groupingBy(i -> i.getVenue()));

		// Build row model where each model holds value for dynamic columns
		// mapped to their start hour
		rows = map.entrySet().parallelStream().map(entry -> {
			final Map<Integer, List<PerformanceViewModel>> performanceMap = entry.getValue().parallelStream()
					.collect(Collectors.groupingBy(model -> {
				final int hour = model.getStartDate().get(Calendar.HOUR_OF_DAY);
				// remember start hour for filtering columns
				performancestartHours.add(hour);
				return hour;
			}));
			return new PerformanceRowModel(entry.getKey(), performanceMap);
		}).collect(Collectors.toList());
	}

	/**
	 * Builds the columns depending on the resulted rows. Means no column will
	 * be added where at least one performance occurs.
	 * 
	 * @param firstStartHour
	 *            the first start hour
	 * @param lastStartHour
	 *            the last start hour
	 */
	private void buildColumns(int firstStartHour, int lastStartHour) {
		columns = new ArrayList<>();
		while (firstStartHour <= lastStartHour) {
			// exclude columns with no entries over all rows
			if (performancestartHours.contains(firstStartHour)) {
				columns.add(new PerformanceColumnModel(firstStartHour));
			}
			firstStartHour++;
		}
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public Calendar getDate() {
		return date;
	}

	public String getLocalizedDate() {
		return DateFormat.getDateInstance(DateFormat.MEDIUM, languageBean.getLocale()).format(date.getTime());
	}

	public List<PerformanceColumnModel> getColumns() {
		return columns;
	}

	public List<PerformanceViewModel> getPerformances() {
		return performances;
	}

	public long getDataCount() {
		return dataCount;
	}
}
