class InputValidator
  include ActiveModel::Validations

  attr_accessor :input

  validates :input, presence: true

  def initialize(input:)
    self.input = input
  end
end