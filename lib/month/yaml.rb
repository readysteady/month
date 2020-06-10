require 'yaml'

class Month
  def encode_with(coder)
    coder.represent_scalar(nil, to_s)
  end

  module ScalarScannerPatch
    REGEXP = /\A(\d{4})-(\d{2})\z/

    def tokenize(string)
      if !string.empty? && string.match(REGEXP)
        return Month.new($1.to_i, $2.to_i)
      end

      super string
    end

    YAML::ScalarScanner.prepend(self)
  end

  private_constant :ScalarScannerPatch
end
