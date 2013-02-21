class Project < ActiveRecord::Base
  attr_accessible :description, :title, :total_time
end
