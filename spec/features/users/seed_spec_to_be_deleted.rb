require 'rails_helper'

RSpec.describe 'As a programmer trying to get working seed data' do
	it 'does things the way I want' do
binding.pry


@admin_1 = create(:admin)

@admin_2 = create(:admin)


@merchant_1 = create(:merchant)

@merchant_2 = create(:merchant)

@merchant_3 = create(:merchant)

@merchant_4 = create(:merchant)

@merchant_5 = create(:merchant)

@merchant_6 = create(:merchant)

@merchant_7 = create(:merchant)

@merchant_8 = create(:merchant)



@user_1 = create(:user)

@user_2 = create(:user)

@user_3 = create(:user)

@user_4 = create(:user)

@user_5 = create(:user)

@user_6 = create(:user)

@user_7 = create(:user)

@user_8 = create(:user)

@user_9 = create(:user)

@user_10 = create(:user)



#====================ITEMS==========================#

@item_1 =  @merchant_1.items.create!(name: "Apple:	Pyrus malus", active: true, price: 0.57, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 4367)

@item_2 =  @merchant_1.items.create!(name: "Brinjal:	Solanum melongena", active: true, price: 2.00, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 235)

@item_3 =  @merchant_1.items.create!(name: "Banana:	Musa paradisicum", active: true, price: 1.22, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 9643)

@item_4 =  @merchant_1.items.create!(name: "Black: Gram	Palsoes Mungo", active: true, price: 2.00, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 132)

@item_5 =  @merchant_1.items.create!(name: "Black: Pepper	Piper nigrum", active: true, price: 3.22, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 765)

@item_6 =  @merchant_1.items.create!(name: "Carrot:	Daucas carota", active: true, price: 0.27, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 9755)

@item_7 =  @merchant_1.items.create!(name: "Cashew nut:	Anacardium occidentale", active: true, price: 1.26, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 9654)

@item_8 =  @merchant_2.items.create!(name: "Clove:	Syzygium aromaticum", active: true, price: 1.07, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 9362)

@item_9 =  @merchant_2.items.create!(name: "Coriander:	Coriandrum sativum", active: true, price: 1.26, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 6524)

@item_10 = @merchant_2.items.create!(name: "Cucumber:	Cucumis sativas", active: true, price: 0.57, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 36864)

@item_11 = @merchant_2.items.create!(name: "Curry leaf:	Murraya koenigii", active: true, price: 0.87, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 7364)

@item_12 = @merchant_2.items.create!(name: "Capsicum:	Capsicum fruitscence", active: true, price: 4.22, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 3648)

@item_13 = @merchant_2.items.create!(name: "Chiku:	Achras sapota", active: true, price: 6.37, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 122)

@item_14 = @merchant_2.items.create!(name: "Cotton:	Gossypium herbaceum", active: true, price: 0.22, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 876)

@item_15 = @merchant_3.items.create!(name: "Dragon fruit:	Hylocereus undutus", active: true, price: 2.11, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 72)

@item_16 = @merchant_3.items.create!(name: "Finger millet:	Eleusine coracana", active: true, price: 0.11, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 23965)

@item_17 = @merchant_3.items.create!(name: "Green Gram:	Phaseolies auicus", active: true, price: 2.22, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 12)

@item_18 = @merchant_3.items.create!(name: "Guava:	Psidium guava", active: true, price: 1.44, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 873)

@item_19 = @merchant_3.items.create!(name: "Ginger:	Zingiber officinale", active: true, price: 1.11, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 111)

@item_20 = @merchant_3.items.create!(name: "Garlic:	Allium sativum", active: true, price: 0.46, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 3452)

@item_21 = @merchant_3.items.create!(name: "Jack fruit:	Artocarpus integra", active: true, price: 2.26, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 4324)

@item_22 = @merchant_4.items.create!(name: "Jowar:	Sorghum Vulgare", active: true, price: 3.36, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 263)

@item_23 = @merchant_4.items.create!(name: "Lemon:	Citrus limonium", active: true, price: 0.86, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 466)

@item_24 = @merchant_4.items.create!(name: "Maize:	Zea mays", active: true, price: 8.47, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 263)

@item_25 = @merchant_4.items.create!(name: "Mango:	Mangifera indica", active: true, price: 4.25, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 892)

@item_26 = @merchant_4.items.create!(name: "Neem:	Azadhirachta indica", active: true, price: 3.33, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 1133)

@item_27 = @merchant_5.items.create!(name: "Onion:	Allium cepa", active: true, price: 0.17, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 8347)

@item_28 = @merchant_5.items.create!(name: "Orange:	Citrus aurantium", active: true, price: 1.82, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 466)

@item_29 = @merchant_5.items.create!(name: "Pea:	Pisum sativam", active: true, price: 0.46, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 3328)

@item_30 = @merchant_5.items.create!(name: "Papaya:	Carica papaya", active: true, price: 3.46, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 282)

@item_31 = @merchant_5.items.create!(name: "Potato:	Solanum tubersum", active: true, price: 0.11, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 4984)

@item_32 = @merchant_5.items.create!(name: "Pomegranate:	Punica granatum", active: true, price: 0.86, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 267)

@item_33 = @merchant_6.items.create!(name: "Peacock Flower: (Gulmohar)	Delonix regia rafin", active: true, price: 11.32, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 22)

@item_34 = @merchant_6.items.create!(name: "Purple orchid tree: (Kachnar)	Bauhinia purpurea", active: true, price: 6.42, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 17)

@item_35 = @merchant_6.items.create!(name: "Peepal:	Ficus religiosa Linn", active: true, price: 2.21, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 85)

@item_36 = @merchant_6.items.create!(name: "Pineapple:	Ananus sativus", active: true, price: 1.12, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 467)

@item_37 = @merchant_6.items.create!(name: "Radish:	Raphanus sativus", active: true, price: 0.21, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 3428)

@item_38 = @merchant_6.items.create!(name: "Red maple:	Acer rubrum", active: true, price: 3.26, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 971)

@item_39 = @merchant_6.items.create!(name: "Rice:	Oryza sativa", active: true, price: 0.11, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 16789)

@item_40 = @merchant_6.items.create!(name: "Rose:	Rosa", active: true, price: 5.25, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 333)

@item_41 = @merchant_7.items.create!(name: "Soy bean:	Glycine max", active: true, price: 0.06, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 29826)

@item_42 = @merchant_7.items.create!(name: "Silver Oak:	Grevillea robusta", active: true, price: 4.44, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 71)

@item_43 = @merchant_7.items.create!(name: "Sandalwood:	Santalum album", active: true, price: 1.26, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 982)

@item_43 = @merchant_7.items.create!(name: "Spinach:	Lactuca sativa", active: true, price: 0.55, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 3846)

@item_44 = @merchant_7.items.create!(name: "Sunflower:	Helianthus annuus", active: true, price: 0.02, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 18928)

@item_45 = @merchant_7.items.create!(name: "Turmeric:	Curcuma longa", active: true, price: 0.26, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 886)

@item_46 = @merchant_7.items.create!(name: "Tobacco:	Nicotina tobaccum", active: true, price: 0.57, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 489)

@item_47 = @merchant_7.items.create!(name: "Tulsi:	Ocimum sanctum", active: true, price: 1.32, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 12)

@item_48  = @merchant_8.items.create!(name: "Tamarind tree:	Tamarindus indica", active: true, price: 2.22, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 128)

@item_49  = @merchant_8.items.create!(name: "Tomato:	Lycopersican esculentum", active: true, price: 0.12, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 6812)

@item_50  = @merchant_8.items.create!(name: "Watermelon:	Citrullus vulgaris", active: true, price: 0.73, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 1197)

@item_51  = @merchant_8.items.create!(name: "Wheat:	Triticum Aestivum", active: true, price: 0.02, description: "this is a mock description of a seed", image: "https://picsum.photos/200/300?image=1", inventory: 128972)

binding.pry

	end
end
