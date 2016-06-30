# == Schema Information
#
# Table name: shortened_urls
#
#  id        :integer          not null, primary key
#  long_url  :string           not null
#  short_url :string           not null
#  user_id   :integer          not null
#

class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :short_url, :user_id, presence: true
  validates :short_url, uniqueness: true

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :short_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    through: :visits,
    source: :visitor
  )

  has_many(
    :unique_visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )

  def self.random_code
    short = SecureRandom::urlsafe_base64
    while ShortenedUrl.exists?(short_url: short)
      short = SecureRandom::urlsafe_base64
    end
    short
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(user_id: user.id, short_url: ShortenedUrl.random_code, long_url: long_url)
  end

  def num_clicks
    visitors.select(:user_id).count
  end

  def num_uniques
    unique_visitors.select(:user_id).count
  end

  def num_recent_uniques(num_minutes_ago)
    visitors.select(:user_id).distinct.count.where("Visit.updated_at >= num_minutes_ago.minutes.ago")
  end
end
