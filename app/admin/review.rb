include ActiveAdminHelper
ActiveAdmin.register Review do

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
permit_params :job_id ,:user_id ,:is_review, :review_count, :created_at, :updated_at ,:is_cv_download,:cv_download_date, :cv_ids 
	index do
	  selectable_column
	  column :job_id
	  column :user_id
	  column "Reviewed" , :is_review
	  column :review_count
	  column "CV Downloaded", :is_cv_download
	  column "CV Download Date",:cv_download_date
	  column "CV IDs", :cv_ids
	  column :created_at
	  column :updated_at
	  actions
	end

	form do |f|
    f.inputs "Review Details" do  	
      f.label :job_id, class: "select-role"
      f.select("job_id", Job.all.collect {|p| [ p.title, p.id ] }, {include_blank: 'None'})
      br
      f.label :user_id, class: "select-role"
      f.select("user_id", User.all.collect {|p| [ p.first_name, p.id ] }, {include_blank: 'None'})
      br
      f.input :review_count,:as => :number 
      f.input :is_review,:as => :check_boxes
      f.input :is_cv_download,:as => :check_boxes
      f.label :cv_ids, class: "select-role"
      f.select("cv_ids", Resume.all.collect {|p| [ p.title, p.id ] },{}, multiple: true)
    end
    f.button "Create Review"
  end

  controller do
		def create
			params[:review]["cv_ids"] = params[:review]["cv_ids"].reject{|k| k=="" }.map(&:to_i)
		  review = Review.new(params[:review].permit!)
      review.save
      redirect_to admin_review_path(review)
		end 

		def update
			review = Review.find(params[:id])
			params[:review]["cv_ids"] = params[:review]["cv_ids"].reject{|k| k=="" }.map(&:to_i)
		  review.update(params[:review].permit!)
      redirect_to admin_review_path(review)
		end
  end 

end

