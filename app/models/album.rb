class Album < ActiveRecord::Base
  validates :band_id, :name, :album_type, presence: true
  validates :album_type, inclusion: { in: %w(Studio Live) }

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
