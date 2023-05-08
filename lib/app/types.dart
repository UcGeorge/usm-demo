import 'package:flutter/material.dart';

typedef Vertex = String;
typedef VertexPair = String;
typedef Graph = Map<Vertex, Set<Vertex>>;
typedef Path = List<Vertex>;
typedef Position = Offset;
typedef VertexPositionMap = Map<Vertex, Position>;
typedef PathMap = Map<Vertex, Vertex?>;
typedef CostMap = Map<VertexPair, double>;
typedef DepthMap = Map<Vertex, int>;
