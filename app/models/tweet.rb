class Tweet < ActiveRecord::Base
  validates_presence_of :content, :user
  belongs_to :user
end
