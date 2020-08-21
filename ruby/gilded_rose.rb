class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      update_item(item)
    end
  end

  def update_item(item)
    return if item.name=="Sulfuras, Hand of Ragnaros"
    item.sell_in -= 1
    case item.name
    when "Aged Brie"
      return if item.quality ==50
      item.quality +=1
      item.quality +=1 if item.sell_in <=0 && item.quality <50
    when "Backstage passes to a TAFKAL80ETC concert"
      return if item.quality ==50
      return item.quality = 0 if item.sell_in <0
      item.quality +=1
      item.quality +=1 if item.sell_in < 10
      item.quality +=1 if item.sell_in < 5
    when "Conjured Mana Cake"
      item.quality -= 2
      item.quality -= 2 if item.sell_in <=0
      return item.quality=0 if item.quality<=0
    else #normal
      return if item.quality ==0
      item.quality -=1
      item.quality -=1 if item.sell_in <=0
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end