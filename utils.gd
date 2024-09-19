extends Node

class_name Utils

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
