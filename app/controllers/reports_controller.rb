class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def index
    render layout: 'new_ui/application'
  end

  def get_data
    start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : 1.month.ago.to_date
    end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.today
    json = get_chart_data(start_date, end_date)

    render json: json
  end

  private

  def get_chart_data(start_date, end_date)
    json = {
        cummulative_data: {open_jobs: [], closed_jobs: []}, pie_data: {}, line_chart_data: {open_jobs: [], closed_jobs: []}, bar_chart_data: {open_jobs: [], closed_jobs: [], dates: []}
    }
    (start_date..end_date).each do |date|
      cummulative_data = get_cummulative_data(date)
      json[:cummulative_data][:open_jobs] << cummulative_data[0]
      json[:cummulative_data][:closed_jobs] << cummulative_data[1]
      line_chart_data = get_line_chart_data(date)
      json[:line_chart_data][:open_jobs] << line_chart_data[0]
      json[:line_chart_data][:closed_jobs] << line_chart_data[1]
      bar_chart_data = get_bar_chart_data(date)
      json[:bar_chart_data][:dates] << date.strftime('%e %B %Y')
      json[:bar_chart_data][:open_jobs] << bar_chart_data[0]
      json[:bar_chart_data][:closed_jobs] << bar_chart_data[1]
    end
    json[:pie_data] = get_pie_data
    json
  end

  def get_cummulative_data(date)
    open_job_count = current_user.jobs.where('created_at < ?', date.end_of_day).count
    closed_job_count = current_user.jobs.where('status = ? and closed_at <= ?' ,1 ,date.end_of_day).count
    [[date.strftime('%e %B %Y'), open_job_count], [date.strftime('%e %B %Y'), closed_job_count]]
  end

  def get_pie_data
    open_jobs = current_user.jobs.where(status: 0).count
    closed_jobs = current_user.jobs.where(status: 1).count
    {open_jobs: open_jobs, closed_jobs: closed_jobs}
  end

  def get_line_chart_data(date)
    open_job_count = current_user.jobs.where(created_at: date.beginning_of_day..date.end_of_day).count
    closed_job_count = current_user.jobs.where(status: 1, closed_at: date.beginning_of_day..date.end_of_day).count
    [[date.strftime('%e %B %Y'), open_job_count], [date.strftime('%e %B %Y'), closed_job_count]]
  end

  def get_bar_chart_data(date)
    open_job_count = current_user.jobs.where(created_at: date.beginning_of_day..date.end_of_day).count
    closed_job_count = current_user.jobs.where(status: 1, closed_at: date.beginning_of_day..date.end_of_day).count
    [open_job_count, closed_job_count]
  end
end
