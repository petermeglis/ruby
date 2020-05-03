def substrings(phrase, substrings)
    target_phrase = phrase.downcase
    substrings.reduce({}) do |hash, substring|
      occurrences = 0
      found_at = target_phrase.index(substring.downcase, 0)
      until found_at == nil
        occurrences += 1
        found_at = target_phrase.index(substring.downcase, found_at + substring.length)
      end
      hash[substring.downcase] = occurrences unless occurrences == 0
      hash
    end
  end
  
  dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
  substrings("below", dictionary)
  substrings("Howdy partner, sit down! How's it going?", dictionary)