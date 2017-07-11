def to_harf_number(input)
    input.tr('０-９', '0-9').to_i
end

def accept_money
    puts 'お金を投入してください'
    input_money = gets.chomp!
    input_money = to_harf_number(input_money)
    while input_money.zero? do
        puts '1以上の整数値を入力してください'
        input_money = gets.chomp!
        input_money = to_harf_number(input_money)
    end

    puts input_money.to_s + '円投入されました'
    return input_money
end

def ask_finish
    puts 'お金をまだ入れますか？ (はい/いいえ)'
    answer = gets.chomp!.to_s
    if answer == 'はい' || answer.downcase == 'yes'
        return true
    elsif answer == 'いいえ' || answer.downcase == 'no'
        return false
    else
        ask_finish()
    end
end

def ask_what_to_buy
    selected = '払い戻し'
    puts selected.to_s + 'と入力しました'
    return false
end

total = 0
isRepeat = true

# お金の投入処理
while isRepeat do
    input = accept_money()
    total += input
    
    puts '合計' + total.to_s + '円投入されています。'
    isRepeat = ask_finish()
end

# 購入処理
item = ask_what_to_buy()
unless item
    puts '払い戻し操作が実行されました。'
    puts 'お釣りは、' + total.to_s + '円です。' 
    total -= total
end