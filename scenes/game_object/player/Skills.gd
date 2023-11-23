extends Node3D
@onready var qskill = $Qskill
@onready var wskill = $Wskill
@onready var eskill = $Eskill
@onready var rskill = $Rskill

func q_skill():
	qskill.execute()

func w_skill():
	wskill.execute()

func e_skill():
	eskill.execute()

func r_skill():
	rskill.execute()
