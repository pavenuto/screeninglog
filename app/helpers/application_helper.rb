module ApplicationHelper

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def display_directors(film)
    film.directors.map{|d| link_to(d.try(:full_name), d, :class => "director-link")}.join(", ").html_safe
  end

  def letter_grade(rating)
    case rating
    when 91..100 then "A"
    when 82..90  then "A-"
    when 73..81  then "B+"
    when 64..72  then "B"
    when 55..63  then "B-"
    when 46..54  then "C+"
    when 37..45  then "C"
    when 28..36  then "C-"
    when 19..27  then "D+"
    when 10..18  then "D"
    when 1..9    then "D-"
    when 0       then "F"
    end
  end

  def star_rating(rating)
    case rating
    when 82..100 then "★★★★"
    when 73..81  then "★★★½"
    when 55..72  then "★★★"
    when 37..54  then "★★½"
    when 28..36  then "★★"
    when 19..27  then "★½"
    when 10..18  then "★"
    when 1..9    then "½"
    when 0       then "Zero Stars"
    end
  end


end
