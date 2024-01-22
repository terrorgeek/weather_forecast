class InputValidator
  include ActiveModel::Validations

  attr_accessor :input

  validates :input, presence: true, format: { with: /\A^[a-zA-Z\s]+$\z/, message: 'Location cannot be null and must be English letters.' }

  def initialize(input:)
    self.input = input
  end
end