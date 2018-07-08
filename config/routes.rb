# == Route Map
#
#                                                 Prefix Verb     URI Pattern                                                       Controller#Action
#                                          reports_index GET      /reports/index(.:format)                                          reports#index
#                                 new_admin_user_session GET      /admin/login(.:format)                                            active_admin/devise/sessions#new
#                                     admin_user_session POST     /admin/login(.:format)                                            active_admin/devise/sessions#create
#                             destroy_admin_user_session GET      /admin/logout(.:format)                                           active_admin/devise/sessions#destroy
#                                    admin_user_password POST     /admin/password(.:format)                                         active_admin/devise/passwords#create
#                                new_admin_user_password GET      /admin/password/new(.:format)                                     active_admin/devise/passwords#new
#                               edit_admin_user_password GET      /admin/password/edit(.:format)                                    active_admin/devise/passwords#edit
#                                                        PATCH    /admin/password(.:format)                                         active_admin/devise/passwords#update
#                                                        PUT      /admin/password(.:format)                                         active_admin/devise/passwords#update
#                                             admin_root GET      /admin(.:format)                                                  admin/dashboard#index
#                             batch_action_admin_reviews POST     /admin/reviews/batch_action(.:format)                             admin/reviews#batch_action
#                                          admin_reviews GET      /admin/reviews(.:format)                                          admin/reviews#index
#                                                        POST     /admin/reviews(.:format)                                          admin/reviews#create
#                                       new_admin_review GET      /admin/reviews/new(.:format)                                      admin/reviews#new
#                                      edit_admin_review GET      /admin/reviews/:id/edit(.:format)                                 admin/reviews#edit
#                                           admin_review GET      /admin/reviews/:id(.:format)                                      admin/reviews#show
#                                                        PATCH    /admin/reviews/:id(.:format)                                      admin/reviews#update
#                                                        PUT      /admin/reviews/:id(.:format)                                      admin/reviews#update
#                                                        DELETE   /admin/reviews/:id(.:format)                                      admin/reviews#destroy
#                                        admin_candidate GET      /admin/candidate(.:format)                                        admin/candidate#index
#                          batch_action_admin_interviews POST     /admin/interviews/batch_action(.:format)                          admin/interviews#batch_action
#                                       admin_interviews GET      /admin/interviews(.:format)                                       admin/interviews#index
#                                                        POST     /admin/interviews(.:format)                                       admin/interviews#create
#                                    new_admin_interview GET      /admin/interviews/new(.:format)                                   admin/interviews#new
#                                   edit_admin_interview GET      /admin/interviews/:id/edit(.:format)                              admin/interviews#edit
#                                        admin_interview GET      /admin/interviews/:id(.:format)                                   admin/interviews#show
#                                                        PATCH    /admin/interviews/:id(.:format)                                   admin/interviews#update
#                                                        PUT      /admin/interviews/:id(.:format)                                   admin/interviews#update
#                                                        DELETE   /admin/interviews/:id(.:format)                                   admin/interviews#destroy
#                                        admin_dashboard GET      /admin/dashboard(.:format)                                        admin/dashboard#index
#                             batch_action_admin_resumes POST     /admin/resumes/batch_action(.:format)                             admin/resumes#batch_action
#                                          admin_resumes GET      /admin/resumes(.:format)                                          admin/resumes#index
#                                                        POST     /admin/resumes(.:format)                                          admin/resumes#create
#                                       new_admin_resume GET      /admin/resumes/new(.:format)                                      admin/resumes#new
#                                      edit_admin_resume GET      /admin/resumes/:id/edit(.:format)                                 admin/resumes#edit
#                                           admin_resume GET      /admin/resumes/:id(.:format)                                      admin/resumes#show
#                                                        PATCH    /admin/resumes/:id(.:format)                                      admin/resumes#update
#                                                        PUT      /admin/resumes/:id(.:format)                                      admin/resumes#update
#                                                        DELETE   /admin/resumes/:id(.:format)                                      admin/resumes#destroy
#                                           admin_client GET      /admin/client(.:format)                                           admin/client#index
#                                           admin_report GET      /admin/report(.:format)                                           admin/report#index
#                               batch_action_admin_users POST     /admin/users/batch_action(.:format)                               admin/users#batch_action
#                                            admin_users GET      /admin/users(.:format)                                            admin/users#index
#                                                        POST     /admin/users(.:format)                                            admin/users#create
#                                         new_admin_user GET      /admin/users/new(.:format)                                        admin/users#new
#                                        edit_admin_user GET      /admin/users/:id/edit(.:format)                                   admin/users#edit
#                                             admin_user GET      /admin/users/:id(.:format)                                        admin/users#show
#                                                        PATCH    /admin/users/:id(.:format)                                        admin/users#update
#                                                        PUT      /admin/users/:id(.:format)                                        admin/users#update
#                                                        DELETE   /admin/users/:id(.:format)                                        admin/users#destroy
#                      batch_action_admin_job_categories POST     /admin/job_categories/batch_action(.:format)                      admin/job_categories#batch_action
#                                   admin_job_categories GET      /admin/job_categories(.:format)                                   admin/job_categories#index
#                                                        POST     /admin/job_categories(.:format)                                   admin/job_categories#create
#                                 new_admin_job_category GET      /admin/job_categories/new(.:format)                               admin/job_categories#new
#                                edit_admin_job_category GET      /admin/job_categories/:id/edit(.:format)                          admin/job_categories#edit
#                                     admin_job_category GET      /admin/job_categories/:id(.:format)                               admin/job_categories#show
#                                                        PATCH    /admin/job_categories/:id(.:format)                               admin/job_categories#update
#                                                        PUT      /admin/job_categories/:id(.:format)                               admin/job_categories#update
#                                                        DELETE   /admin/job_categories/:id(.:format)                               admin/job_categories#destroy
#                         batch_action_admin_admin_users POST     /admin/admin_users/batch_action(.:format)                         admin/admin_users#batch_action
#                                      admin_admin_users GET      /admin/admin_users(.:format)                                      admin/admin_users#index
#                                                        POST     /admin/admin_users(.:format)                                      admin/admin_users#create
#                                   new_admin_admin_user GET      /admin/admin_users/new(.:format)                                  admin/admin_users#new
#                                  edit_admin_admin_user GET      /admin/admin_users/:id/edit(.:format)                             admin/admin_users#edit
#                                       admin_admin_user GET      /admin/admin_users/:id(.:format)                                  admin/admin_users#show
#                                                        PATCH    /admin/admin_users/:id(.:format)                                  admin/admin_users#update
#                                                        PUT      /admin/admin_users/:id(.:format)                                  admin/admin_users#update
#                                                        DELETE   /admin/admin_users/:id(.:format)                                  admin/admin_users#destroy
#                 batch_action_admin_interview_schedules POST     /admin/interview_schedules/batch_action(.:format)                 admin/interview_schedules#batch_action
#                              admin_interview_schedules GET      /admin/interview_schedules(.:format)                              admin/interview_schedules#index
#                                                        POST     /admin/interview_schedules(.:format)                              admin/interview_schedules#create
#                           new_admin_interview_schedule GET      /admin/interview_schedules/new(.:format)                          admin/interview_schedules#new
#                          edit_admin_interview_schedule GET      /admin/interview_schedules/:id/edit(.:format)                     admin/interview_schedules#edit
#                               admin_interview_schedule GET      /admin/interview_schedules/:id(.:format)                          admin/interview_schedules#show
#                                                        PATCH    /admin/interview_schedules/:id(.:format)                          admin/interview_schedules#update
#                                                        PUT      /admin/interview_schedules/:id(.:format)                          admin/interview_schedules#update
#                                                        DELETE   /admin/interview_schedules/:id(.:format)                          admin/interview_schedules#destroy
#                                batch_action_admin_jobs POST     /admin/jobs/batch_action(.:format)                                admin/jobs#batch_action
#                                             admin_jobs GET      /admin/jobs(.:format)                                             admin/jobs#index
#                                                        POST     /admin/jobs(.:format)                                             admin/jobs#create
#                                          new_admin_job GET      /admin/jobs/new(.:format)                                         admin/jobs#new
#                                         edit_admin_job GET      /admin/jobs/:id/edit(.:format)                                    admin/jobs#edit
#                                              admin_job GET      /admin/jobs/:id(.:format)                                         admin/jobs#show
#                                                        PATCH    /admin/jobs/:id(.:format)                                         admin/jobs#update
#                                                        PUT      /admin/jobs/:id(.:format)                                         admin/jobs#update
#                                                        DELETE   /admin/jobs/:id(.:format)                                         admin/jobs#destroy
#                                         admin_comments GET      /admin/comments(.:format)                                         admin/comments#index
#                                                        POST     /admin/comments(.:format)                                         admin/comments#create
#                                          admin_comment GET      /admin/comments/:id(.:format)                                     admin/comments#show
#                                                        DELETE   /admin/comments/:id(.:format)                                     admin/comments#destroy
#                                   admin_candidate_jobs GET      /admin/candidate/:id/jobs(.:format)                               admin/candidate#candidate_jobs
#                          admin_candidate_job_schedules GET      /admin/candidate/:candidate_id/job/:id/schedule(.:format)         admin/candidate#candidate_job_schedules
#                                      admin_client_jobs GET      /admin/client/:id/jobs(.:format)                                  admin/client#client_jobs
#                             admin_client_job_schedules GET      /admin/client/:client_id/job/:id/schedule(.:format)               admin/client#client_job_schedules
#                                  admin_resume_download GET      /admin/resumes/:id/download(.:format)                             admin/resumes#download
#                                          admin_reports GET      /admin/reports(.:format)                                          admin/report#index
#                                  admin_get_report_data GET      /admin/get_data(.:format)                                         admin/report#get_data
#                                        admin_close_job POST     /admin/jobs/close_job/:id(.:format)                               admin/jobs#close_job
#                                         admin_open_job POST     /admin/jobs/open_job/:id(.:format)                                admin/jobs#open_job
#                                        users_dashboard GET      /users/dashboard(.:format)                                        users#dashboard
#                                         client_reports GET      /reports(.:format)                                                reports#index
#                                       reports_get_data GET      /reports/get_data(.:format)                                       reports#get_data
#                                             jobs_index GET      /jobs/index(.:format)                                             jobs#index
#                                              close_job POST     /jobs/close_job/:id(.:format)                                     jobs#close_job
#                                               open_job POST     /jobs/open_job/:id(.:format)                                      jobs#open_job
#                                             accept_job POST     /jobs/accept_job/:id(.:format)                                    jobs#accept_job
#                                             reject_job POST     /jobs/reject_job/:id(.:format)                                    jobs#reject_job
#                                        download_resume GET      /resumes/:id/download(.:format)                                   resumes#download
#                                                resumes GET      /resumes(.:format)                                                resumes#index
#                                                        POST     /resumes(.:format)                                                resumes#create
#                                             new_resume GET      /resumes/new(.:format)                                            resumes#new
#                                            edit_resume GET      /resumes/:id/edit(.:format)                                       resumes#edit
#                                                 resume GET      /resumes/:id(.:format)                                            resumes#show
#                                                        PATCH    /resumes/:id(.:format)                                            resumes#update
#                                                        PUT      /resumes/:id(.:format)                                            resumes#update
#                                                        DELETE   /resumes/:id(.:format)                                            resumes#destroy
#                                         job_interviews POST     /jobs/:job_id/interviews(.:format)                                interviews#create
#                                      new_job_interview GET      /jobs/:job_id/interviews/new(.:format)                            interviews#new
#                                           download_job GET      /jobs/:id/download(.:format)                                      jobs#download
#                           remove_assign_job_assign_job POST     /jobs/:job_id/assign_jobs/:id/remove_assign(.:format)             assign_jobs#remove_assign
#                                        job_assign_jobs GET      /jobs/:job_id/assign_jobs(.:format)                               assign_jobs#index
#                                                        POST     /jobs/:job_id/assign_jobs(.:format)                               assign_jobs#create
#                                     new_job_assign_job GET      /jobs/:job_id/assign_jobs/new(.:format)                           assign_jobs#new
#                                    edit_job_assign_job GET      /jobs/:job_id/assign_jobs/:id/edit(.:format)                      assign_jobs#edit
#                                         job_assign_job GET      /jobs/:job_id/assign_jobs/:id(.:format)                           assign_jobs#show
#                                                        PATCH    /jobs/:job_id/assign_jobs/:id(.:format)                           assign_jobs#update
#                                                        PUT      /jobs/:job_id/assign_jobs/:id(.:format)                           assign_jobs#update
#                                                        DELETE   /jobs/:job_id/assign_jobs/:id(.:format)                           assign_jobs#destroy
#                                                   jobs GET      /jobs(.:format)                                                   jobs#index
#                                                        POST     /jobs(.:format)                                                   jobs#create
#                                                new_job GET      /jobs/new(.:format)                                               jobs#new
#                                               edit_job GET      /jobs/:id/edit(.:format)                                          jobs#edit
#                                                    job GET      /jobs/:id(.:format)                                               jobs#show
#                                                        PATCH    /jobs/:id(.:format)                                               jobs#update
#                                                        PUT      /jobs/:id(.:format)                                               jobs#update
#                                                        DELETE   /jobs/:id(.:format)                                               jobs#destroy
#                 candidate_feedback_interview_schedules POST     /interview_schedules/candidate_feedback(.:format)                 interview_schedules#candidate_feedback
#                     client_comment_interview_schedules POST     /interview_schedules/client_comment(.:format)                     interview_schedules#client_comment
#                          next_step_interview_schedules POST     /interview_schedules/next_step(.:format)                          interview_schedules#next_step
#                            meeting_interview_schedules POST     /interview_schedules/meeting(.:format)                            interview_schedules#meeting
#  populate_interview_schedule_popup_interview_schedules GET      /interview_schedules/populate_interview_schedule_popup(.:format)  interview_schedules#populate_interview_schedule_popup
# candidate_interview_schedule_popup_interview_schedules GET      /interview_schedules/candidate_interview_schedule_popup(.:format) interview_schedules#candidate_interview_schedule_popup
#                                    interview_schedules POST     /interview_schedules(.:format)                                    interview_schedules#create
#                                     interview_schedule GET      /interview_schedules/:id(.:format)                                interview_schedules#show
#                                                        DELETE   /interview_schedules/:id(.:format)                                interview_schedules#destroy
#                                        destroy_comment DELETE   /destroy_comment/:id(.:format)                                    interview_schedules#destroy_comment
#                                       destroy_feedback DELETE   /destroy_feedback/:id(.:format)                                   interview_schedules#destroy_feedback
#                                       new_user_session GET      /users/sign_in(.:format)                                          sessions#new
#                                           user_session POST     /users/sign_in(.:format)                                          sessions#create
#                                   destroy_user_session GET      /users/sign_out(.:format)                                         sessions#destroy
#                                          user_password POST     /users/password(.:format)                                         devise/passwords#create
#                                      new_user_password GET      /users/password/new(.:format)                                     devise/passwords#new
#                                     edit_user_password GET      /users/password/edit(.:format)                                    devise/passwords#edit
#                                                        PATCH    /users/password(.:format)                                         devise/passwords#update
#                                                        PUT      /users/password(.:format)                                         devise/passwords#update
#                               cancel_user_registration GET      /users/cancel(.:format)                                           registrations#cancel
#                                      user_registration POST     /users(.:format)                                                  registrations#create
#                                  new_user_registration GET      /users/sign_up(.:format)                                          registrations#new
#                                 edit_user_registration GET      /users/edit(.:format)                                             registrations#edit
#                                                        PATCH    /users(.:format)                                                  registrations#update
#                                                        PUT      /users(.:format)                                                  registrations#update
#                                                        DELETE   /users(.:format)                                                  registrations#destroy
#                                      user_profile_user GET      /users/:id/user_profile(.:format)                                 users#user_profile
#                                         user_user_jobs POST     /users/:user_id/user_jobs(.:format)                               user_jobs#create
#                                          welcome_index GET      /welcome/index(.:format)                                          welcome#index
#                                            how_it_work GET      /how_it_work(.:format)                                            welcome#how_it_work
#                                                  about GET      /about(.:format)                                                  welcome#about
#                                                privacy GET      /privacy(.:format)                                                welcome#privacy
#                                                contact GET      /contact(.:format)                                                welcome#contact
#                                         term_condition GET      /term_condition(.:format)                                         welcome#term_condition
#                                               platform GET      /platform(.:format)                                               welcome#platform
#                                         welcome_search POST     /welcome/search(.:format)                                         welcome#search
#                                                 search GET|POST /welcome/search(.:format)                                         welcome#search
#                                       search_candidate GET|POST /welcome/search_candidate(.:format)                               welcome#search_candidate
#                                                   root GET      /                                                                 welcome#index

Rails.application.routes.draw do
  get 'reports/index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  match "/admin/candidate/:id/jobs" => 'admin/candidate#candidate_jobs', via: :get, as: "admin_candidate_jobs"
  match "/admin/candidate/:candidate_id/job/:id/schedule" => 'admin/candidate#candidate_job_schedules', via: :get, as: "admin_candidate_job_schedules"


  match "/admin/client/:id/jobs" => 'admin/client#client_jobs', via: :get, as: "admin_client_jobs"
  match "/admin/client/:client_id/job/:id/schedule" => 'admin/client#client_job_schedules', via: :get, as: "admin_client_job_schedules"
  match "/admin/resumes/:id/download" => 'admin/resumes#download', via: :get, as: "admin_resume_download"
  match "/admin/reports" => 'admin/report#index', via: :get, as: "admin_reports"
  match "/admin/get_data" => 'admin/report#get_data', via: :get, as: "admin_get_report_data"
  match '/admin/jobs/close_job/:id' => 'admin/jobs#close_job', via: :post, as: :admin_close_job
  match '/admin/jobs/open_job/:id' => 'admin/jobs#open_job', via: :post, as: :admin_open_job


  # match "/admin/update_passwords" => 'admin/update_passwords#update', via: :post

  get 'users/dashboard'

  get 'reports' => 'reports#index', as: :client_reports
  get 'reports/get_data' => 'reports#get_data'

  get 'jobs/index'
  post 'jobs/close_job/:id' => 'jobs#close_job', as: :close_job
  post 'jobs/open_job/:id' => 'jobs#open_job', as: :open_job
  post 'jobs/accept_job/:id' => 'jobs#accept_job', as: :accept_job
  post 'jobs/reject_job/:id' => 'jobs#reject_job', as: :reject_job
  resources :resumes do
    member do
      get :download
    end
  end
  resources :jobs do
    resources :interviews, only: [:new,:create]
    member do
      get :download
    end
    resources :assign_jobs do
      member do
        post :remove_assign
      end
    end

  end
  resources :interview_schedules, only: [:create, :show, :destroy] do
    collection do
      post "candidate_feedback"
      post "client_comment"
      post "next_step"
      post "meeting"
      get "populate_interview_schedule_popup"
      get "candidate_interview_schedule_popup"
    end
  end
  delete '/destroy_comment/:id', :to => "interview_schedules#destroy_comment", :as => :destroy_comment
  delete '/destroy_feedback/:id', :to => "interview_schedules#destroy_feedback", :as => :destroy_feedback

  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}

  resources :users , only: [] do
    member do
      get "user_profile"
    end
    resources :user_jobs, only: :create
  end
  get 'welcome/index'
  get 'how_it_work',:to => "welcome#how_it_work", :as => :how_it_work
  get 'about',:to => "welcome#about", :as => :about
  get 'privacy',:to => "welcome#privacy", :as => :privacy
  get 'contact',:to => "welcome#contact", :as => :contact
  get 'term_condition',:to => "welcome#term_condition", :as => :term_condition
  get 'platform',  :to => 'welcome#platform', :as => :platform
  post 'welcome/search'
  match 'welcome/search', :to => "welcome#search", :as => :search, :via => [:get,:post]
  match 'welcome/search_candidate', :to => "welcome#search_candidate", :as => :search_candidate, :via => [:get,:post]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
end
