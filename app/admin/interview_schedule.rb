include ActiveAdminHelper
ActiveAdmin.register InterviewSchedule do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  permit_params :stage,:interview_avail_dates,:interviewers_names ,:candidate_feedback,:client_comment,:user_id
  index do
	  selectable_column
	  column :interview_id
	  column :stage
	  column :interview_avail_dates do |p|
	  	p.interview_avail_dates.collect{|k,v| v}.join(", ")
	  end
	  column :interviewers_names do |p|
	  	p.interviewers_names.join(", ")
	  end
	  column :candidate_feedback
	  column :client_comment
	  column :user_id
	  column :created_at
	  column :updated_at
	  actions
	end

   
  form do |f|              
    render partial: 'form'                         
  end  

	# form do |f|
 #    f.inputs "Review Details" do
 #      f.label :interview_id, class: "select-role"
 #      f.select("interview_id", Interview.all.collect {|k| [ k.id, k.id ] }, {include_blank: 'None'})
 #      f.label :stage, class: "select-role"
 #      f.number_field :stage
 #      f.label :interview_avail_dates, class: "select-role"
 #      f.date_field :interview_avail_dates
 #      f.label :interviewers_names, class: "select-role"
 #      f.text_field :interviewers_names
 #      li "<div id='dates'></div>".html_safe
 #      # f.label :candidate_feedbacks, class: "select-role"
 #      # f.text_field :candidate_feedbacks
 #      # f.label :client_comments, class: "select-role"
 #      # f.text_field :client_comments
 #      f.label :user_id
 #      f.select("user_id", User.all.collect {|p| [ p.first_name, p.id ] }, {include_blank: 'None'})
 #    end
 #    f.button "Create Review"
 #  end

   controller do
		def create
			@date_hash = {}
			(1..params[:date_count].to_i).each do |val|
				@date_hash["interview_avail_date#{val}"] = params["interview_avail_date#{val}"] 
			end
			interview = Interview.find(params[:interview_id])
			schedule = interview.interview_schedules.new(
			stage: params[:stage],
			interview_avail_dates: @date_hash,
			interviewers_names: params[:interviewer_names].split(","), 
			user_id:  params[:user_id]
			)
		 schedule.save
		 redirect_to admin_interview_schedule_path(schedule)
		end

		def update
			@date_hash = {}
			(1..params[:date_count].to_i).each do |val|
				@date_hash["interview_avail_date#{val}"] = params["interview_avail_date#{val}"] 
			end
			schedule = InterviewSchedule.find params[:id]
			schedule.update(interviewers_names: params[:interviewer_names].split(","),interview_avail_dates: @date_hash)
		  redirect_to admin_interview_schedule_path(schedule)
		end
  end 


 
end
