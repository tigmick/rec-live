module WelcomeHelper
	def job_applied?(job_id)
    return current_user.user_job.nil? ? false :current_user.user_job.try(:job_ids).include?(job_id)
  end

  def job_apply_link(search)
  	unless current_user.client?
			unless job_applied?(search.id)
			  link_to "Apply",{:controller => "user_jobs", :action => "create", :user_id => current_user.id , job_id: search.id }, id:"apply_#{search.id}",  class: "search_btn btn btn-primary",method: :post, remote: true 
		  else
		  	link_to "Applied" ,"#" ,class: 'btn btn-danger'
		  end
		end
	end
end
