import 'package:flutter/material.dart';

final myFilters = [
ColorFilter.mode(Colors.transparent, BlendMode.dst),

//grey scale
ColorFilter.matrix([
0.2126, 0.7152, 0.0722, 0, 0,
0.2126, 0.7152, 0.0722, 0, 0,
0.2126, 0.7152, 0.0722, 0, 0,
0, 0, 0, 1, 0,
]
)];
