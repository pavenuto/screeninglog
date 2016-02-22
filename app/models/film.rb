class Film < ActiveRecord::Base
  has_and_belongs_to_many :directors
  has_many :screenings, :dependent => :destroy

  validates :title, :year, :presence => true
  validates_length_of :year, :within => 4..4

  has_attached_file :image,
                    :styles => {
                      :large => "600x400>",
                      :thumb => "300x196#"
                    },
                    :default_url => "/images/:style/missing.png"


  scope :find_by_year, ->(year) { where(:year => year) }
  scope :favorites, :include => :screenings, :conditions => ["screenings.rating > 59"]

  scope :ordered, lambda { |order| { :order => order || 'title ASC' }}


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

  def should_generate_new_friendly_id?
    title_changed?
  end

  def thumb_url
    image.url(:thumb)
  end

  def last_rating
    if screenings.size > 0
      screenings.sort{|a, b| b.date <=> a.date}.first.rating
    else
      0
    end
  end

  def recently_seen?
    if screenings.size > 0
      screenings.sort{|a, b| b.date <=> a.date}.first.date > 1.month.ago
    else
      false
    end
  end

  def self.top_100
    all_films = Film.find(:all, :include => [:screenings])
    all_films.sort do |a, b|
      if a.last_rating == b.last_rating
        b.title <=> a.title
      else
        a.last_rating <=> b.last_rating
      end
    end.reverse[0..199]
  end

  def self.worst
    all_films = Film.find(:all, :include => [:screenings])
    all_films.sort do |a, b|
      if a.last_rating == b.last_rating
        b.title <=> a.title
      else
        a.last_rating <=> b.last_rating
      end
    end[0..99]
  end

  def self.search(search)
    if search
      #find(:all, :conditions => ['title LIKE ?', "%#{search}%"])

      Film.all.where('lower(title) LIKE :q', {:q => "%#{search}%"})
    else
      find(:all)
    end
  end

  def decade
    case self.year.to_i
      when 2010..2019 then "2010s"
      when 2000..2009 then "2000s"
      when 1990..1999 then "1990s"
      when 1980..1989 then "1980s"
      when 1970..1979 then "1970s"
      when 1960..1969 then "1960s"
      when 1950..1959 then "1950s"
      when 1940..1949 then "1940s"
      when 1930..1939 then "1930s"
      when 1920..1929 then "1920s"
      when 1910..1919 then "1910s"
      when 1900..1909 then "1900s"
      when 1800..1899 then "1800s"
    end
  end

end
