include ActiveAdminHelper
ActiveAdmin.register Job do

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
  batch_action :destroy do |ids|
    redirect_to collection_path, alert: "Didn't really delete these!"
  end

  permit_params :title, :description,:industry_id
  index do
    selectable_column
    column :title
    #column :description
    column :status do |job|
      job.status_string
    end
    column "description" do |job|
          truncate(job.description, omision: "...", length: 100)
        end
    column :industry_id
    column :actions do |job|
      links = []
      if job.open?
        links << link_to('Close Job', admin_close_job_path(job), method: :post, confirm: 'Are you sure?')
      else
        links << link_to('Open Job', admin_open_job_path(job), method: :post)
      end
      links.join(' ').html_safe
    end
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :title
      f.input :description
      f.label :industry_id, class: "select-role"
      f.select("industry_id", Industry.all.collect {|p| [ p.title, p.id ] }, {include_blank: 'None'})
      
    end
    f.actions
  end


  controller do
    def close_job
      job = Job.find(params[:id])
      job.update status: 1, closed_at: Time.now
      redirect_to '/admin/jobs'
    end

    def open_job
      job = Job.find(params[:id])
      job.update status: 0, closed_at: nil
      redirect_to '/admin/jobs'
    end
  end

end
