FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { '家事' }
    detail { '部屋の掃除' }
    status { '未着手' }
  end

  factory :second_task, class: Task do
    name { '筋トレ' }
    detail { '腕立て' }
    status { '未着手' }
  end

  
  
end