class StringCalculator

  DELIMITER_REGEX=/^\/\/(?<delimiter>[\D]+)\n(?<numbers>[\d\D]*)$/

  def add(str)
    return 0 if str.empty?

    regex = delimiter_for_string(str)
       
    digits = split_and_limit_to_less_than_1001(str, regex)

    raise_if_contains_negatives(digits)

    digits.reduce(:+)
  end

  private

  def split_and_limit_to_less_than_1001(str, regex)
    str.split(regex)
      .map(&:to_i)
      .select { |digit| digit < 1001 }
  end

  def delimiter_for_string(str)
    delimiters = ",\n"
    matches = StringCalculator::DELIMITER_REGEX.match(str)

    delimiters << matches[:delimiter] if matches

    Regexp.new("[#{delimiters}]")
  end

  def raise_if_contains_negatives(digits)
    negs = digits.select{ |digit| digit.negative? }

    raise ArgumentError.new("negatives not allowed. got: #{negs}") unless negs.empty?
  end

end
