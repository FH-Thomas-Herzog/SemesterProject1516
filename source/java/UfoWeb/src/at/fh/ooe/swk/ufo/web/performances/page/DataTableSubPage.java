package at.fh.ooe.swk.ufo.web.performances.page;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import javax.enterprise.context.Dependent;
import javax.inject.Inject;

import at.fh.ooe.swk.ufo.web.application.bean.LanguageBean;
import at.fh.ooe.swk.ufo.web.performances.model.IdLabelModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceColumnModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceRowModel;
import at.fh.ooe.swk.ufo.web.performances.model.PerformanceViewModel;

@Dependent
public class DataTableSubPage implements Serializable {

	private static final long serialVersionUID = -4489424237412049760L;

	@Inject
	private LanguageBean languageBean;

	private String header;
	private List<PerformanceColumnModel> columns;
	private List<PerformanceRowModel> rows;
	private List<PerformanceViewModel> performances;

	public void init(final String header, final List<PerformanceViewModel> performances) {
		Objects.requireNonNull(performances, "DataTabelSubPage needs performances to be given");
		this.header = header;
		this.performances = performances;
		buildColumns();
		buildRows();
	}

	private void buildColumns() {
		columns = new ArrayList<>();
		if (!performances.isEmpty()) {
			// Build times
			Calendar b = performances.get(0).getStartDate();
			Calendar e = performances.get(performances.size() - 1).getStartDate();

			while (b.compareTo(e) <= 0) {
				Calendar tmp = (Calendar) b.clone();
				columns.add(new PerformanceColumnModel(tmp, languageBean.getLocale()));
				b.add(Calendar.HOUR, 1);
			}
		}
	}

	private void buildRows() {
		rows = new ArrayList<>();
		if (!performances.isEmpty()) {
			Map<IdLabelModel, List<PerformanceViewModel>> map = performances.parallelStream()
					.collect(Collectors.groupingBy(i -> new IdLabelModel(i.getVenueId(), i.getVenueName())));
			rows = map.entrySet().parallelStream()
					.map(p -> new PerformanceRowModel(p.getKey(),
							(Map<Calendar, List<PerformanceViewModel>>) p.getValue().parallelStream()
									.collect(Collectors.groupingBy(model -> model.getStartDate()))))
					.collect(Collectors.toList());
		}
	}

	// ##################################################
	// Getter and Setter
	// ##################################################
	public String getHeader() {
		return header;
	}

	public List<PerformanceColumnModel> getColumns() {
		return columns;
	}

	public List<PerformanceRowModel> getRows() {
		return rows;
	}

}
