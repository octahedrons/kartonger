class Box < ApplicationRecord
  def self.rooms
    %w[
      Hall
      Kök
      Vardagsrum
      Sovrum
      Badrum
      Klädkammare
      Balkong
      Källare
      Vind
    ]
  end

  def truncated_description
    if description.size > 50
      "#{description[..50]}..."
    else
      description
    end
  end
end
