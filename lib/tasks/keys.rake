namespace :keys do
  desc "TODO"
  task :generate, [ :count ] => :environment do |t, args|
    break if Key.count > 100

    count = args[:count].nil? ? 100 : args[:count].to_i
    keys = []
    (1..count).each do
      loop do
        key = SecureRandom.urlsafe_base64(3)
        if !Key.exists?(name: key) && !Url.exists?(shortened: key)
          keys << { name: key }
          break
        end
      end
    end
    Key.insert_all(keys)
  end
end
