namespace :keys do
  desc "TODO"
  task :generate, [ :number ] => :environment do |t, args|
    break if Key.count > 100
    number = args[:number].nil? ? 100 : args[:number].to_i
    next_id = Key.count + Url.count + 1
    keys = (next_id..(next_id + number - 1)).map { |num| { name: to_base62(num, 6) } }
    Key.insert_all(keys)
  end
  def to_base62(num, length)
    characters = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    base = characters.length
    result = ""

    while num > 0
      result = characters[num % base] + result
      num /= base
    end
    result.rjust(length, "a")
  end
end
