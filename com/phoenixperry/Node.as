package com.phoenixperry
{
	public class Node
	{//I'm a linked list!! 
		public var node_data:*; 
		public var next_node:Node; 
	
	public function Node(node_content:*) { 
			node_data = node_content; 
			next_node=null; 
	}
	
	public function get_node_data():* { 
		return node_data; 
	}
	
	public function insert_prev(n:Node):void { 
		n.next_node = this; 
	}
	public function insert_next(n:Node):void { 
		next_node = n; 
	}
	public function get_next_node():Node { 
		return next_node; 
	}
	
	}
}