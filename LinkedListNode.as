/*
The MIT License

Copyright (c) 2011 Jackson Dunstan
*/
package
{
	/**
	*   A node in a linked list. Its purpose is to hold the data in the
	*   node as well as links to the previous and next nodes.
	*   @author Jackson Dunstan
	*/
	public class LinkedListNode
	{
		public var next:LinkedListNode;
		public var prev:LinkedListNode;
		public var data:*;
		public function LinkedListNode(data:*=undefined)
		{
			this.data = data;
		}
	}
}