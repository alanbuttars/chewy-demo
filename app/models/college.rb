class College < ActiveRecord::Base
  update_index('colleges#college') { self }
  update_index('labels') { labels }
  update_index('employees') { employees }

  has_and_belongs_to_many :labels
  has_many :employees
end
