require "minitest/autorun"
require "./Dojo/app/petshop"
class TestPetshop < Minitest::Test
    def test_banho
        petshop = Petshop.new
        petshop.banho("zeus")
        assert_equal 1, petshop.lista.size 
    end     
end  