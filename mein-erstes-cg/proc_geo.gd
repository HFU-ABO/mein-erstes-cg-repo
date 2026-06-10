extends MeshInstance3D


func _ready() -> void:
	# Gegeben:
	var radius = 1
	var segments = 6
	var delta = TAU / segments
	
	var verts = PackedVector3Array()
	var indices = PackedInt32Array()
	
	verts.append(Vector3(radius, 0, 0))
	
	for i in range(1, segments):
		var x = radius * cos(i*delta)
		var z = radius * sin(i*delta)
		print("Punkt " + str(i) + ": (" + str(x) + ", 0, " + str(z) + ")")
		verts.append(Vector3(x, 0, z))	# TODO: Füge Punkt i in den verts-Array ein
		indices.push_back(segments)		# TODO: Füge ein Dreieck (drei Indices) in indices-Array ein
		indices.push_back(i-1)			# mit den Indizes: aktueller Schleifendurchlauf (i), vorangegangener
		indices.push_back(i) 			# Schleifendurchlauf (i-1), letzter Eintrag im Array (segments)
	
	verts.append(Vector3(0, 0, 0)) # dieser Punkt kriegt den Index segments
	
	indices.push_back(segments)			# TODO: Füge das fehlend letzte Dreieck ein. KEINEN Eintrag in den verts Array!
	indices.push_back(segments-1)		# NUR drei Einträge in den Index-Array.
	indices.push_back(0)
	
	print(verts)
	print(indices)
	
	var meta_array = []
	meta_array.resize(Mesh.ARRAY_MAX)
	meta_array[Mesh.ARRAY_VERTEX] = verts
	meta_array[Mesh.ARRAY_INDEX] = indices
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, meta_array)
