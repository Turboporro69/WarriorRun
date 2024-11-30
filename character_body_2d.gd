extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -1800

var death_animation_finished : bool = false

func _process(delta):
	if $AnimatedSprite2D.animation == "Death" and !death_animation_finished:
		death_animation_finished = true
		get_parent().is_game_over = true  

func _physics_process(delta):
	velocity.y += GRAVITY * delta

	if get_parent().is_game_over:
		if $AnimatedSprite2D.animation != "Death":
			$AnimatedSprite2D.play("Death")
	else:
		if is_on_floor():
			if not get_parent().game_running:
				$AnimatedSprite2D.play("Idle")
			else:
				$RunCol.disabled = false
				if Input.is_action_pressed("ui_accept"):
					velocity.y = JUMP_SPEED
					$JumpSound.play()
				elif Input.is_action_pressed("ui_down"):
					$AnimatedSprite2D.play("Duck")
					$RunCol.disabled = true
					
					
				else:
					$AnimatedSprite2D.play("Run")
		else:
			$AnimatedSprite2D.play("Jump")
	
	move_and_slide()
