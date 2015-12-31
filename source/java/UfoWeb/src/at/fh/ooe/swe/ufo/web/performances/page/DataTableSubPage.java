package at.fh.ooe.swe.ufo.web.performances.page;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Objects;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.stream.Collectors;

import javax.enterprise.context.Dependent;

import at.fh.ooe.swe.ufo.web.performances.model.TableColumnHeaderModel;
import at.fh.ooe.swe.ufo.webservice.model.PerformanceModel;

@Dependent
public class DataTableSubPage implements Serializable {

	private static final long serialVersionUID = -4489424237412049760L;

	private List<TableColumnHeaderModel> columnHeaders;
	private List<PerformanceModel> performances;

	public void init(final List<PerformanceModel> performances) {
		Objects.requireNonNull(performances, "DataTabelSubPage needs performances to be given");
		this.performances = performances;
		buildTableHeaderColumns();
	}

	private void buildTableHeaderColumns() {
		columnHeaders = new ArrayList<>();
		// Build times
		Calendar b = null;
		Calendar e = null;

		// Map to venues
		final Map<String, List<PerformanceModel>> map = performances.stream()
				.collect(Collectors.groupingBy(p -> p.getVenue()));
		// Sort performances by startDate
		map.entrySet().forEach(new Consumer<Entry<String, List<PerformanceModel>>>() {
			public void accept(Entry<String, List<PerformanceModel>> t) {
				t.getValue().stream().sorted(new Comparator<PerformanceModel>() {
					public int compare(PerformanceModel o1, PerformanceModel o2) {
						return o1.getStartDate().compareTo(o2.getStartDate());
					};
				});
			};
		});

		for (Entry<String, List<PerformanceModel>> entry : map.entrySet()) {
			PerformanceModel first = entry.getValue().get(0);
			PerformanceModel last = entry.getValue().get(entry.getValue().size() - 1);
			if ((b == null) || (b.compareTo(first.getStartDate()) > 0)) {
				b = first.getStartDate();
			}
			if ((e == null) || (e.compareTo(last.getEndDate()) < 0)) {
				e = last.getEndDate();
			}
		}

		while (b.compareTo(e) <= 0) {
			columnHeaders.add(new TableColumnHeaderModel(b, Locale.ENGLISH));
			b.add(Calendar.HOUR, 1);
		}
	}

	public List<TableColumnHeaderModel> getColumnHeaders() {
		return columnHeaders;
	}

}
