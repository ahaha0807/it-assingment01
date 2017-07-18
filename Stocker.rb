class Stocker
    @@Lanes = Array.new()
    @@Proceeds = 0

    def get_drink_stock_count(drink_name)
        target_lane = @@Lanes.find {|item| item.get_name == drink_name}
        target_lane.get_stock
    end

    def set_drink_lane(name, price, initial_stock)
        @@Lanes.push(Drink.new(name, price, initial_stock))
    end

    def self.display_lanes
        puts ''
        @@Lanes.each.with_index {|item, index|
            puts 'Lane-' + index.to_s
            puts item.get_data()
        }
    end

    def self.display_commodities
        puts '【商品リスト】'
        @@Lanes.each.with_index {|item, index|
        puts '- 番号: '+ index.to_s + ' 商品名 : ' + item.get_name.to_s + ' 価格 : ' + item.get_price.to_s
    }
    end

    def find(item_id)
        return @@Lanes.find { |item|
            item.get_name.to_s == item_id
        }
    end

    def buy_selected_item(item)
        item.set_stock(item.get_stock - 1)
        self.add_proceeds(item.get_price)
    end

    def add_proceeds(item_price)
        @@Proceeds += item_price
    end
end