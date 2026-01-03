class Box < ApplicationRecord
  has_many :actions, dependent: :delete_all
  has_many :box_files, dependent: :destroy

  validates :room, comparison: { other_than: "Välj..." }

  def self.rooms
    %w[
      Badrum
      Balkong
      Gästrum
      Hall
      Klädkammare
      Kontor
      Källare
      Kök
      Sovrum
      Vardagsrum
      Vind
    ]
  end

  def self.room_options
    ["Välj..."] + rooms
  end

  def self.csv_header
    column_names.to_csv
  end

  def self.next_number
    order(number: :desc).pick(:number).to_i + 1
  end

  def self.count_by(key, value)
    Box.where(key => value).count
  end

  def unpack(user: "")
    Action.create(name: Action.unpack, box: self, user:)
  end

  def unpack_action
    actions.find { |action| action.name == Action.unpack }
  end

  def unpacked?
    actions.any? { |action| action.name == Action.unpack }
  end

  def truncated_description
    max_size = 32
    if description&.size.to_i > max_size
      "#{description[..max_size]} ..."
    else
      description
    end
  end

  def to_csv
    Box.column_names.flat_map { values_at _1 }.to_csv
  end
end
