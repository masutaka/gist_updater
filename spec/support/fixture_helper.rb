# frozen_string_literal: true

module FixtureHelper
  def fixture(name)
    File.read(File.join(__dir__, '..', 'fixtures', name))
  end
end
