# frozen_string_literal: true

require "capybara/rspec"
require "selenium-webdriver"

Capybara.add_selector(:test) do
  css { |name| "[data-test=\"#{name}\"]" }
end
