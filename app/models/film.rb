class Film < ActiveRecord::Base
  has_and_belongs_to_many :directors

  validates :title, :year, :presence => true
  validates_length_of :year, :within => 4..4

  has_attached_file :image,
                    :styles => { :large => "600x400>",
                                 :thumb => "300x196#" },
                    :default_url => "/images/:style/missing.png"


  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :title,
      [:title, :year],
    ]
  end

  scope :find_by_year, ->(year) { where(:year => year)}
end
