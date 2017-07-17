class Stocker
    @@Lanes = Array.new()

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
end