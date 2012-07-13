package com.phoenixperry{
	import org.osflash.signals.Signal;
	
	public class Node {
		public var rightAnswer:Signal; 
		
		public var node_data:*;
		public var next_node:Node;
		public var wrongAnswer:Signal; 
		
		
		public function Node(node_content:*) {
			node_data=node_content;
			next_node=null;
			rightAnswer = new Signal(); 
			wrongAnswer = new Signal(); 
		}	
		public function get_node_data():* {
			return node_data;
		}
		public function insert_prev(n:Node):void {
			n.next_node=this;
		}
		public function insert_next(n:Node):void {
			next_node=n;
		}
		public function get_next_node():Node {
			return next_node;
		}
		
		public function compareNode(n:Number):Node{
			trace(n, "I'm what is getting passed in the compare", this.node_data); 
			if(this.node_data  == n) { 
				//note thiw will always test true on start up because you are creating the nodes. 
				rightAnswer.dispatch(); 
				if(next_node==null) {
					generateRandomNode(); 
				//endOfSequence.dispatch(); 
				}
			} else { 
				wrongAnswer.dispatch(n); 
				if(next_node==null) 
				{ 
					generateRandomNode(); 
				}
			}
			return this.next_node; 	
		}
		public function generateRandomNode():void { 
			var num:Number = int(Math.random()*6); 
			next_node = new Node(num);
		}
		public function generateDemoNode():Node { 
			var num:Number = int(Math.random()*5); 
			next_node = new Node(num);
			trace(num, "i'm the generated Demo Node"); 
			return next_node; 
		}
		public function popRand():Number { 
			var rand:Number = int(Math.random()*5);
			trace(rand, "I'm most likely the first Node"); 
			
			return rand; 
		}
		//ls 
		
	}
}