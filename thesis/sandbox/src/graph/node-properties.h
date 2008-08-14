/*
	This file is part of Sandbox.

	Copyright (C) 2008  Marleine Daoud <marleine@gmail.com>

	Sandbox is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	Sandbox is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License 
	along with Sandbox.  If not, see <http://www.gnu.org/licenses/>.
*/

typedef enum _NodeType {
	RECTANGLE = 0,
	CIRCLE,
	SQUARE,
	ELLIPSE,
	TRIANGLE,
	NOTE
} NodeType;

typedef enum _Color {
	RED = 0,
	BLUE,
	BLACK,
	YELLOW
} Color;

typedef enum _Style {
	CONTINUOUS = 0,
	DASHED
} Style;

typedef struct _Properties {
	NodeType type;
	Style lineStyle;
	Color lineColor;
	Color fillColor;
	char *comment;
} Properties;

