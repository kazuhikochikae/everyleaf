class Task < ApplicationRecord
  validates :name,:detail, presence: true
  enum rank: { high: 0, inter: 1, low: 2 }
  validates :status, inclusion: {in: ['未着手','着手中','完了']}
end
