namespace :keys do
  desc "TODO"
  task generate: :environment do
    next_id = (Key.maximum(:id) || 0) + 1
    (next_id..(next_id + 100000)).each do |id|
      encoded = fixed_length_base64_encode(id, bytes: 6)
      Key.create(name: encoded)
    end
  end
  def fixed_length_base64_encode(number, bytes: 6)
    # Convert the number to a fixed-length binary representation
    bin = [ number ].pack("Q>")[-bytes, bytes] # Use 'Q>' for 64-bit big-endian
    # Base64 encode the binary representation
    Base64.urlsafe_encode64(bin, padding: false)
  end
end
