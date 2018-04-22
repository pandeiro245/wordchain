class Heroku
  def self.env
    File.open('.env', 'r').read.split("\n").each do |line|
      cmd = "heroku config:add #{line}"
      puts `#{cmd}`
    end
  end
end
