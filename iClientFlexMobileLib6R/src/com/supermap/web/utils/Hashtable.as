package com.supermap.web.utils
{
	import flash.utils.Dictionary;

	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	public class Hashtable
	{
        private var keys:Dictionary;
        private var dups:Dictionary;        
        private var initSize:int;        
        private var maxSize:int;        
        private var hashSize:int;
        private var item:Object = {key: null, obj: null, prev: null, next: null};        
        private var headItem:Object = {key: null, obj: null, prev: null, next: null};        
        private var tailItem:Object = {key: null, obj: null, prev: null, next: null};

		//构造函数
        public function Hashtable(size:int = 500)
        {
            initSize = maxSize = Math.max(10, size);
            
            keys = new Dictionary(true);
            dups = new Dictionary(true);
            hashSize = 0;
            
            var node:Object = {key: null, obj: null, prev: null, next: null};
            headItem = tailItem = node;
            
            var k:int = initSize + 1;
            for (var i:int = 0; i < k; i++)
            {
                node.next = {key: null, obj: null, prev: null, next: null};
                node = node.next;
            }
            tailItem = node;
        }
		
		//添加键与值
        public function add(key:*, obj:*):Boolean
        {
            if (key == null)  return false;
            if (obj == null)  return false;
            if (keys[key]) return false;
            
            if (hashSize++ == maxSize)
            {
                var k:int = (maxSize += initSize) + 1;
                for (var i:int = 0; i < k; i++)
                {
                    tailItem.next = {key: null, obj: null, prev: null, next: null};
                    tailItem = tailItem.next;
                }
            }
            
            var pair:Object = {key: null, obj: null, prev: null, next: null};
            headItem = headItem.next;
            pair.key = key;
            pair.obj = obj;
            
            pair.next = pair;
            if (pair) pair.prev = pair;
            pair = pair;
            
            keys[key] = pair;
            dups[obj] ? dups[obj]++ : dups[obj] = 1;
            
            return true;
        }

		//根据键返回对应的值
        public function find(key:*):*
        {
            var pair:Object = keys[key];
            if (pair) return pair.obj;
            return null;
        }
        
		//根据值返回键
		public function retureKey(obj:*):*
		{
			var key:*;
			for each(var objKey:* in keys)
			{
				if(objKey.obj == obj)					
					return objKey.key;
			}
			return null;
		}
		
		//移除键值对
        public function remove(key:*):*
        {
            var pair:Object = keys[key];
            if (pair)
            {
                var obj:* = pair.obj;
                
                delete keys[key];
                
                if (pair.prev) pair.prev.next = pair.next;
                if (pair.next) pair.next.prev = pair.prev;
                if (pair == pair) pair = pair.next;
                
                pair.prev = null;
                pair.next = null;
                tailItem.next = pair;
                tailItem = pair;
                
                if (--dups[obj] <= 0)
                    delete dups[obj];
                
                if (--hashSize <= (maxSize - initSize))
                {
                    var k:int = (maxSize -= initSize) + 1;
                    for (var i:int = 0; i < k; i++)
                        headItem = headItem.next;
                }
                
                return obj;
            }
            return null;
        }
        
		//判断是不是包含某个键
        public function containsKey(key:*):Boolean
        {
            return keys[key] != undefined;
        }
        
        public function getKeySet():Array
        {
            var a:Array = new Array(hashSize), i:int;
            for each (var p:Object in keys)
                a[i++] = p.key;
            return a;
        }
        
		//判断是不是包含某个值
        public function contains(obj:*):Boolean
        {
            return dups[obj] > 0;
        }
        
		//清空
        public function clear():void
        {
            keys = new Dictionary(true);
            dups = new Dictionary(true);
            
            var t:Object;
            var n:Object = item;
            while (n)
            {
                t = n.next;
                
                n.next = n.prev = null;
                n.key = null;
                n.obj = null;
                tailItem.next = n;
                tailItem = tailItem.next;
                
                n = t;
            }
            
            item = null;
            hashSize = 0;
        }
		
		//获取键值对的总个数
        public function get size():int
        {
	            return hashSize;
		}
	        
		//是否为空
        public function isEmpty():Boolean
        {
            return hashSize == 0;
        }
        
		//转化为数组
        public function toArray():Array
        {
            var a:Array = new Array(hashSize), i:int;
            for each (var p:Object in keys)
                a[i++] = p.obj;
            return a;
        }
        
        public function toString():String
        {
            return "[Hashtable, size=" + size + "]";
        }
	}
}