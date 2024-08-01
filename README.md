# Move-and-fire-a-gun-FPS-

#For the weapon to work, it is necessary to create a "Hand" as a parent, and a "MeshInstance3D" as a child.

#The camera has the "Head" node as its parent, and the camera as the "RayCast" child.

$Formation: Create
Player\Head\Camera\RayCast
            \Camera\Hand\MeshInstance

$Formation_Menu: Create
Control\MarginContainer\Container\VBoxContainer\Button                        Rename Buttons 3 

$Formation_Menu: Create
Control\MarginContainer\Container\VBoxContainer\Button                        Rename Buttons 1
