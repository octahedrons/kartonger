class Box < ApplicationRecord
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
