# require modules here
require "yaml"
require "pry"

def load_library(library)
  translate = {"get_meaning" => {},
               "get_emoticon" => {}
              }
  emoticons = YAML.load_file(library)
  emoticons.each {|meaning, emotes|
    translate.each {|get, hash|
      if get == "get_meaning"
        hash.store(emotes[1], meaning)
      elsif get == "get_emoticon"
        hash.store(emotes[0], emotes[1])
      end
    }
  }
  return translate
end

def get_japanese_emoticon(library, emoticon)
  translate = load_library(library)
  translate.each{|get, hash|
    if get == "get_emoticon"
      hash.each {|emote, j_emoticon|
        if "#{emoticon}" == emote
          return j_emoticon
        elsif hash.has_key?("#{emoticon}") == false
          return "Sorry, that emoticon was not found"
        end
      }
    end
  }
end

def get_english_meaning(library, emoticon)
  translate = load_library(library)
  translate.each {|get, hash|
    if get == "get_meaning"
      hash.each{|j_emoticon, meaning|
        if j_emoticon == "#{emoticon}"
          return meaning
        elsif hash.has_key?("#{emoticon}") == false
          return "Sorry, that emoticon was not found"
        end
      }
      end
    }
end
