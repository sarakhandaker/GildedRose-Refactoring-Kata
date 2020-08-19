# require File.join(File.dirname(__FILE__), 'gilded_rose')
require_relative 'gilded_rose.rb'
require 'rspec'
# describe GildedRose do
#   describe "#update_quality" do
#     it "does not change the name" do
#       items = [Item.new("foo", 0, 0)]
#       GildedRose.new(items).update_quality()
#       expect(items[0].name).to eq "fixme"
#     end
#   end
# end

RSpec.describe GildedRose do
  context "Normal Item" do
    it "before sell date" do
      item=Item.new("Normal Item", 5, 10)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: 4, quality: 9)
    end

    it "on sell date" do
      item=Item.new("Normal Item", 0, 10)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: -1, quality: 8)
    end

    it "after sell date" do
      item=Item.new("Normal Item", -10, 10)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: -11, quality: 8)
    end

    it "of zero quality" do
      item=Item.new("Normal Item", 5, 0)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: 4, quality: 0)
    end
  end

  context "Aged Brie" do
    it "before sell date" do
      item=Item.new("Aged Brie", 5, 10)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: 4, quality: 11)
    end

    it "of 50 quality" do
      item=Item.new("Aged Brie", 5, 50)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: 4, quality: 50)
    end

    it "on sell date" do
      item=Item.new("Aged Brie", 0, 10)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: -1, quality: 12)
    end

    it "on sell date near max quality" do
      item=Item.new("Aged Brie", 0, 49)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: -1, quality: 50)
    end

    it "on sell date with max quality" do
      item=Item.new("Aged Brie", 0, 50)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: -1, quality: 50)
    end

    it "after sell date" do
      item=Item.new("Aged Brie", -10, 10)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: -11, quality: 12)
    end

    it "after sell date with max quality" do
      item=Item.new("Aged Brie", -1, 50)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: -2, quality: 50)  
    end
  end

  context "Sulfuras" do 
    it "no update to sell and quality" do
      item=Item.new("Sulfuras", 5, 80)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: 5, quality: 80)
    end
  end

  context "Backstage Pass" do
    it "more than 10 days before sell date" do
      item=Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: 10, quality: 11)
    end

    it "more than 10 days before sell date at max quality" do
      item=Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 50)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: 10, quality: 50)
    end

    it "5-10 days before sell date" do
      item=Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: 9, quality: 12)
    end

    it "5-10 days before sell date at max quality" do
      item=Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: 9, quality: 50)
    end

    it "less than 5 days to sell date" do
      item=Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 10)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: 0, quality: 13)
    end

    it "less than 5 days to sell date at max quality" do
      item=Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 50)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: 0, quality: 50)
    end

    it "on sell date" do
      item=Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: -1, quality: 0)
    end

    it "after sell date" do
      item=Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 10)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: -2, quality: 0)
    end
  end

  context "Conjured Items" do
    it "before sell date" do
      item=Item.new("Conjured Mana Cake", 5, 10)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: 4, quality: 8)
    end

    it "before sell date at zero quality" do
      item=Item.new("Conjured Mana Cake", 5, 0)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: 4, quality: 0)
    end

    it "after sell date" do
      item=Item.new("Conjured Mana Cake", -5, 10)
      gilded_rose = GildedRose.new([item])
      gilded_rose.update_quality
      expect(item).to have_attributes(sell_in: -6, quality: 6)
    end
  end
end

# Gilded Rose Requirements Specification

# Your task is to add the new feature to our system so that we can begin selling a new category of items. 
# All items have a SellIn value which denotes the number of days we have to sell the item
# All items have a Quality value which denotes how valuable the item is
# At the end of each day our system lowers both values for every item
# Once the sell by date has passed, Quality degrades twice as fast
# The Quality of an item is never negative
# "Aged Brie" actually increases in Quality the older it gets
# The Quality of an item is never more than 50
# "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
# "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches; 
# Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert
# We have recently signed a supplier of conjured items. This requires an update to our system:
# "Conjured" items degrade in Quality twice as fast as normal items
# Feel free to make any changes to the update-quality method and add any new code as long as everything still works correctly. 
# However, do not alter the Item class or Items property.
# An item can never have its Quality increase above 50, however "Sulfuras" is a legendary item and as such its Quality is 80 and it never alters.