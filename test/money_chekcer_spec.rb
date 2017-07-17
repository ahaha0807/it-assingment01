require 'test/unit'
require './money_checker.rb'


class MoneyCheckerTest < Test::Unit::TestCase
    def test_to_harf_number
        # 半角数字を半角数字で返すか
        assert_equal(MoneyChecker.to_harf_number('0'), 0)
        assert_equal(MoneyChecker.to_harf_number('100'), 100)
        assert_equal(MoneyChecker.to_harf_number('10000'), 10000)
        assert_equal(MoneyChecker.to_harf_number('-1'), -1)
        # 全角数字を半角数字で返すか
        assert_equal(MoneyChecker.to_harf_number('０'), 0)
        assert_equal(MoneyChecker.to_harf_number('１００'), 100)
        assert_equal(MoneyChecker.to_harf_number('１００００'), 10000)
        # 数字以外をを半角"0"で返すか
        assert_equal(MoneyChecker.to_harf_number('abc'), 0)
        assert_equal(MoneyChecker.to_harf_number('ａｂｃ'), 0)
        assert_equal(MoneyChecker.to_harf_number('あいうえお'), 0)
        assert_equal(MoneyChecker.to_harf_number('試験'), 0)
    end
end