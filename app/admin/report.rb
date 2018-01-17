ActiveAdmin.register_page "Report" do
  content title: "Reports", only: :candidate do
    render 'admin/reports/index'
  end

  breadcrumb do
    [


    ]
  end

  controller do
    def index

    end

    def get_data
      start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : 1.month.ago.to_date
      end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.today
      total_open_job_count = Job.where('created_at < ?', start_date).count
      total_closed_job_count = Job.where('status = ? and created_at < ?' ,0 ,start_date).count
      json = {open_jobs: [], closed_jobs: []}
      (start_date..end_date).each do |date|
        open_job_count = Job.where(created_at: date.beginning_of_day..date.end_of_day).count
        closed_job_count = Job.where(status: 1, closed_at: date.beginning_of_day..date.end_of_day).count
        total_closed_job_count += closed_job_count
        if date == start_date
          json[:open_jobs] << [date.strftime('%e %B %Y'), total_open_job_count]
        else
          json[:open_jobs] << [date.strftime('%e %B %Y'), open_job_count]
        end
        json[:closed_jobs] << [date.strftime('%e %B %Y'), total_closed_job_count]
      end

      render json: json
    end
  end


end