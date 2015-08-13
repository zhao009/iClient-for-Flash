package com.supermap.components.serviceExtend
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.service.ServiceBase;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public class ExtendService extends ServiceBase
	{
		public var viewBounds:Rectangle2D;
		override public function ExtendService()
		{
			super("http://services.supermapcloud.com/iserver");
		}
		
		public function execute(attributeFilter:String, responder:IResponder = null):AsyncToken
		{
//			"[{\"x\":12921673.5484445, \"y\":4881157.127069949}, " +
//				"{\"x\":12995125.3879325, \"y\":4881157.127069949}, " +
//				"{\"x\":12995125.3879325, \"y\":4823007.75414195}, " +
//				"{\"x\":12921673.5484445, \"y\":4823007.75414195}]" 
//			
			var reqVar:URLVariables = new URLVariables();
			reqVar.servicename = "Search";
			reqVar.methodname = "queryByGeometry";
			if(attributeFilter)
			{
				var commonStr:String = "{\"dataSourceName\":\"china_poi\"," + 
					"\"queryParam\":{\"queryDatasetParams\":[{\"name\":\"PbeijingP\"," +
					"\"sqlParam\":{\"groupClause\":null, \"ids\":null," + 
					"\"returnFields\":[\"SMID\", \"SMX\", \"SMY\", \"Name\", \"PY\", \"POI_ID\", \"ZipCode\", \"Address\", \"Telephone\"]," +
					"\"sortClause\":null, \"attributeFilter\":\"Name like '%" + attributeFilter + "%'\", \"joinItems\":null, \"linkItems\":null}}], " +  
					"\"returnResultSetInfo\":\"ATTRIBUTE\", \"startRecord\":0, \"expectCount\":10, \"sortPriorityType\":-1}," + 
					"\"geometry\":{\"id\":6, \"feature\":5, \"parts\":[4]," +
					"\"point2Ds\":[" + this.getBounds() + "]}," + 
					"\"queryMode\":\"INTERSECT\"}";
				
				reqVar.parameter = commonStr;
			}
			return sendURL("/cloudhandler", reqVar, responder, this.handleDecodedObject);	
		}
		
		public function queryByKeyWordExecu(attributeFilter:String, responder:IResponder = null):AsyncToken
		{		
			var reqVar:URLVariables = new URLVariables();
			reqVar.servicename = "Search";
			reqVar.methodname = "queryByKeywords";
			if(attributeFilter)
			{
				var commonStr:String = "{\"dataSourceName\":\"china_poi\"," + 
					"\"queryParam\":{\"queryDatasetParams\":[{\"name\":\"PbeijingP\"," +
					"\"sqlParam\":{\"groupClause\":null, \"ids\":null," + 
					"\"returnFields\":[\"SMID\", \"SMX\", \"SMY\", \"Name\", \"PY\", \"POI_ID\", \"ZipCode\", \"Address\", \"Telephone\", \"Admincode\"]," +
					"\"sortClause\":null, \"attributeFilter\":\"Name like '%" + attributeFilter + "%' and admincode >='110000'and admincode<'120000'\", \"joinItems\":null, \"linkItems\":null}}], " +  
					"\"returnResultSetInfo\":\"ATTRIBUTE\", \"startRecord\":0, \"expectCount\":10, \"sortPriorityType\":-1}," + 
					"\"queryType\":0}";
				
				reqVar.parameter = commonStr;
			}
			return sendURL("/cloudhandler", reqVar, responder, this.handleDecodedObject);	
		}
		

		
		private function getBounds():String
		{
			return "{\"x\":" + viewBounds.bottomLeft.x + ", \"y\":" + viewBounds.bottomLeft.y + "}, " +
				  "{\"x\":" + viewBounds.right + ", \"y\":" + viewBounds.bottom + "}, " +
				  "{\"x\":" + viewBounds.topRight.x + ", \"y\":" + viewBounds.topRight.y + "}, " +
				  "{\"x\":" + viewBounds.left + ", \"y\":" + viewBounds.top + "}";
		}
		

		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			var lastResult:ExtendRecordSet;
			if(object&&object.result[0])
			{
				lastResult= ExtendRecordSet.toExtendRecordSet(object.result[0].records);
			}
			
			for each (responder in asyncToken.responders)
			{
				responder.result(lastResult);
			}	
		}
	}
}