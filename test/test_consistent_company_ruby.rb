require 'minitest/autorun'
require 'consistent_company_ruby'

class ConsistentCompanyRubyTest < Minitest::Test
  def test_transform_company
    assert_equal "1", ConsistentCompanyRuby.transform_company(" ONE ")
  end
end
