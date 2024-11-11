class Box < ApplicationRecord
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

  def self.csv_header
    column_names.to_csv
  end

  def self.next_number
    order(number: :desc).pick(:number).to_i + 1
  end

  def truncated_description
    if description&.size.to_i > 50
      "#{description[..50]}..."
    else
      description
    end
  end

  def to_csv
    Box.column_names.flat_map { values_at _1 }.to_csv
  end
end
