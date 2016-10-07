# frozen_string_literal: true

module FixtureHelper
  def fixture(name)
    File.read(File.join(File.dirname(__FILE__), '..', 'fixtures', name))
  end
end
