class ReplaceIconsStrategy
  def self.rules
    {
      ["zerg", "зерг", "z2"] => "icons/zerg.png",
      ["protoss", "протосс", "p2"] => "icons/protoss.png",
      ["terran", "терран", "t2"] => "icons/terran.png",
      ["random", "случайная", "r"] => "icons/random.png",
      ["zerg1", "зерг1", "z1"] => "icons/zerg1.png",
      ["protoss1", "протосс1", "p1"] => "icons/protoss1.png",
      ["terran1", "терран1", "t1"] => "icons/terran1.png",
      ["gold", "g1"] => "icons/gold.gif",
      ["silver", "s1"] => "icons/silver.gif",
      ["bronze", "b1"] => "icons/bronze.gif"
    }
  end
end
