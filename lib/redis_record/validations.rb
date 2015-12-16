module RedisRecord
  module Validations
    def unique?(atr)
      !( find_by(atr, self.send(atr.to_sym)) && find_by(atr, self.send(atr.to_sym)).id != id )
    end
  end
end
