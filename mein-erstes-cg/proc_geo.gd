extends MeshInstance3D


func _ready() -> void:
	# Gegeben:
	var radius = 1
	var segments = 6
	var height = 0.5
	var delta = TAU / segments
	
	#######################################################################
	# ZYLINDERDECKEL
	var verts_top = PackedVector3Array()
	var norms_top = PackedVector3Array()
	var indices_top = PackedInt32Array()
	
	verts_top.append(Vector3(radius, height, 0))
	norms_top.append(Vector3(0, 1, 0))
	
	for i in range(1, segments):
		var x = radius * cos(i*delta)
		var z = radius * sin(i*delta)
		print("Deckel: Punkt " + str(i) + ": (" + str(x) + ", 0, " + str(z) + ")")
		
		verts_top.append(Vector3(x, height, z))	# TODO: Füge Punkt i in den verts-Array ein
		norms_top.append(Vector3(0, 1, 0))
		
		indices_top.push_back(segments)		# TODO: Füge ein Dreieck (drei Indices) in indices-Array ein
		indices_top.push_back(i-1)			# mit den Indizes: aktueller Schleifendurchlauf (i), vorangegangener
		indices_top.push_back(i) 			# Schleifendurchlauf (i-1), letzter Eintrag im Array (segments)
	
	verts_top.append(Vector3(0, height, 0)) # dieser Punkt kriegt den Index segments
	norms_top.append(Vector3(0, 1, 0))
	
	indices_top.push_back(segments)			# TODO: Füge das fehlend letzte Dreieck ein. KEINEN Eintrag in den verts Array!
	indices_top.push_back(segments-1)		# NUR drei Einträge in den Index-Array.
	indices_top.push_back(0)
	
	
	var meta_array_top = []
	meta_array_top.resize(Mesh.ARRAY_MAX)
	meta_array_top[Mesh.ARRAY_VERTEX] = verts_top
	meta_array_top[Mesh.ARRAY_NORMAL] = norms_top
	meta_array_top[Mesh.ARRAY_INDEX] = indices_top
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, meta_array_top)
	
	#######################################################################
	# ZYLINDERBODEN
	var verts_bottom = PackedVector3Array()
	var norms_bottom = PackedVector3Array()
	var indices_bottom = PackedInt32Array()
	
	verts_bottom.append(Vector3(radius, -height, 0))
	norms_bottom.append(Vector3(0, 1, 0))
	
	for i in range(1, segments):
		var x = radius * cos(i*delta)
		var z = radius * sin(i*delta)
		print("Boden: Punkt " + str(i) + ": (" + str(x) + ", 0, " + str(z) + ")")
		
		verts_bottom.append(Vector3(x, -height, z))
		norms_bottom.append(Vector3(0, 1, 0))
		
		indices_bottom.push_back(i-1)
		indices_bottom.push_back(segments)
		indices_bottom.push_back(i)
	
	verts_bottom.append(Vector3(0, -height, 0))
	norms_bottom.append(Vector3(0, 1, 0))
	
	indices_bottom.push_back(segments-1)
	indices_bottom.push_back(segments)
	indices_bottom.push_back(0)
	
	
	var meta_array_bottom = []
	meta_array_bottom.resize(Mesh.ARRAY_MAX)
	meta_array_bottom[Mesh.ARRAY_VERTEX] = verts_bottom
	meta_array_bottom[Mesh.ARRAY_NORMAL] = norms_bottom
	meta_array_bottom[Mesh.ARRAY_INDEX] = indices_bottom
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, meta_array_bottom)

	#######################################################################
	# ZYLINDERMANTEL
	var verts_side = PackedVector3Array()
	var norms_side = PackedVector3Array()
	var indices_side = PackedInt32Array()
	
	verts_side.append(Vector3(radius, height, 0))
	norms_side.append(Vector3(1, 0, 0))
	
	verts_side.append(Vector3(radius, -height, 0))
	norms_side.append(Vector3(1, 0, 0))
	
	for i in range(1, segments):
		var x = 1 * cos(i*delta)
		var z = 1 * sin(i*delta)
		print("Boden: Punkt " + str(i) + ": (" + str(x) + ", 0, " + str(z) + ")")
		
		verts_side.append(Vector3(radius * x, height, radius * z))
		norms_side.append(Vector3(x, 0, z))
		
		verts_side.append(Vector3(radius * x, -height, radius * z))
		norms_side.append(Vector3(x, 0, z))
		
		indices_side.push_back((i*2)-2)
		indices_side.push_back((i*2)-1)
		indices_side.push_back((i*2))
		
		indices_side.push_back((i*2)-1)
		indices_side.push_back((i*2)+1)
		indices_side.push_back((i*2))
	
	indices_side.push_back((segments*2)-1)
	indices_side.push_back(0)
	indices_side.push_back((segments*2)-2)
	
	indices_side.push_back((segments*2)-1)
	indices_side.push_back(1)
	indices_side.push_back(0)
	
	var meta_array_side = []
	meta_array_side.resize(Mesh.ARRAY_MAX)
	meta_array_side[Mesh.ARRAY_VERTEX] = verts_side
	meta_array_side[Mesh.ARRAY_NORMAL] = norms_side
	meta_array_side[Mesh.ARRAY_INDEX] = indices_side
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, meta_array_side)
