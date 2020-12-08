function approach(a, b, amount) {
	if (a < b) {
		a += amount
		if (a > b)
		return b
	} else {
		a -= amount
		if (a < b)
		return b
	}
	return a 	
}

function wave(from, to, duration, offset) {
	var a4 = (to - from) * 0.5
	return from + a4 + sin((((current_time * 0.0001) + duration * offset) / duration) * (pi*2)) * a4	
}

function wrap(value, Min, Max) {
	var _val = value
	var _max = Min
	var _min = Max

	if(_val mod 1 == 0) {
		while(_val > _max || _val < _min) {
			if(_val > _max) {
				_val = _min + _val - _max - 1	
			} else if (_val < _min) {
				_val = _max + _val - _min + 1
			} else _val = _val 
		}
		return _val
	} else {
		var _old = value + 1
		while (_val != _old) {
			_old = _val
			if(_val<_min) {
				_val = _max - (_min - _val)	
			} else if (_val > _max) {
				_val = _min + (_val - _max)
			} else _val = _val
		}
		return _val
	}	
}
	
function draw_text_outlined(x, y, String, text_color, outline_color) {
	var xx = x;
	var yy = y;
	var s = String;
	var c1 = text_color;
	var c2 = outline_color;

	draw_set_color(c2);
	draw_text(xx+1, yy+1, s);
	draw_text(xx-1, yy+1, s);
	draw_text(xx+1, yy-1, s);
	draw_text(xx-1, yy-1, s);

	draw_set_color(c1);
	draw_text(xx, yy, s);
}
	
function draw_reset() {
	
	draw_set_color(c_black)
	draw_set_alpha(1)
	draw_set_font(-1)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
}

function create_surface(width, height) {
	var surface = surface_create(width, height)
	surface_set_target(surface)
	draw_clear_alpha(c_white, 0)
	surface_reset_target()
	return surface
}
	
function create_item(item_index) constructor {
	item = item_index
}

function box_draw_shadow(_xx, _yy, _length) {
	/// @description /////////////////////////////////////////////////////////////////
	//scr_box_draw_shadow(light_x,light_y,size,max_draw_distance)
	//draws simple shadows for a point light, from square objects
	//by: Wubs
	//http://wubsgames.com
	//
	//This script works by drawing shadows from the corner of box shaped sprites.
	//The object must have its sprite orign centered
	//
	////////////////////////////////////////////////////////////////////
	//var _xx = argument0//light x
	//var _yy = argument1//light y
	//var _size = argument2 //block half size (sprite_width/2)
	//var _l = argument3 //shadow max distance
	var _d = 0 //direction to point light
	
	var _x1=bbox_left
	var _x2=bbox_right
	var _y1=bbox_top
	var _y2=bbox_bottom
	
	var _xd1=0
	var _yd1=0
	var _xd2=0
	var _yd2=0
	var _xd3=0
	var _yd3=0
	var _xd4=0
	var _yd4=0

	//	South West
	if ((_yy>=_y1)and(_xx<=_x1))//store points for drawing 
	    {
	    _d=point_direction(_xx,_yy,_x1,_y1)
	    _xd1=_x1
	    _yd1=_y1
	    _xd2=_x1+lengthdir_x(_length,_d)
	    _yd2=_y1+lengthdir_y(_length,_d)
	    }
	
	//	North West
	if ((_yy<=_y1)and(_xx<=_x2))
	    {
	    _d=point_direction(_xx,_yy,_x2,_y1)
	    _xd1=_x2
	    _yd1=_y1
	    _xd2=_x2+lengthdir_x(_length,_d)
	    _yd2=_y1+lengthdir_y(_length,_d)
	    }

	//	
	if ((_yy<=_y2)and(_xx>=_x2))
	    {
	    _d=point_direction(_xx,_yy,_x2,_y2)
	    _xd1=_x2
	    _yd1=_y2
	    _xd2=_x2+lengthdir_x(_length,_d)
	    _yd2=_y2+lengthdir_y(_length,_d)
	    }
    
	if ((_yy>=_y2)and(_xx>=_x1))
	    {
	    _d=point_direction(_xx,_yy,_x1,_y2)
	    _xd1=_x1
	    _yd1=_y2
	    _xd2=_x1+lengthdir_x(_length,_d)
	    _yd2=_y2+lengthdir_y(_length,_d)
	    }



	if ((_yy<=_y1)and(_xx>=_x1))
	    {
	    _d=point_direction(_xx,_yy,_x1,_y1)
	    _xd3=_x1
	    _yd3=_y1
	    _xd4=_x1+lengthdir_x(_length,_d)
	    _yd4=_y1+lengthdir_y(_length,_d)
	    }

	if ((_yy>=_y1)and(_xx>=_x2))
	    {
	    _d=point_direction(_xx,_yy,_x2,_y1)
	    _xd3=_x2
	    _yd3=_y1
	    _xd4=_x2+lengthdir_x(_length,_d)
	    _yd4=_y1+lengthdir_y(_length,_d)
	    }

	if ((_yy>=_y2)and(_xx<=_x2))
	    {
	    _d=point_direction(_xx,_yy,_x2,_y2)
	    _xd3=_x2
	    _yd3=_y2
	    _xd4=_x2+lengthdir_x(_length,_d)
	    _yd4=_y2+lengthdir_y(_length,_d)
	    }
    
	if ((_yy<=_y2)and(_xx<=_x1))
	    {
	    _d=point_direction(_xx,_yy,_x1,_y2)
	    _xd3=_x1
	    _yd3=_y2
	    _xd4=_x1+lengthdir_x(_length,_d)
	    _yd4=_y2+lengthdir_y(_length,_d)
	    }
		
		

	draw_primitive_begin(pr_trianglelist)//draw the primative
	draw_vertex(_xd1,_yd1)
	draw_vertex(_xd2,_yd2)
	draw_vertex(_xd3,_yd3)
	draw_vertex(_xd2,_yd2)
	draw_vertex(_xd3,_yd3)
	draw_vertex(_xd4,_yd4)
	draw_primitive_end()		
}
