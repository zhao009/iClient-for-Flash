package com.supermap.web.iServerJava6R.dataServices
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.styles.TextStyle;
	import com.supermap.web.utils.serverTypes.ServerFeature;
	import com.supermap.web.utils.serverTypes.ServerGeometryType;
	import com.supermap.web.utils.serverTypes.ServerTextStyle;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_GetFeaturesResult_Title}.
	 * <p>${iServerJava6R_GetFeaturesResult_Description}</p> 
	 * 
	 */	
	public class GetFeaturesResult
	{
		private var _featureCount:int;
		private var _features:Array;
		
		/**
		 * ${iServerJava6R_GetFeaturesResult_constructor_D} 
		 * 
		 */		
		public function GetFeaturesResult()
		{
		}
		
		/**
		 * ${iServerJava6R_GetFeaturesResult_attribute_features_D}.
		 * <p>${iServerJava6R_GetFeaturesResult_attribute_features_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get features():Array
		{
			return _features;
		}

		/**
		 * ${iServerJava6R_GetFeaturesResult_attribute_featureCount_D}.
		 * <p>${iServerJava6R_GetFeaturesResult_attribute_featureCount_remarks}</p> 
		 * @see #features
		 * @return 
		 * 
		 */		
		public function get featureCount():int
		{
			return _featureCount;
		}

		/**
		 * @private 
		 * @param json
		 * @return 
		 * 
		 */		
		public static function fromJson(json:Object) : GetFeaturesResult
		{
			if (json == null)
				return null;
			
			var result:GetFeaturesResult = new GetFeaturesResult();

			result._featureCount = json["featureCount"];	
			result._features = [];
			var jsonFeatures:Array = json["features"];
			if(jsonFeatures && jsonFeatures.length)
			{
				var length:int = jsonFeatures.length;
				for(var i:int = 0; i < length; i++)
				{
					var serverFeature:ServerFeature = ServerFeature.fromJson(jsonFeatures[i]);
					var feature:Feature = ServerFeature.toFeature(serverFeature);
					if(feature.geometry is GeoPoint)
					{
//						if(feature.geometry.type == ServerGeometryType.POINT)
//							feature.style = new PredefinedMarkerStyle();
						if(feature.geometry.type == ServerGeometryType.TEXT)
						{
							var geoPoint:GeoPoint = feature.geometry as GeoPoint;
							var textStyle:TextStyle = ServerTextStyle.serverStyleToClientStyle(serverFeature.geometry.textStyle);
							textStyle.text = serverFeature.geometry.text.toString();
							feature.style = textStyle;
						}
					}
//					else if(feature.geometry is GeoLine)
//						feature.style = new PredefinedLineStyle();
//					else if(feature.geometry is GeoRegion)
//						feature.style = new PredefinedFillStyle();
					result._features[i] = feature;
				}			
			}
			return result;
		}
	}
}