require 'test/unit'
require './Ask.rb'

class AskTest < Test::Unit::TestCase
    def test_ask_what_to_buy
        assert_false(Ask.ask_what_to_buy())
    end
end