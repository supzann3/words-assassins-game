class Word
  def self.word_list
    f = File.read('words.yml')
    YAML.load(f)
  end
end
