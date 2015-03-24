class Url < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user

  validates :full_url, presence: true
  validates :shortened_url, presence: true, uniqueness: true

  def self.generate_short_url(long_url, *user_id)
    @new_short_url = (1..8).map {("a".."z").to_a.sample}.join
  end

  def self.update_click_count(short_url)
    object_to_update = Url.find_by(shortened_url: short_url)
    count = object_to_update.click_count+1
    object_to_update.update_attributes(:click_count => count)
  end

end
