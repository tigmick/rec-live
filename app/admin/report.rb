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
      json = {open_jobs: [], closed_jobs: []}
      (start_date..end_date).each do |date|
        open_job_count = Job.where('created_at < ?', date.end_of_day).count
        closed_job_count = Job.where('status = ? and closed_at <= ?' ,1 ,date.end_of_day).count
        json[:open_jobs] << [date.strftime('%e %B %Y'), open_job_count]
        json[:closed_jobs] << [date.strftime('%e %B %Y'), closed_job_count]
      end

      render json: json
    end
  end


end