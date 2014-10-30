# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  band_id    :integer          not null
#  setting    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
  RECORDING_SETTINGS = [
    "STUDIO",
    "LIVE"
  ]
  validates :name, :band_id, :setting, presence: true
  validates_uniqueness_of :name, scope: :band_id
  validates :setting, inclusion: RECORDING_SETTINGS

  belongs_to(
    :band,
    class_name: "Band",
    foreign_key: :band_id,
    primary_key: :id
  )

  has_many(
    :tracks,
    class_name: "Track",
    foreign_key: :album_id,
    primary_key: :id,
    dependent: :destroy
  )
end
