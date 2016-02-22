class Director < ActiveRecord::Base
  default_scope order('last_name ASC')
  has_and_belongs_to_many :films

  validates :last_name, :presence => true

  extend FriendlyId
  friendly_id :full_name, use: [:slugged, :history]

  def full_name
    [first_name, middle_name, last_name].reject{|i| i.empty?}.compact.join(" ")
  end

  def should_generate_new_friendly_id?
    last_name_changed?
    first_name_changed?
  end

end
