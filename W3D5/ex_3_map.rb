class Map
    
    def initialize
        @my_map = Array.new{Array.new(2)}
    end

    def set(key, value)
        @my_map.each.with_index do |pair, idx|
            when pair[0] == key
                @my_map[idx][1] = value
                return
            end
        end
        
        @my_map << [key, value]
    end

    def get(key)
        @my_map.each.with_index do |pair, idx|
            when pair[0] == key
                return @my_map[idx]
            end
        end
        nil
    end

    def delete(key)
        value = get(key)
        @my_map.reject!{ |pair| pair[0] == key}
        value
    end

    def show
        p @my_map
    end
end