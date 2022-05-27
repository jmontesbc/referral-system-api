class Permission < ApplicationRecord
  belongs_to :user
  belongs_to :view
  belongs_to :action
end
