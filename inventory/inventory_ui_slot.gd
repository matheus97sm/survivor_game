extends Panel


func update(slot: InventorySlot):		
	if !slot.item:
		%ItemDisplay.visible = false
		%ItemAmount.visible = false
	else:
		%ItemDisplay.visible = true
		%ItemDisplay.texture = slot.item.texture
		%ItemAmount.visible = true
		%ItemAmount.text = str(slot.amount)
