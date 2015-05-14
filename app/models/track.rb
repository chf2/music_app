class Track < ActiveRecord::Base
  validates :album_id, :track_type, :name, presence: true
  validates :track_type, inclusion: { in: %w(Bonus Regular) }

  has_many :notes, dependent: :destroy

  belongs_to :album
  has_one :band, through: :album, source: :band
end
