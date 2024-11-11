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

  def self.next_number
    order(number: :desc).pick(:number).to_i + 1
  end

  def truncated_description
    if description.size > 50
      "#{description[..50]}..."
    else
      description
    end
  end
end
