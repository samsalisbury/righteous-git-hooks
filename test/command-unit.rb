module CommandUnit

	class TestFixture

		def run
			self.public_methods(false).each do |m|
        next if m == __method__
        puts "Name: #{m}"
        puts self.send m rescue 'could not invoke'
      end
    end

    def bananarama
      hands = ''
      5.times { |bananas| hands += "#{bananas+1} bananas " }
      hands
    end

    def cheezy_dreams
      cheeses = ''
      10.times { |i| cheeses += "cheese #{fac(i+1)} " }
      cheeses
    end

    def fac(x)
      return 1 if x == 1
      return x * fac(x-1)
    end

	end

  tests = TestFixture.new
  tests.run

end