require 'string_calculator'

describe StringCalculator do

  it "should return zero when passed an empty string" do
    c = StringCalculator.new

    result = c.add("")

    expect(result).to eql(0)
  end

  it "should return the digit provided if only one digit passed" do
    c = StringCalculator.new

    result = c.add("8")

    expect(result).to eql(8)
  end

  it "should add two numbers together" do
    c = StringCalculator.new

    result = c.add("9,10")

    expect(result).to eql(19)
  end

  it "should add three numbers together" do
    c = StringCalculator.new

    result = c.add("10,20,30")

    expect(result).to eql(60)
  end

  it "should add any number of numbers together" do
    c = StringCalculator.new

    result = c.add("1,2,3,4,5,6")

    expect(result).to eql(21)
  end

  it "should add numbers together separated by comma or newline" do
    c = StringCalculator.new

    result = c.add("6,5\n10")

    expect(result).to eql(21)
  end

  it "should support an optional delimiter" do
    c = StringCalculator.new

    result = c.add("//;\n1;2;3")

    expect(result).to eql(6)
  end

  it "should raise an error if any numbers are negative" do
    c = StringCalculator.new

    expect{ c.add("-1") }.to raise_error(ArgumentError, "negatives not allowed. got: [-1]")
  end

  it "should list negative numbers encountered in exception message" do
    c = StringCalculator.new

    expect{ c.add("-1,-2,-3,-4") }
      .to raise_error(ArgumentError, "negatives not allowed. got: [-1, -2, -3, -4]")
  end

  it "should handle numbers as big as 1000" do
    c = StringCalculator.new

    expect(c.add("1000,1000,1000")).to eql(3000)
  end

  it "should ignore numbers bigger than 1000" do
    c = StringCalculator.new

    expect(c.add("1001,1")).to eql(1)
  end

  it "should support delimiters of any length" do
    c = StringCalculator.new

    expect(c.add("//tacotruck\n1tacotruck2tacotruck3")).to eql(6)
  end

  it "should support multiple delimiters" do
    c = StringCalculator.new

    expect(c.add("//[!][?]\n7!7?7")).to eql(21)
  end

  it "should support multiple delimiters having a length greater than 1" do
    c = StringCalculator.new

    expect(c.add("//[foo][bar]\n10foo5bar5foo5,5")).to eql(30)
  end

end
