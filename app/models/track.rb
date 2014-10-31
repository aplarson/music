# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  album_id   :integer          not null
#  lyrics     :text
#  variety    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
  TRACK_VARIETIES = [
    "REGULAR",
    "BONUS"
  ]

  validates :name, :album_id, :variety, presence: true
  validates_uniqueness_of :name, scope: :album_id
  validates :variety, inclusion: TRACK_VARIETIES

  belongs_to(
    :album,
    class_name: "Album",
    foreign_key: :album_id,
    primary_key: :id
  )

  has_one(
    :band,
    through: :album,
    source: :band
  )

  has_many(
    :notes,
    class_name: "Note",
    foreign_key: :track_id,
    primary_key: :id,
    dependent: :destroy
  )
end
