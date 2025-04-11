extends GridContainer

@onready var slots = get_children() # get all slots

func _ready():
	add_item(load("res://Items/Bow.tres"))
	add_item(load("res://Items/Solasta.tres"))
	add_item(load("res://Items/Soldier Sword.tres"))
	add_item(load("res://Items/Tome.tres"))

# function to add item to the inventory
func add_item(item : Item):
	for slot in slots:
		if slot.item == null:
			slot.item = item
			return
	print("Can't add anymore items...")
	
# function to remove item from the inventory
func remove_item(item : Item):
	for slot in slots:
		if slot.item == item:
			slot.item = null
			return
	print("Item not found")
		
