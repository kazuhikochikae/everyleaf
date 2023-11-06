class Task < ApplicationRecord
  validates :name,:detail, presence: true

  enum rank: { high: 0, inter: 1, low: 2 }
  validates :status, inclusion: {in: ['未着手','着手中','完了']}

  # ユーザー名による絞り込み
scope :get_by_name, ->(name) {
  where("name like ?", "%#{name}%")
  }
  # 性別による絞り込み
  scope :get_by_status, ->(status) {
  where(status: status)
  }

end
