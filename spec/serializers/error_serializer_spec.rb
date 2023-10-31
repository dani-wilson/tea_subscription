require "rails_helper"

RSpec.describe ErrorSerializer do
  it "formats error messages" do
    error = Error.new("Validation failed: Tea must exist", 404)

    expect(ErrorSerializer.serialize_json(error)).to eq(
      {
        errors: [
          {
            status: "404",
            title: "Validation failed: Tea must exist"
          }
        ]
      }
    )
  end

  it "sets the @error_object instance variable" do
    error = Error.new("Validation failed: Tea must exist", 404)
    serializer = ErrorSerializer.new(error)

    expect(serializer.instance_variable_get(:@error_object)).to eq(error)
  end
end