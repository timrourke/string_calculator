class StringCalculator

  DELIMITER_REGEX=/^\/\/(?<delimiter>[\D]+)\n(?<numbers>[\d\D]*)$/

  def add(str)
    if str.empty? then
      return 0
    end

    regex = delimiter_for_string(str)
       
    digits = str.split(regex)
      .map { |digit| digit.to_i }
      .select{ |digit| digit < 1001 }

    raise_if_contains_negatives(digits)

    digits.reduce(:+)
  end

  private

  def delimiter_for_string(str)
    delimiters = ",\n"
    matches = StringCalculator::DELIMITER_REGEX.match(str)

    unless matches.nil? then
      delimiters << matches[:delimiter]
    end

    Regexp.new(sprintf("[%s]", delimiters))
  end

  def raise_if_contains_negatives(digits)
    negatives = digits.select{ |digit| digit.negative? }

    unless negatives.empty? then
      raise ArgumentError.new("negatives not allowed. got: " + negatives.to_s)
    end
  end

end
