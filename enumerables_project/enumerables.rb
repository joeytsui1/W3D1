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

    def my_flatten
        new_arr = []

        self.each do |ele|
            if ele.is_a?(Array)
                new_arr += ele.my_flatten
            else
                new_arr << ele
            end
        end
        return new_arr
    end
    
    def my_zip(*arrs)
        new_arr = []

        (0...self.length).each do |i|
            sub_arr = [self[i]]
            arrs.each do |ele|
                sub_arr << ele[i]
            end
            new_arr << sub_arr
        end
        return new_arr
    end

    def my_rotate(num=1)
        new_arr = []
        self.each_with_index do |letter, i|
            new_arr[(i-num) % self.length] = letter
        end
        return new_arr
    end

    def my_join(separator = "")
        new_string = ""
        self.each_with_index do |ele, idx|
            if idx != self.length - 1
                new_string += ele + separator
            else
                new_string += ele
            end
        end
        new_string
    end

    def my_reverse
        new_arr = []
        self.each do |ele|
            new_arr.unshift(ele)
        end
        new_arr
    end
end


# return_value = [1, 2, 3].my_each do |num|
#  puts num
# end.my_each do |num|
#  puts num
# end

# p return_value

# a = [1, 2, 3]
# # p a.my_select { |num| num > 1 } # => [2, 3]
# # p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]