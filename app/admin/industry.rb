include ActiveAdminHelper
ActiveAdmin.register Industry , as: "Job Categories" do
  
  permit_params :title, :descritption
  index :title => 'LIST OF JOB CATEGORIES'
  breadcrumb do
    []   
  end
  
  form do |f|
    f.inputs "Industry Details" do
      f.input :title
      f.input :descritption     
    end
    f.button "Create Industry"
  end 


end

