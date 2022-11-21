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

    def my_flatten()
        new_arr = []

        self.each do |ele|
            # debugger
            if ele.kind_of?(Array)
                new_arr += ele.my_flatten
            else
                new_arr << ele
            end 
        end 

        new_arr
    end 

    def my_zip(*args)
        new_arr = []

        (0...self.length).each do |i|
            subarray = []
            (0...args.length).each do |i|
                subarray << args[i][i]
                subarray << self[i][i]
            end 

            new_arr << subarray
        end
    end  
end

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

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