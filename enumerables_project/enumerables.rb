require "byebug"
class Array
    def my_each(&blk)
        i = 0

        while i < self.length
            blk.call(self[i])
            i += 1
        end
        self
    end

    def my_select (&blk)
        new_arr = []

        self.my_each do |num|
            new_arr << num if blk.call(num)
        end

        return new_arr
    end

    def my_reject (&blk)
        new_arr = []

        self.my_each do |num|
            new_arr << num if !blk.call(num)
        end
        return new_arr
    end

    def my_any?(&blk)
        self.my_each do |num|
            return true if blk.call(num)
        end
        return false
    end

    def my_all?(&blk)
        self.my_each do |num|
            return false if !blk.call(num)
        end
        return true
    end
    
end

# return_value = [1, 2, 3].my_each do |num|
#  puts num
# end.my_each do |num|
#  puts num
# end

# p return_value

a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true