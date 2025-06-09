if (!global.chat_active) {
    if (!is_sitting) {
        var chair = instance_nearest(x, y, obj_Table);
		var chair_only = instance_nearest(x, y, obj_Chair);

        // Verifica se está perto o suficiente e se a cadeira está livre
        if (chair != noone && point_distance(x, y, chair.x, chair.y) < 64 && !chair.occupied) {
            chair.Sit(id);
        }
		
		if (chair_only != noone && point_distance(x, y, chair_only.x, chair_only.y) < 64 && !chair_only.occupied) {
            chair_only.Sit(id);
        }
    }
}