class MessageCounter
  def self.count(numbers, user)
    vodafone = optimus = tmn = 0
    numbers.each do |number|
      operator_indicator = number.match(/(\d\d)/)[1]
      case operator_indicator
      when "91"
        vodafone += 1
      when "96"
        tmn += 1
      when "92"
        tmn += 1
      when "93"
        optimus +=1
      end
    end

    user.vodafone += vodafone
    user.tmn += tmn
    user.optimus += optimus
    user.save
  end
end