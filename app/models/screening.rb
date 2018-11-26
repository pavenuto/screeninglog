class Screening < ActiveRecord::Base
  belongs_to :film
  has_many :directors, through: :film

  validates_numericality_of :rating, :less_than_or_equal_to => 100, :greater_than_or_equal_to => 0

  def week
    self.date.strftime('%W')
  end

  def year
    self.date.strftime('%Y')
  end

  def rating_tier
    case self.rating.to_i
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
