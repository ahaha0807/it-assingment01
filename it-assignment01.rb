require './money_checker.rb'
require './stocker.rb'
require './drink.rb'
require './Ask.rb'

total = 0
isRepeat = true

# 自販機の初期化
stocker = Stocker.new
stocker.set_drink_lane("コーラ", 120, 5)

# お金の投入処理
while isRepeat do
    input = Ask.accept_money()
    total += input
    
    puts '合計' + total.to_s + '円投入されています。'
    isRepeat = Ask.ask_finish()
end

# 購入処理
item = Ask.ask_what_to_buy()
unless item
    puts '払い戻し操作が実行されました。'
    puts 'お釣りは、' + total.to_s + '円です。' 
    total -= total
end