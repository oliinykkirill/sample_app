require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  def setup
    @base_title = 'Ruby on Rails Tutorial Sample App'
  end

  test 'full test helper' do
    assert_equal full_title, @base_title #'Ruby on Rails Tutorial Sample App'
    assert_equal full_title('Help'), "Help | #{@base_title}"
  end
end
