extends Resource


class_name Inventory

@export var slots: Array[InventorySlot]

signal update


func insert(item: InventoryItem):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	
	if !item_slots.is_empty():
		item_slots[0].amount += 1
		update.emit()
		return
	
	var empty_slots = slots.filter(func(slot): return slot.item == null)
	
	if !empty_slots.is_empty():
		var first_slot = empty_slots[0]
		first_slot.item = item
		first_slot.amount = 1
		update.emit()
