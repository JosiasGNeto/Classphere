// Pressionou ESPAÇO para levantar
if (is_sitting && chair_id != -1 && instance_exists(chair_id)) {
    var chair = chair_id;
    chair.Stand(id);
}
