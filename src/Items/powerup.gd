extends Item
class_name Powerup

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(hit)

func hit(other):
	if other is Mouse_col:
		return other.get_parent()
		
