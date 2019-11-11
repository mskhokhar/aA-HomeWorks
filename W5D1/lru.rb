class LRUCache
    def initialize(num)
        @cache = []
        @length_cache = num
    end

    def count
      # returns number of elements currently in cache
      @cache.length
    end

    def add(el)
      # adds element to @cache according to LRU principle
        if @cache.empty?
            @cache << el
        elsif @cache.length < length_cache
            if @cache.include?(el)
                @cache.delete_at(@cache.index(el))
                @cache << el
            else
                @cache << el
            end
        else
            @cache.shift
            @cache << el
        end
      
    end

    def show
      # shows the items in the cache, with the LRU item first
      @cache
    end

    private
    attr_accessor :cache, :length_cache

  end