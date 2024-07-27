// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DirectionFunction(_x, _y){
	// 0 = right, 1 = up, 2 = left, 3 = down 
	if ((_x = 1) && (_y = 0)) || ((_x = 1) && (_y = 1)) || ((_x = 1) && (_y = -1))
	{
		return 0;
	}
	if ((_x = -1) && (_y = 0)) || ((_x = -1) && (_y = 1)) || ((_x = -1) && (_y = -1))
	{
		return 2;
	}
	if ((_x = 0) && (_y = -1))
	{
		return 1;
	}
	return 3;
}