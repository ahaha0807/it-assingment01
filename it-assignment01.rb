def to_harf_number(input)
    input.tr('０-９', '0-9').to_i
end

total = 0

puts 'お金を投入してください'
input_money = gets.chomp!
input_money = to_harf_number(input_money)

until input_money > 0 do
    puts '1以上の整数値を入力してください'
    input_money = gets.chomp!
    input_money = to_harf_number(input_money)
end

puts input_money.to_s + '円投入されました'
total += input_money

puts '合計' + total.to_s + '円投入されています。'