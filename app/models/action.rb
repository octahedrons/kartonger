class Action < ApplicationRecord
  belongs_to :box

  def self.actions
    {
      unpack => "packades upp",
    }
  end

  def self.unpack
    "unpack"
  end

  def in_swedish
    self.class.actions[name]
  end
end
