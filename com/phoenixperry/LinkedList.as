package com.phoenixperry
{
	/**
	 *   A linked list, which is a single-dimensional chain of objects called
	 *   nodes. This implementation is doubly-linked, so each node has a link
	 *   to the next and previous node. It's API is designed to mimic that of
	 *   the top-level Array class.
	 *   @author Jackson Dunstan
	 *           http://JacksonDunstan.com
	 *   @author Simon Tatham (sort functionality)
	 *           http://www.chiark.greenend.org.uk/~sgtatham/algorithms/listsort.html
	 */
	import com.phoenixperry.Node;
	public class LinkedList
	{
		public var head:Node;
		public var tail:Node;
		public var length:int;
		
		public function LinkedList(...values)
		{
			var len:int = this.length = values.length;
			var head:Node = null;
			var newNode:Node;
			var i:int;
			
			// Equivalent to Array(len)
			if (len == 1)
			{
				len = values[0];
				head = this.tail = newNode = new Node();
				for (i = 1; i < len; ++i)
				{
					newNode = new Node();
					newNode.next = head;
					head.prev = newNode;
					head = newNode;
				}
			}
				// Equivalent to Array(value0, value1, ..., valueN)
			else if (len > 1)
			{
				i = len-1;
				head = this.tail = newNode = new Node(values[i--]);
				for (; i >= 0; --i)
				{
					newNode = new Node(values[i]);
					newNode.next = head;
					head.prev = newNode;
					head = newNode;
				}
			}
			this.head = head;
		}
		
		/**
		 *   Equivalent to the Array [] operator
		 *   @param index Index of the element to get
		 *   @return The element at the given index
		 */
		public function elementAt(index:int): *
		{
			if (index < 0)
			{
				throw new TypeError("Error #2007");
			}
			else if (index >= this.length)
			{
				return undefined;
			}
			else
			{
				var halfLength:int = this.length >> 1;
				var cur:Node;
				var i:int;
				var j:int;
				// Element is in the first half, start at beginning
				if (index < halfLength)
				{
					while (true)
					{
						j = index - i;
						if (j == 0) return cur.data;
						else if (j == 1) return cur.next.data;
						else if (j == 2) return cur.next.next.data;
						else if (j == 3) return cur.next.next.next.data;
						else if (j == 4) return cur.next.next.next.next.data;
						else if (j == 5) return cur.next.next.next.next.next.data;
						else if (j == 6) return cur.next.next.next.next.next.next.data;
						else if (j == 7) return cur.next.next.next.next.next.next.next.data;
						else if (j == 8) return cur.next.next.next.next.next.next.next.next.data;
						else if (j == 9) return cur.next.next.next.next.next.next.next.next.next.data;
						else if (j == 10) return cur.next.next.next.next.next.next.next.next.next.next.data;
						cur = cur.next.next.next.next.next.next.next.next.next.next.next;
						i += 11;
					}
				}
					// Element is in the second half, start at the end
				else
				{
					i = this.length-1;
					cur = this.tail;
					while (true)
					{
						j = i - index;
						if (j == 0) return cur.data;
						else if (j == 1) return cur.prev.data;
						else if (j == 2) return cur.prev.prev.data;
						else if (j == 3) return cur.prev.prev.prev.data;
						else if (j == 4) return cur.prev.prev.prev.prev.data;
						else if (j == 5) return cur.prev.prev.prev.prev.prev.data;
						else if (j == 6) return cur.prev.prev.prev.prev.prev.prev.data;
						else if (j == 7) return cur.prev.prev.prev.prev.prev.prev.prev.data;
						else if (j == 8) return cur.prev.prev.prev.prev.prev.prev.prev.prev.data;
						else if (j == 9) return cur.prev.prev.prev.prev.prev.prev.prev.prev.prev.data;
						else if (j == 10) return cur.prev.prev.prev.prev.prev.prev.prev.prev.prev.prev.data;
						cur = cur.prev.prev.prev.prev.prev.prev.prev.prev.prev.prev.prev;
						i -= 11;
					}
				}
			}
		}
		
		public function concat(...args): LinkedList
		{
			var ret:LinkedList = new LinkedList();
			var newNode:Node;
			
			// Add everything from this list
			for (var cur:Node = this.head; cur; cur = cur.next)
			{
				newNode = new Node(cur.data);
				newNode.prev = ret.tail;
				if (ret.tail)
				{
					ret.tail.next = newNode;
				}
				else
				{
					ret.head = newNode;
				}
				ret.tail = newNode;
			}
			
			// Add everything from args
			var list:LinkedList;
			for each (var arg:* in args)
			{
				// Lists get flattened
				if (arg is LinkedList)
				{
					list = arg;
					for (cur = list.head; cur; cur = cur.next)
					{
						newNode = new Node(cur.data);
						newNode.prev = ret.tail;
						if (ret.tail)
						{
							ret.tail.next = newNode;
						}
						else
						{
							ret.head = newNode;
						}
						ret.tail = newNode;
					}
				}
					// No flattening for any other type, even Array
				else
				{
					newNode = new Node(arg);
					newNode.prev = ret.tail;
					if (ret.tail)
					{
						ret.tail.next = newNode;
					}
					else
					{
						ret.head = newNode;
					}
					ret.tail = newNode;
				}
			}
			return ret;
		}
		
		public function every(callback:Function, thisObject:*=null): Boolean
		{
			var index:int;
			for (var cur:Node = this.head; cur; cur = cur.next)
			{
				if (!callback.call(thisObject, cur.data, index, this))
				{
					return false;
				}
				index++;
			}
			return true;
		}
		
		public function filter(callback:Function, thisObject:*=null): LinkedList
		{
			var ret:LinkedList = new LinkedList();
			var index:int;
			var newNode:Node;
			for (var cur:Node = this.head; cur; cur = cur.next)
			{
				if (callback.call(thisObject, cur.data, index, this))
				{
					newNode = new Node(cur.data);
					newNode.prev = ret.tail;
					if (ret.tail)
					{
						ret.tail.next = newNode;
					}
					else
					{
						ret.head = newNode;
					}
					ret.tail = newNode;
				}
				index++;
			}
			return ret;
		}
		
		public function forEach(callback:Function, thisObject:*=null): void
		{
			var index:int;
			for (var cur:Node = this.head; cur; cur = cur.next)
			{
				callback.call(thisObject, cur.data, index, this);
				index++;
			}
		}
		
		public function indexOf(searchElement:*, fromIndex:int=0): int
		{
			var index:int;
			for (var cur:Node = this.head; cur && index < fromIndex; cur = cur.next)
			{
				index++;
			}
			for (; cur; cur = cur.next)
			{
				if (cur.data == searchElement)
				{
					return index;
				}
			}
			return -1;
		}
		
		public function join(sep:*=","): String
		{
			if (!this.head)
			{
				return "";
			}
			
			var ret:String = "";
			for (var curNode:Node = this.head; curNode; curNode = curNode.next)
			{
				ret += curNode.data + sep;
			}
			return ret.substr(0, ret.length-sep.length);
		}
		
		public function lastIndexOf(searchElement:*, fromIndex:int=0x7fffffff): int
		{
			var index:int = this.length-1;
			for (var cur:Node = this.tail; cur && index > fromIndex; cur = cur.prev)
			{
				index--;
			}
			for (; cur; cur = cur.prev)
			{
				if (cur.data == searchElement)
				{
					return index;
				}
				index--;
			}
			return -1;
		}
		
		public function map(callback:Function, thisObject:*=null): LinkedList
		{
			var ret:LinkedList = new LinkedList();
			var index:int;
			var newNode:Node;
			for (var cur:Node = this.head; cur; cur = cur.next)
			{
				newNode = new Node(callback.call(thisObject, cur.data, index, this));
				newNode.prev = ret.tail;
				if (ret.tail)
				{
					ret.tail.next = newNode;
				}
				else
				{
					ret.head = newNode;
				}
				ret.tail = newNode;
				index++;
			}
			return ret;
		}
		
		public function pop(): *
		{
			if (this.tail)
			{
				var ret:* = this.tail.data;
				this.tail = this.tail.prev;
				this.length--;
				return ret;
			}
			else
			{
				return undefined;
			}
		}
		
		public function push(...args): void
		{
			var numArgs:int = args.length;
			var arg:*;
			var newNode:Node;
			
			for (var i:int; i < numArgs; ++i)
			{
				arg = args[i];
				newNode = new Node(arg);
				newNode.prev = this.tail;
				if (this.tail)
				{
					this.tail.next = newNode;
				}
				else
				{
					this.head = newNode;
				}
				this.tail = newNode;
			}
			this.length += numArgs;
		}
		
		public function reverse(): LinkedList
		{
			var front:Node = this.head;
			var back:Node = this.tail;
			var temp:*;
			while (front != back && back.prev != front)
			{
				temp = front.data;
				front.data = back.data;
				back.data = temp;
				
				front = front.next;
				back = back.prev;
			}
			
			return this;
		}
		
		public function shift(): *
		{
			if (this.head)
			{
				var ret:* = this.head.data;
				this.head = this.head.next;
				this.length--;
				return ret;
			}
			else
			{
				return undefined;
			}
		}
		
		public function slice(startIndex:int=0, endIndex:int=16777215): LinkedList
		{
			var ret:LinkedList = new LinkedList();
			if (startIndex >= this.length || endIndex <= startIndex)
			{
				return ret;
			}
			
			var cur:Node = this.head;
			var i:int;
			var newNode:Node;
			for (; i < startIndex && cur; ++i)
			{
				cur = cur.next;
			}
			for (; i < endIndex && cur; ++i)
			{
				newNode = new Node(cur.data);
				newNode.prev = ret.tail;
				if (ret.tail)
				{
					ret.tail.next = newNode;
				}
				else
				{
					ret.head = newNode;
				}
				ret.tail = newNode;
				cur = cur.next;
			}
			return ret;
		}
		
		public function some(callback:Function, thisObject:*=null): Boolean
		{
			var index:int;
			for (var cur:Node = this.head; cur; cur = cur.next)
			{
				if (callback.call(thisObject, cur.data, index, this))
				{
					return true;
				}
				index++;
			}
			return false;
		}
		
		public function sort(cmp:Function): void
		{
			var p:Node;
			var q:Node;
			var e:Node;
			var tail:Node;
			var oldhead:Node;
			var insize:int;
			var nmerges:int;
			var psize:int;
			var qsize:int;
			var i:int;
			var list:Node = this.head;
			
			/*
			* Silly special case: if `list' was passed in as null, return
			* null immediately.
			*/
			if (!list)
				return;
			
			insize = 1;
			
			while (1) {
				p = list;
				oldhead = list;               /* only used for circular linkage */
				list = null;
				tail = null;
				
				nmerges = 0;  /* count number of merges we do in this pass */
				
				while (p) {
					nmerges++;  /* there exists a merge to be done */
					/* step `insize' places along from p */
					q = p;
					psize = 0;
					for (i = 0; i < insize; i++) {
						psize++;
						q = q.next;
						if (!q) break;
					}
					
					/* if q hasn't fallen off end, we have two lists to merge */
					qsize = insize;
					
					/* now we have two lists; merge them */
					while (psize > 0 || (qsize > 0 && q)) {
						
						/* decide whether next element of merge comes from p or q */
						if (psize == 0) {
							/* p is empty; e must come from q. */
							e = q; q = q.next; qsize--;
						} else if (qsize == 0 || !q) {
							/* q is empty; e must come from p. */
							e = p; p = p.next; psize--;
						} else if (cmp(p.data,q.data) <= 0) {
							/* First element of p is lower (or same);
							* e must come from p. */
							e = p; p = p.next; psize--;
						} else {
							/* First element of q is lower; e must come from q. */
							e = q; q = q.next; qsize--;
						}
						
						/* add the next element to the merged list */
						if (tail) {
							tail.next = e;
						} else {
							list = e;
						}
						/* Maintain reverse pointers in a doubly linked list. */
						e.prev = tail;
						tail = e;
					}
					
					/* now p has stepped `insize' places along, and q has too */
					p = q;
				}
				tail.next = null;
				
				/* If we have done only one merge, we're finished. */
				if (nmerges <= 1)   /* allow for nmerges==0, the empty list case */
				{
					this.head = list;
					return;
				}
				
				/* Otherwise repeat, merging lists twice the size */
				insize *= 2;
			}
			
			this.head = list;
		}
		
		public function splice(startIndex:int, deleteCount:int, ...values): LinkedList
		{
			var ret:LinkedList = new LinkedList();
			var cur:Node = this.head;
			var endIndex:int = startIndex + deleteCount;
			var i:int;
			var newNode:Node;
			for (; i < startIndex && cur; ++i)
			{
				cur = cur.next;
			}
			for (; i < endIndex && cur; ++i)
			{
				// Push current node to spliced list
				newNode = new Node(cur.data);
				newNode.prev = ret.tail;
				if (ret.tail)
				{
					ret.tail.next = newNode;
				}
				else
				{
					ret.head = newNode;
				}
				ret.tail = newNode;
				
				// Unlink current node and move on
				cur.next = cur.next.next;
				cur.next.prev = cur;
				cur = cur.next;
			}
			this.length -= deleteCount;
			return ret;
		}
		
		public function toString(): String
		{
			if (!this.head)
			{
				return "";
			}
			
			var ret:String = "";
			for (var curNode:Node = this.head; curNode; curNode = curNode.next)
			{
				ret += curNode.data + ",";
			}
			return ret.substr(0, ret.length-1);
		}
		
		public function toLocaleString(): String
		{
			if (!this.head)
			{
				return "";
			}
			
			var ret:String = "";
			for (var curNode:Node = this.head; curNode; curNode = curNode.next)
			{
				ret += curNode.data + ",";
			}
			return ret.substr(0, ret.length-1);
		}
		
		public function unshift(...args): void
		{
			var numArgs:int = args.length;
			var arg:*;
			var newNode:Node;
			for (var i:int; i < numArgs; ++i)
			{
				arg = args[i];
				newNode = new Node(arg);
				newNode.next = this.head;
				if (this.head)
				{
					this.head.prev = newNode;
				}
				else
				{
					this.tail = newNode;
				}
				this.head = newNode;
			}
			this.length += numArgs;
		}
	}
}