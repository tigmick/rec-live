namespace :generate do
  desc "TODO"
  task app: :interview_schedules do
    Job.all.each do |job|
      if job.interview.interview_schedules.count == 0
        job.interview.update_attribute(:total_stage, 0)
        InterviewSchedule.create(stage: 0,interview_id: job.interview.id,user_id: job.user_id)
      end
    end
  end
end
