if (!global.chat_active) {
    if (!is_sitting) {
        var chair = instance_nearest(x, y, obj_Table);

        // Verifica se está perto o suficiente e se a cadeira está livre
        if (chair != noone && point_distance(x, y, chair.x, chair.y) < 64 && !chair.occupied) {
            chair.Sit(id);
        }
    }
}