class Employee < ActiveRecord::Base
  update_index('employees#employee') { self }
  update_index('colleges') { college }

  belongs_to :college
end
