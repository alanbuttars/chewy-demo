class Label < ActiveRecord::Base
  update_index('labels#label') { self }
  update_index('colleges') { colleges }

  has_and_belongs_to_many :colleges
end
