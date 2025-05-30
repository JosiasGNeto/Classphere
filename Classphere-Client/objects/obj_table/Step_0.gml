// Área de ativação (ajustável)
var padding = 8;
var x1 = bbox_left - padding;
var y1 = bbox_top - padding;
var x2 = bbox_right + padding;
var y2 = bbox_bottom + padding;

var player_near = collision_rectangle(x1, y1, x2, y2, obj_Player, false, true);

show_press_e = (player_near && !occupied);