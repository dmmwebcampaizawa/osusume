class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog,optional: true
end
