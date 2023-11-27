FactoryBot.define do
  factory :labelling do
    # Assuming labelling belongs to task and label models, and you have task_id and label_id columns in the labellings table
    association :task
    association :label
  end
end