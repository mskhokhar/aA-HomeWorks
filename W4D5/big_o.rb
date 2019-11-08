def biggest_fish(arr)
    biggest = nil
    arr.each do |fish_1, idx1|
        arr.each do |fish_2, idx2|
            biggest = (fish_1.length>fish_2.length ? fish_1 : fish_2) if idx2 > idx1
        end
    end
    biggest
    
end

def clever_octupus(arr)
    biggest = arr[0]
    arr.drop(1).each do |fish|
        biggest = fish if fish.length > biggest.length
    end
    biggest
    
end

def slow_dance(str,arr)
    arr.each.with_index do |ele, idx|
        return idx if ele == str
    end
end

def fast_dance(str, new_tiles_data_structure)
    new_tiles_data_structure.index(str)
end