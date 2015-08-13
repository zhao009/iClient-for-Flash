package com.supermap.web.mapping
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.sm_internal;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.events.*;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;
	import mx.events.*;
	
	import spark.effects.interpolation.NumberInterpolator;
	
	use namespace sm_internal;
	[DefaultProperty("heatPoints")]
	/**
	 * ${mapping_HeatMapLayer_Title}.
	 * <p>${mapping_HeatMapLayer_Description}</p>
	 * @see HeatPoint
	 * 
	 */	
	public class HeatMapLayer extends DynamicLayer
	{
		
		//bitmapdata的原点	
		private static const POINT:Point = new Point();
		
		/**
		 * true if the dataProvider has changed.
		 */
		private var collectionDirtyFlag:Boolean = true;
		
		/**
		 * @private
		 * A collection of Points extracted from the dataProvider
		 * 从所有的点集中裁剪出的最终需要渲染的点
		 */
		private var points:Array = [];
		
		/**
		 * 最终渲染成的BitmapData，位图图像数据
		 */
		private var heatBitmapData:BitmapData;
		
		private var _gradientArray:Array;
		private var _heatPoints:ArrayCollection;
		private var _radius:int = 25;
		private var _transformationFunction:Function = xyTransformationFunction;
		private var _image:Bitmap;
		private var _heatStops:Array;
		private var _maxValue:Number = 0;
		private var _geoToScreenRadius:int;
		
//		/**
//		 * ${mapping_HeatMapLayer_const_THERMAL_D} 
//		 */		
//		public static const THERMAL:Array = [0,167772262,336396403,504430711,672727155,857605496,1025311865,1193542778,1361445755,1529480062,1714226559,1882326399,2050229378,2218264197,2386232710,2571044231,2739013001,2906982028,3075081868,3243050383,3427796369,3595765395,3763734164,3931768213,4099736983,4284614554,4284745369,4284876441,4285007513,4285138585,4285334937,4285466009,4285597081,4285728153,4285924505,4286055577,4286186649,4286317721,4286514073,4286645145,4286776217,4286907289,4287103641,4287234713,4287365785,4287496857,4287693209,4287824281,4287955353,4288086425,4288283033,4288348568,4288414103,4288545431,4288610966,4288742293,4288807829,4288938900,4289004691,4289135763,4289201554,4289332625,4289398161,4289529488,4289595024,4289726351,4289791886,4289922958,4289988749,4290119820,4290185612,4290316683,4290382218,4290513546,4290579081,4290710409,4290776198,4290841987,4290907777,4290973822,4291039612,4291105401,4291171447,4291237236,4291303026,4291369071,4291434861,4291500650,4291566696,4291632485,4291698275,4291764320,4291830110,4291895899,4291961945,4292027734,4292093524,4292159569,4292225359,4292291148,4292422730,4292422983,4292489029,4292489282,4292555328,4292621118,4292621627,4292687417,4292753462,4292753972,4292819762,4292885807,4292886061,4292952106,4292952360,4293018406,4293084195,4293084705,4293150750,4293216540,4293217050,4293282839,4293348885,4293349138,4293415184,4293481230,4293481485,4293481996,4293547788,4293548299,4293614091,4293614602,4293614858,4293680905,4293681416,4293747208,4293747719,4293747975,4293814022,4293814278,4293880325,4293880581,4293881092,4293947139,4293947395,4294013442,4294013698,4294014209,4294080001,4294080512,4294146560,4294146816,4294147328,4294213376,4294213632,4294214144,4294280192,4294280704,4294280960,4294347008,4294347520,4294347776,4294413824,4294414336,4294480384,4294480640,4294481152,4294547200,4294547456,4294547968,4294614016,4294614528,4294614784,4294680832,4294681344,4294747392,4294747648,4294747904,4294748416,4294748672,4294749184,4294749440,4294749952,4294750208,4294750464,4294750976,4294751232,4294751744,4294752000,4294752512,4294752768,4294753280,4294753536,4294753792,4294754304,4294754560,4294755072,4294755328,4294755840,4294756096,4294756608,4294756869,4294757130,4294757391,4294757652,4294757913,4294758174,4294758435,4294758696,4294758957,4294759219,4294759480,4294759741,4294760258,4294760519,4294760780,4294761041,4294826838,4294827099,4294827360,4294827622,4294827883,4294828144,4294828405,4294828666,4294829183,4294829444,4294829705,4294829966,4294830227,4294830489,4294830750,4294831011,4294831272,4294897069,4294897330,4294897591,4294897852,4294898369,4294898630,4294898892,4294899153,4294899414,4294899675,4294899936,4294900197,4294900458,4294900719,4294900980,4294901241,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295];
//		/**
//		 * ${mapping_HeatMapLayer_const_RAINBOW_D} 
//		 */		
//		public static const RAINBOW:Array = [0,167772415,335544575,503316726,671088889,855638261,1023410423,1191182584,1358954741,1526726902,1711276277,1879048438,2046820599,2214592757,2382364918,2566914293,2734686453,2902458614,3070230773,3238002934,3422552309,3590324469,3758096630,3925868788,4093640949,4278190326,4278191862,4278193398,4278195190,4278196726,4278198518,4278200054,4278201590,4278203382,4278204918,4278206710,4278208246,4278209782,4278211574,4278213110,4278214902,4278216438,4278217974,4278219766,4278221302,4278223094,4278224630,4278226166,4278227958,4278229494,4278296822,4278232053,4278232821,4278233588,4278234356,4278235124,4278235891,4278236659,4278237426,4278238194,4278238962,4278239729,4278240497,4278241264,4278242032,4278242800,4278243567,4278244335,4278245102,4278245870,4278246638,4278247405,4278248173,4278248940,4278249708,4278250732,4278250722,4278250969,4278251215,4278251462,4278251452,4278251699,4278251945,4278252192,4278252183,4278252429,4278252676,4278252922,4278252913,4278253159,4278253406,4278253652,4278253643,4278253890,4278254136,4278254383,4278254373,4278254620,4278254866,4278255113,4278255360,4278910720,4279566080,4280221440,4280876800,4281597696,4282253056,4282908416,4283563776,4284219136,4284940032,4285595392,4286250752,4286906112,4287561472,4288282368,4288937728,4289593088,4290248448,4290903808,4291624704,4292280064,4292935424,4293590784,4294246144,4294967040,4294900736,4294834432,4294768384,4294702080,4294636032,4294569728,4294503680,4294437376,4294371328,4294305024,4294238976,4294172672,4294106624,4294040320,4293974272,4293907968,4293841920,4293775616,4293709568,4293643264,4293577216,4293510912,4293444864,4293378560,4293378048,4293377536,4293442560,4293507584,4293572608,4293637632,4293702656,4293767680,4293832704,4293897728,4293962752,4294027776,4294092800,4294158080,4294223104,4294288128,4294353152,4294418176,4294483200,4294548224,4294613248,4294678272,4294743296,4294808320,4294873344,4294938624,4294937088,4294935552,4294934016,4294932480,4294931200,4294929664,4294928128,4294926592,4294925312,4294923776,4294922240,4294920704,4294919424,4294917888,4294916352,4294914816,4294913536,4294912000,4294910464,4294908928,4294907648,4294906112,4294904576,4294903040,4294901760,4294903045,4294904330,4294905615,4294906900,4294908185,4294909470,4294910755,4294912040,4294913325,4294914867,4294916152,4294917437,4294918722,4294920007,4294921292,4294922577,4294923862,4294925147,4294926432,4294927974,4294929259,4294930544,4294931829,4294933114,4294934399,4294935684,4294936969,4294938254,4294939539,4294941081,4294942366,4294943651,4294944936,4294946221,4294947506,4294948791,4294950076,4294951361,4294952646,4294954188,4294955473,4294956758,4294958043,4294959328,4294960613,4294961898,4294963183,4294964468,4294965753,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295];
//		/**
//		 * ${mapping_HeatMapLayer_const_RED_WHITE_BLUE_D} 
//		 */		
//		//public static const RED_WHITE_BLUE:Array = [0,50331903,100663551,167772415,218104063,285212927,335544575,385876223,452985077,503316726,570425591,620757240,671088889,738197753,788529401,855638266,905969914,956301562,1023410427,1073742071,1140850935,1191182584,1241514232,1308623096,1358954744,1426063609,1476395257,1526726905,1593835770,1644167418,1711276282,1761607930,1811939578,1879048440,1929380090,1996488954,2046820603,2097152251,2164261113,2214592761,2281701625,2332033273,2382364923,2449473787,2499805436,2566914298,2617245946,2667577594,2734686458,2785018106,2852126972,2902458620,2952790267,3019899132,3070230780,3137339644,3187671292,3238002939,3305111803,3355443452,3422552316,3472883964,3523215612,3590324477,3640656124,3707764988,3758096636,3808428285,3875537149,3925868797,3992977662,4043309309,4093640957,4160749822,4211081470,4278190335,4278386939,4278583544,4278845684,4279042289,4279304430,4279501034,4279697639,4279959779,4280156384,4280418525,4280615129,4280811734,4281073874,4281270479,4281532620,4281729224,4281925829,4282187969,4282384574,4282646715,4282843319,4283039924,4283302064,4283498669,4283760810,4283957414,4284154019,4284416159,4284612764,4284874905,4285071509,4285268114,4285530254,4285726859,4285989000,4286185604,4286382209,4286644349,4286840954,4287103095,4287299699,4287496304,4287758444,4287955049,4288217190,4288413794,4288610399,4288872539,4289069144,4289331285,4289527889,4289724494,4289986634,4290183239,4290445380,4290641984,4290838589,4291100729,4291297334,4291559475,4291756079,4291952684,4292214824,4292411429,4292673570,4292870174,4293066779,4293328919,4293525524,4293787665,4293984269,4294180874,4294443014,4294639619,4294901760,4294902531,4294903302,4294904330,4294905101,4294906129,4294906900,4294907671,4294908699,4294909470,4294910498,4294911269,4294912040,4294913068,4294913839,4294914867,4294915638,4294916409,4294917437,4294918208,4294919236,4294920007,4294920778,4294921806,4294922577,4294923605,4294924376,4294925147,4294926175,4294926946,4294927974,4294928745,4294929516,4294930544,4294931315,4294932343,4294933114,4294933885,4294934913,4294935684,4294936712,4294937483,4294938254,4294939282,4294940053,4294941081,4294941852,4294942623,4294943651,4294944422,4294945450,4294946221,4294946992,4294948020,4294948791,4294949819,4294950590,4294951361,4294952389,4294953160,4294954188,4294954959,4294955730,4294956758,4294957529,4294958557,4294959328,4294960099,4294961127,4294961898,4294962926,4294963697,4294964468,4294965496,4294966267,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295];              
//		
//		public static const RED_WHITE_BLUE:Array = [0, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 0xffff0000, 
//														0xff00ff00, 0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,0xff00ff00,
//														0xff0000ff, 0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff]
//														
		/**
		 * ${mapping_HeatMapLayer_constructor_None_D} 
		 * 
		 */		
		public function HeatMapLayer()
		{
			mouseEnabled = false;
			cacheAsBitmap = true;
			this._gradientArray = [];
			this.heatStops = [new HeatStop(0x0000e300, 0), new HeatStop(0xFF27830b, 0.3), new HeatStop(0xFFFFFF00, 0.75), new HeatStop(0xFFFF0000, 1)];
			this._heatPoints = new ArrayCollection();
			addEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
			this._heatPoints.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
		}
		
		
		/**
		 * 这里对象的类型很广泛，可以是Array/arrayCllection/或者是有x/y属性的任意object都行
		 */
		[Bindable]
		/**
		 * ${mapping_HeatMapLayer_attribute_heatPoints_D} 
		 * @return 
		 * 
		 */		
		public function get heatPoints():Object
		{
			return this._heatPoints;
		}		
		public function set heatPoints(value:Object):void
		{
			var heatPoints:Array;
			if (this._heatPoints)
			{
				this._heatPoints.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
			}
			
			if (value is Array)
			{
				this._heatPoints = new ArrayCollection(value as Array);
			}
			else if (value is ArrayCollection)
			{
				this._heatPoints = value as ArrayCollection;
			}
			else
			{
				heatPoints = [];
				if (value != null)
				{
					heatPoints.push(value);
				}
				this._heatPoints = new ArrayCollection(heatPoints);
			}
			
			this._heatPoints.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
			var event:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
			this.collectionChangeHandler(event);			
			invalidateLayer();
		}
		
		//heatstops中元素需按heatstop的offset由小到大排列
		//最高支持的HeatStop数目为256，大于256的部分将会被忽略
		[ArrayElementType("com.supermap.web.mapping.HeatStop")] 
		[Bindable]
		/**
		 * ${mapping_HeatMapLayer_attribute_heatStops_D}.
		 * <p>${mapping_HeatMapLayer_attribute_heatStops_reamarks}</p>
		 * @see HeatStop 
		 * @return 
		 * 
		 */		
		public function get heatStops():Array
		{
			return _heatStops;
		}
		public function set heatStops(value:Array):void
		{
			if(value && _heatStops !== value)
			{
				_heatStops = value;
				_heatStops.sort(compareHeatStop);
				this.interpolateColor();
				this._gradientArray[0] = 0;  //保证背景是透明的
				invalidateLayer();
			}
		}
		
		
		[Bindable]
		/**
		 * The radius of each item drawn on the heat map.
		 * 热点圆的半径
		 */
		/**
		 * ${mapping_HeatMapLayer_attribute_radius_D} 
		 * @return 
		 * 
		 */		
		public function get radius():int
		{
			return _radius;
		}
		public function set radius(value:int):void
		{
			if(_radius != value)
			{
				_radius = value;
				invalidateLayer();
			}
		}
		
		
		
		/**
		 * 转换函数：用户可自定义，将需表达热点区域的变量转换成可在地图上表示的位置（x、y）
		 * 如：某一只股票有三个变量：股价、时间、交易量，
		 * 那么可以将股价与时间分别对应与x、y值，交易量代表value（热度）
		 */
		[Bindable(event="transformationFunctionChange")]
		/**
		 * ${mapping_HeatMapLayer_attribute_transformationFunction_D}.
		 * <p>${mapping_HeatMapLayer_attribute_transformationFunction_remarks}</p>
		 * <code>private function transformationFunction(o:Object):HeatPoint
		 * 	{
		 *       var point:Point = this.map.mapToScreen(new Point2D(o["x"], o["y"]));
		 *		var value:Number = 1;
		 *		if(o.hasOwnProperty("value"))
		 *		{
		 * 			value = o["value"];
		 *		}
		 *		return new HeatPoint(point.x, point.y, value);
		 *	}</code>
		 * 
		 * @see HeatPoint
		 */		
		public function set transformationFunction(value:Function):void
		{
			if(value != _transformationFunction)
			{
				_transformationFunction = value;
				collectionDirtyFlag = true;
				invalidateDisplayList();
				dispatchEvent(new Event("transformationFunctionChange"));
			}
		}
		public function get transformationFunction():Function
		{
			return _transformationFunction;
		}
		
		//按heatstop的offset值进行比较
		private function compareHeatStop(stop1:HeatStop, stop2:HeatStop) : int
		{
			if(stop1.offset > stop2.offset)
			{
				return 1;
			}
			else if(stop1.offset == stop2.offset)
			{
				return 0;
			}
			else
			{
				return -1;
			}
		}
		
		/**
		 * 如果数据改变了，得重绘
		 */
		private function collectionChangeHandler(event:CollectionEvent):void
		{
			dispatchEvent(event);
			collectionDirtyFlag = true;
			invalidateLayer();		
		}	
		
		
		//对颜色进行插值
		private function interpolateColor():void
		{
			var length:int = this.heatStops.length > 256 ? 256 : this.heatStops.length;
			if(length < 1)
			{
				return;
			}
			else if(length == 1)
			{
				
				for(var k:int = 0; k < 256; k++)
				{
					this._gradientArray[k] = [heatStops[0].color];
				}
				
			}
			else
			{
				for(var i:int = 0; i < length-1;)
				{
					var start:int = int(heatStops[i].offset * 256);
					var startColor:uint = heatStops[i].color;
					if(i == 0 && start != 0)
					{
						for(var j:int = 0; j < start; j++)
						{
							this._gradientArray[j] = startColor;
						}
					}
					var end:int = int(heatStops[++i].offset * 256);
					var endColor:uint = heatStops[i].color;
					if(start >= end)
					{
						this._gradientArray[start] = startColor;
						continue;
					}
					this.addColor(startColor, start, endColor, end);
					if(i == length-1 && end != 1)
					{
						for(j = end; j < 255; j++)
						{
							this._gradientArray[j] = endColor;
						}
					}
				}
			}
		}		
		private function addColor(startColor:uint, startIndex:int, endColor:uint, endIndex:int) : void
		{
			//var startRGBColor:uint =  startColor & 0x00FFFFFF;
			var startR:uint = (startColor >> 16) & 0xFF;
			var startG:uint = (startColor >> 8) & 0xFF;
			var startB:uint = startColor & 0xFF;
			//var endRGBColor:uint =  endColor & 0x00FFFFFF;
			var endR:uint = (endColor >> 16) & 0xFF;
			var endG:uint = (endColor >> 8) & 0xFF;
			var endB:uint = endColor & 0xFF;
			var startAlpha:uint = (startColor >> 24) & 0xFF;
			var endAlpha:uint = (endColor >> 24) & 0xFF; 
			for(var i:int = startIndex; i <= endIndex; i++)
			{
				var fac:Number = (i - startIndex) / (endIndex - startIndex);				
				//var rgb:Number = RGBInterpolator.getInstance().interpolate(fac, startRGBColor, endRGBColor) as Number;
				var r:Number = NumberInterpolator.getInstance().interpolate(fac, startR, endR) as Number;
				var g:Number = NumberInterpolator.getInstance().interpolate(fac, startG, endG) as Number;
				var b:Number = NumberInterpolator.getInstance().interpolate(fac, startB, endB) as Number;
				var alpha:Number = NumberInterpolator.getInstance().interpolate(fac, startAlpha, endAlpha) as Number;
				this._gradientArray[i] = (alpha << 24) | (r << 16) | (g << 8) | b;
			}
		}

		
		private function creationCompleteHandler(event:FlexEvent) : void
		{
			removeEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
			setLoaded(true);
		}
		
		/**
		 * 默认的xy转换函数，把object中的x/y/value属性提取出来构造heatPoint（x,y,value）
		 */
		private function xyTransformationFunction(o:Object):HeatPoint
		{
			var x:Number = this.map.mapToScreenX2(o["x"]);
			var y:Number = this.map.mapToScreenY2(o["y"]);
			var value:Number = 1;
			if(o.hasOwnProperty("value"))
			{
				value = o["value"];
			}
			return new HeatPoint(x, y, value, o.geoRadius);
		}


		/**
		 * @private
		 * 
		 */		
		override public function invalidateProperties():void
		{
			super.invalidateProperties();
			collectionDirtyFlag = true;
			invalidateLayer();
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function draw() : void
		{
			if(!map || map.isTweening || map.isPanning || map.isResizing)
			{
				return;
			}

			updatePoints();
			graphics.clear();
			drawHeatMap();          
			removeAllChildren();
			
			if(heatBitmapData)
			{
				if(!this._image)
				{
					this._image = new Bitmap();
				}
				
				this._image.bitmapData = heatBitmapData;
				
				//因为坐标转换的时候没有算裁剪值，所以这里得加回来
				this._image.x = this.map.scrollRectX;
				this._image.y = this.map.scrollRectY;
				
				this.addChild(this._image);	
			}
			addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
		}
			
		private function enterFrameHandler(event:Event) : void
		{
			removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
			dispatchEvent(new LayerEvent(LayerEvent.UPDATE_END, this, null, true));		
		}
		
		/**
		 * ${mapping_FeatureLayer_method_updatePoints_D} 
		 * <p>${mapping_FeatureLayer_method_updatePoints_remarks}</p>
		 * @see HeatPoint#Value
		 * @see HeatPoint
		 * 
		 */		
		protected function updatePoints():void
		{
			if(this._heatPoints != null && this._heatPoints.length > 0)
			{
				var rect2D:Rectangle2D = new Rectangle2D(0, 0, this.map.width, this.map.height);
//				rect2D.inflate(_screenRadius, _screenRadius);

				points = [];
				this._maxValue = 0;
				for each(var o:Object in _heatPoints)
				{
					var heatpoint:HeatPoint = transformationFunction.apply(this, [o]);
					var point:Point2D = heatpoint.point2D;
					if(rect2D.containsPoint(point))
					{
						this._maxValue = (this._maxValue < heatpoint.value) ? heatpoint.value : this._maxValue;
						points.push(heatpoint);
					}				
				}
				for each(var hp:HeatPoint in points)
				{		
					hp.value = hp.value * 256 / this._maxValue;	
				}
			}
		}
		
		/**
		 * ${mapping_FeatureLayer_method_drawHeatMap_D}
		 */
		protected function drawHeatMap():void
		{
			var width:Number = 0;
			var height:Number = 0;
			if(map && map.width > 0 && map.height > 0)
			{
				width = this.map.width;
			    height = this.map.height;
			}
			
			//bitmapdata支持的最大位数为2880*2880*32bit
			if(width > 2880 || width <= 0 || height > 2880 || height <= 0 || points == null)
			{
				if(heatBitmapData)
					heatBitmapData.dispose();
				return;
			}
			
			if(!heatBitmapData || heatBitmapData.width != width || heatBitmapData.height != height)
			{			
				if(heatBitmapData)
				{
					heatBitmapData.dispose();
				}
				heatBitmapData = new BitmapData(width,height,true,0x00000000);
			}
			else
			{
				heatBitmapData.fillRect(new Rectangle(0, 0, width, height),0x00000000);
			}
				
			var translationMatrixWhole:Matrix = new Matrix();
			
			for each(var point:HeatPoint in points)
			{
				var heatMapShape:Shape = new Shape();
				if(point.geoRadius)
					this._geoToScreenRadius = point.geoRadius / this.map.resolution;
				else
					_geoToScreenRadius = this._radius;
				
				var boxRadius:Number = _geoToScreenRadius + 1;
				
				if(boxRadius < 1440)
				{
					var cellSize:int = boxRadius * 2;
					var m:Matrix = new Matrix();
					m.createGradientBox(cellSize, cellSize, 0, -boxRadius, -boxRadius);
					
					var translationMatrix:Matrix = new Matrix();
					translationMatrix.tx = boxRadius;
					translationMatrix.ty = boxRadius;
					
					heatMapShape.graphics.beginGradientFill(GradientType.RADIAL, [point.value - 1, 0], [1, 1], [0,255], m, "pad", "rgb");
					heatMapShape.graphics.drawCircle(0,0,_geoToScreenRadius);
					heatMapShape.graphics.endFill();
					
					
					var heatMapItem:BitmapData = new BitmapData(cellSize, cellSize, true, 0x00000000);
					heatMapItem.draw(heatMapShape,translationMatrix);
					translationMatrixWhole.tx = point.x - boxRadius;
					translationMatrixWhole.ty = point.y - boxRadius;
					heatBitmapData.draw(heatMapItem, translationMatrixWhole, null, BlendMode.SCREEN);		
					
					heatMapShape.graphics.clear();
					heatMapItem.dispose();
				}
			}
			
			
			// 权值过小的点就设成全透明
			heatBitmapData.threshold(heatBitmapData, heatBitmapData.rect, POINT, "<=", 0x00000003, 0x00000000, 0x000000FF, true);
			
			// 将像素点的热度替换成渐变颜色值，支持256中颜色
			heatBitmapData.paletteMap(heatBitmapData, heatBitmapData.rect, POINT, null, null, _gradientArray, null);
			
			// 平滑渐变效果
			heatBitmapData.applyFilter(heatBitmapData, heatBitmapData.rect, POINT, new BlurFilter(4,4));
		}
	}

	
}