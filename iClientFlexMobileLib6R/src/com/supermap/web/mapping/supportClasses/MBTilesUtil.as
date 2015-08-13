package com.supermap.web.mapping.supportClasses
{
	import com.supermap.web.sm_internal;
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.errors.SQLError;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.flash_proxy;
	
	import mx.controls.SWFLoader;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.graphics.ImageSnapshot;
	import mx.graphics.codec.PNGEncoder;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.primitives.Rect;

	use namespace sm_internal;

	/**
	 * MBTile图块信息管理工具,负责图层信息的读取和编辑<br>
	 * 通过db文件路径来获取数据信息,filepath设置数据库文件路径，使用前要调用open(),连接成功后才能进行下一步操作，如果不在需要连接可以调用close()关闭
	 * */
	public class MBTilesUtil
	{
		private var dbConn:SQLConnection;

		//二进制文件来源，是AS写入的还是其他，控制查询参数
		public static var _bytefromIsAS:Boolean=false;

		private var _dbFilePath:String="";

		private var _status:String="";
		private var _opened:Boolean=false;

		/**
		 *
		 * */
		public function MBTilesUtil(filePath:String)
		{
			_dbFilePath=filePath;
		}

		public function get opened():Boolean
		{
			return _opened;
		}

		/**
		 * 连接数据库，返回true表示成功
		 * */
		public function open():Boolean
		{
			//var dbfile:File=File.applicationStorageDirectory.resolvePath(_dbFilePath); //对应应用程序安装路径
			var dbfile:File = File.documentsDirectory.resolvePath(_dbFilePath);//对应sdcard的目录
			dbConn=new SQLConnection;
			try
			{
				dbConn.open(dbfile, SQLMode.READ);
				_opened=true;
				return true;
			}
			catch (error:Error)
			{
				_status="数据库文件不存在";
			}
			return false;
		}

		/**
		 * 断开数据库连接，操作成功返回true
		 * */
		public function close():Boolean
		{
			try
			{
				if (null != dbConn && _opened)
				{
					dbConn.close();
					_opened=false;
				}

				dbConn=null;
				return true;
			}
			catch (error:Error)
			{
				_status="连接失败";
			}
			return false;
		}

		/**
		 * 获取
		 * */
		public function getTile(row:int, col:int, resolution:Number):ByteArray
		{
			var stmtTemp:SQLStatement=new SQLStatement;
			//查询，通过:XXX来设置参数
			var sql:String="";
			if (_bytefromIsAS)
			{
				sql="SELECT tile_data FROM tiles" + " where tile_row = :tile_row AND tile_column = :tile_column AND resolution = :resolution";
			}
			else
			{
				sql="SELECT CAST(tile_data AS ByteArray) AS tile_data FROM tiles" + " where tile_row = :tile_row AND tile_column = :tile_column AND resolution = :resolution";

			}
			stmtTemp.text=sql;
			stmtTemp.parameters[":tile_row"]=row;
			stmtTemp.parameters[":tile_column"]=col;
			stmtTemp.parameters[":resolution"]=resolution;
			stmtTemp.sqlConnection=dbConn;
			try
			{
				stmtTemp.execute();
				var result:SQLResult=stmtTemp.getResult();
				var data:Array=result.data;
				//查询，结果并转换为所需要的格式
				if (null != data && 1 == data.length)
				{
					var byteArray:ByteArray=result.data[0].tile_data;
					return byteArray;
				}
				else
				{
					_status="查询结果为空";
				}
			}
			catch (error:SQLError)
			{
				_status="查询出错" + error.message;
			}
			return null;
		}

		/**
		 * 添加信息
		 * @param row 行序号，从0开始
		 * @param col 列序号，从0开始
		 * @param level 分块级别
		 * @param bytes 当前行列，级别对应图块的二进制文件
		 * @return 返回操作时否成功标记
		 * */
		public function insertTile(row:int, col:int, level:int, resolution:Number, bytes:ByteArray):Boolean
		{

			if (null == bytes)
			{
				_status="存储数据为空";
				return false;
			}
			var insertStmt:SQLStatement=new SQLStatement();
			insertStmt.sqlConnection=dbConn;
			var sql:String="INSERT INTO tiles (tile_row, tile_column, zoom_level, tile_data) " + "values(:tile_row, :tile_column, :zoom_level, :resolution, :tile_data);";

			insertStmt.text=sql;
			insertStmt.parameters[":tile_row"]=row;
			insertStmt.parameters[":tile_column"]=col;
			insertStmt.parameters[":zoom_level"]=level;
			insertStmt.parameters[":resolution"]=resolution;
			insertStmt.parameters[":tile_data"]=bytes;

			try
			{
				insertStmt.execute();
				return true;
			}
			catch (error:SQLError)
			{
				_status="存储失败" + error.message;
			}
			return false;
		}

		/**
		 * 修改信息，这里只允许对图块信息进行编辑
		 * @param row 行序号，从0开始
		 * @param col 列序号，从0开始
		 * @param level 分块级别
		 * @param bytes 当前行列，级别对应图块的二进制文件
		 * @return 返回操作时否成功标记
		 * */
		public function setTile(row:int, col:int, level:int, bytes:ByteArray):Boolean
		{
			if (null == bytes)
			{
				_status="存储数据为空";
				return false;
			}
			var updateStmt:SQLStatement=new SQLStatement();
			updateStmt.sqlConnection=dbConn;
			var sql:String="update tiles set tile_data = :tile_data" + " where tile_row = :tile_row AND tile_column = :tile_column AND zoom_level = :zoom_level";

			updateStmt.text=sql;
			updateStmt.parameters[":tile_data"]=bytes;
			updateStmt.parameters[":tile_row"]=row;
			updateStmt.parameters[":tile_column"]=col;
			updateStmt.parameters[":zoom_level"]=level;
			try
			{
				updateStmt.execute();
				return true;
			}
			catch (error:SQLError)
			{
				_status="存储失败" + error.message;
			}
			return false;
		}

		/**
		 * 删除图块信息,后面完善考虑整个级别删除，整行删除，整列删除等功能
		 * @param row 行序号，从0开始
		 * @param col 列序号，从0开始
		 * @param level 分块级别
		 * @return 返回操作时否成功标记
		 * */
		public function deleteTile(row:int, col:int, resolution:Number):Boolean
		{
			var deleteStmt:SQLStatement=new SQLStatement();
			deleteStmt.sqlConnection=dbConn;
			var sql:String="delete from tiles" + " where tile_row = :tile_row AND tile_column = :tile_column AND resolution = :resolution";

			deleteStmt.text=sql;
			deleteStmt.parameters[":tile_row"]=row;
			deleteStmt.parameters[":tile_column"]=col;
			deleteStmt.parameters[":resolution"]=resolution;
			try
			{
				deleteStmt.execute();
				return true;
			}
			catch (error:SQLError)
			{
				_status="存储失败" + error.message;
			}
			return false;
		}


		/**
		 * 读取当前的tiles数据库元数据信息，以供出图过程中使用;<br>关于Metadata的使用，请查看MetaDataObj的相关属性
		 * */
		public function readMetadataObj():MetadataObj
		{

			var stmtTemp:SQLStatement=new SQLStatement;
			//查询，通过:XXX来设置参数
			var sql:String="select * from metadata";
			stmtTemp.text=sql;
			stmtTemp.sqlConnection=dbConn;
			try
			{
				stmtTemp.execute();
				var result:SQLResult=stmtTemp.getResult();
				var data:Array=result.data;
				if (data.length < 5)
				{
					_status="信息确实";
					return null;
				}

				//根据查询信息，构建metadata对象
				var metadata:MetadataObj=new MetadataObj;
				for (var i:int=0; i < data.length; i++)
				{
					var obj:Object=data[i];
					var key:String=String(obj.name).toLowerCase();
					var value:String=data[i].value as String;
					switch (key)
					{
						case "bounds":
							metadata.bounds=metadata.getLayerBounds(value);
							break;
						case "name":
							metadata.name=value;
							break;
						case "type":
							metadata.type=value;
							break;
						case "version":
							metadata.version=value;
							break;
						case "description":
							metadata.description=value;
							break;
						case "format":
							metadata.format=value;
							break;
//						
//						case "tag":
//							metadata.tag = value;
//							break;
						case "resolutions":
							metadata.resolutions=metadata.getResolutionsFromStr(value);
							break;
						case "scales":
							metadata.scales=metadata.getScalesFromStr(value);
							break;
						case "crs_wkid":
							metadata.crs_wkid=int(value);
							break;
						case "crs_wkt":
							/*2013.3.19//todo：通过获取到的crs_wkt解析出想要的unit的值*/
							var unitStr:String = value.slice(value.lastIndexOf("UNIT"), -1);
							metadata.unit = comfirmUnit(unitStr);
							break;
						case "compatible":
							metadata.compatible=(value == "true");
							break;
						// 通过metadata中的tile_height来确定瓦片大小
						case "tile_height":
							metadata.tileSize = int(value);
							break;
						default:
							metadata.addAttribution(data.name, data[i].value);
							break;
					}
				}
				//设备最大最小级别
//				setLevel(metadata);//不需要这一步，SQL操作在数据量大的时候，太慢影响加载速度
				return metadata;
			}
			catch (error:SQLError)
			{
				_status="查询出错" + error.message;
			}
			return null;
		}
		
		private function comfirmUnit(unitStr:String):String
		{
			var unit:String;
			if(unitStr.indexOf("METER")>0)
			{
				unit = "meter";
			}
			else if(unitStr.indexOf("DEGREE")>0)
			{
				unit = "degree";
			}
			else if(unitStr.indexOf("DECIMAL_DEGREE")>0)
			{
				unit = "decimal_degree";
			}
			else if(unitStr.indexOf("CENTIMETER")>0)
			{
				unit = "centimeter";
			}
			else if(unitStr.indexOf("DECIMETER")>0)
			{
				unit = "decimeter";
			}
			else if(unitStr.indexOf("FOOT")>0)
			{
				unit = "foot";
			}
			else if(unitStr.indexOf("INCH")>0)
			{
				unit = "inch";
			}
			else if(unitStr.indexOf("KILOMETER")>0)
			{
				unit = "kilometer";
			}
			else if(unitStr.indexOf("MILE")>0)
			{
				unit = "mile";
			}
			else if(unitStr.indexOf("MILIMETER")>0)
			{
				unit = "milimeter";
			}
			else if(unitStr.indexOf("MINUTE")>0)
			{
				unit = "minute";
			}
			else if(unitStr.indexOf("RADIAN")>0)
			{
				unit = "radian";
			}
			else if(unitStr.indexOf("SECOND")>0)
			{
				unit = "second";
			}
			else if(unitStr.indexOf("YARD")>0)
			{
				unit = "yard";
			}
			return unit;
		}

		private function setLevel(metadata:MetadataObj):void
		{
			var sqlStatement:SQLStatement=new SQLStatement;
			var sql:String="select min(zoom_level) minlevel,max(zoom_level) maxlevel from tiles";
			sqlStatement.text=sql;
			sqlStatement.sqlConnection=dbConn;
			try
			{
				sqlStatement.execute();
				var result:SQLResult=sqlStatement.getResult();
				var data:Array=result.data;
				if (data.length < 0)
					return;
				metadata.minzoom=data[0].minlevel;
				metadata.maxzoom=data[0].maxlevel;
			}
			catch (error:SQLError)
			{
				_status="查询出错" + error.message;
			}
		}
		
		/**
		 * 
		 * 
		 * */

		/**
		 * 更改tiles中的元数据信息，比如添加图层级别，添加分辨率级别等则需要刷新元素数据参数
		 * */
		public function writeMetadataObj(metadataObj:MetadataObj):Boolean
		{
			if (null == metadataObj)
			{
				return false;
			}
			if (!clearMetadata())
			{
				return false;
			}
			var stmtTemp:SQLStatement=new SQLStatement;
			stmtTemp.sqlConnection=dbConn;
			try
			{
				var sql:String="insert into metadata (name, value) values (:name , :value);";
				stmtTemp.text=sql;
				//存数主标签信息
				var staticAtt:Dictionary=metadataObj.staticAttribution;
				var key:Object;
				for (key in staticAtt)
				{
					stmtTemp.parameters[":name"]=key;
					stmtTemp.parameters[":value"]=staticAtt[key];
					stmtTemp.execute();
				}

				//存储其他补充信息
				var att:Dictionary=metadataObj.attribution;
				var value:String;
				for (key in att)
				{
					value=att[key];
					if (null == value || 0 == value.length)
						continue;
					stmtTemp.parameters[":name"]=key;
					stmtTemp.parameters[":value"]=att[key];
					stmtTemp.execute();
				}
				return true;
			}
			catch (error:SQLError)
			{
				_status="信息存储失败" + error.message;
			}
			return false;
		}

		private function clearMetadata():Boolean
		{
			var stmtTemp:SQLStatement=new SQLStatement;
			stmtTemp.sqlConnection=dbConn;
			//首先清除
			var sql:String="delete from metadata";
			try
			{
				stmtTemp.text=sql;
				stmtTemp.execute();
				return true;
			}
			catch (error:SQLError)
			{
				_status="更新前删除失败" + error.message;
			}
			return false;
		}
	}
}
