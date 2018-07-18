module WelcomeHelper
  def job_applied?(job_id)
    #return current_user.user_job.nil? ? false :current_user.user_job.try(:job_ids).include?(job_id)
    current_user.job_applications.map(&:job_id).include?(job_id)
  end

  def job_apply_link(search)
    unless current_user.client?
      unless job_applied?(search.id)
        link_to "Apply",{:controller => "user_jobs", :action => "create", :user_id => current_user.id , job_id: search.id }, id:"apply_#{search.id}",  class: "job-search not-applied",method: :post, remote: true
      else
        link_to "Applied" ,"#" ,class: 'job-search applied',style: "color: #C70039;"
      end
    end
  end
end
