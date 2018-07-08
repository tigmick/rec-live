module ReportsHelper
  def calculate_average_time(jobs)
    counter = 0
    days = []
    jobs.each do |job|
      user_jobs = job.user_jobs.where.not(accepted: nil)
      user_jobs.each do |user_job|
        days << (user_job.accepted_at - user_job.created_at.to_date )
        counter = counter + 1
      end
    end
    return days.inject(0){|sum,x| sum + x }.to_i/counter
  end
  
  def rejected_jobs(jobs)
    rejected_jobs = 0
    jobs.each do |job|
      rejected_jobs = rejected_jobs + job.user_jobs.where(rejected: true).count 
    end
    return rejected_jobs
  end
end
