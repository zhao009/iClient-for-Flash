package com.supermap.web.iServerJava2.queryServices
{
	/**
	 * ${iServer2_SpatialQueryMode_Title}.
	 * <p>${iServer2_SpatialQueryMode_Description}</p>
	 * <p><TABLE border="1">
	* <TBODY>
	* <TR>
	* <TD>${iServer2_SpatialQueryMode_R1C1}</TD>
	* <TD>${iServer2_SpatialQueryMode_R1C2}</TD>
	* <TD>${iServer2_SpatialQueryMode_R1C3}</TD>
	* <TD>${iServer2_SpatialQueryMode_R1C4}</TD>
	* <TD>${iServer2_SpatialQueryMode_R1C5}</TD></TR>
	* <TR>
	* <TD>${iServer2_SpatialQueryMode_R2C1}</TD>
	* <TD>${iServer2_SpatialQueryMode_R2C2}</TD>
	* <TD>${iServer2_SpatialQueryMode_R2C2}</TD>
	* <TD>${iServer2_SpatialQueryMode_R2C4}</TD>
	* <TD>${iServer2_SpatialQueryMode_R2C5}</TD></TR>
	* <TR>
	* <TD>${iServer2_SpatialQueryMode_R3C1}</TD>
	* <TD>${iServer2_SpatialQueryMode_R3C2}</TD>
	* <TD>${iServer2_SpatialQueryMode_R3C3}</TD>
	* <TD>${iServer2_SpatialQueryMode_R3C4}</TD>
	* <TD>${iServer2_SpatialQueryMode_R3C5}</TD></TR>
	* <TR>
	* <TD>${iServer2_SpatialQueryMode_R4C1}</TD>
	* <TD>${iServer2_SpatialQueryMode_R4C2}</TD>
	* <TD>${iServer2_SpatialQueryMode_R4C3}</TD>
	* <TD>${iServer2_SpatialQueryMode_R4C4}</TD>
	* <TD>${iServer2_SpatialQueryMode_R4C5}</TD></TR></TBODY></TABLE></p> 
	 * 
	 * 
	 */
	public class SpatialQueryMode
	{
		/**
		 * ${iServer2_SpatialQueryMode_attribute_none_D} 
		 */
		public static const NONE:int				= -1;		
		/**
		 * ${iServer2_SpatialQueryMode_attribute_Identity_D}
		 * <p><TABLE border="1">
* <TBODY>
* <TR>
* <TD rowSpan="2">${iServer2_SpatialQueryMode_R1C1}</TD>
* <TD colSpan="3">${iServer2_SpatialQueryMode_R1C2}</TD></TR>
* <TR>
* <TD><IMG src="../../../../../images/SdP.png"></IMG></TD>
* <TD><IMG src="../../../../../images/SdL.png"></IMG></TD>
* <TD><IMG src="../../../../../images/SdR.png"></IMG></TD></TR>
* <TR>
* <TD><IMG src="../../../../../images/SP.png"></IMG></TD>
* <TD><IMG src="../../../../../images/Identity_PP.png"></IMG></TD>
* <TD></TD>
* <TD></TD></TR>
* <TR>
* <TD><IMG src="../../../../../images/SL.png"></IMG></TD>
* <TD></TD>
* <TD><IMG src="../../../../../images/Identity_LL.png"></IMG></TD>
* <TD></TD></TR>
* <TR>
* <TD><IMG src="../../../../../images/SR.png"></IMG></TD>
* <TD></TD>
* <TD></TD>
* <TD><IMG src="../../../../../images/Identity_RR.png"></IMG></TD></TR></TBODY></TABLE></p> 
		 */
		public static const IDENTITY:int			= 0;	
		/**
		 * ${iServer2_SpatialQueryMode_attribute_Disjiont_D}
		 * <p><TABLE border="1">
<TBODY>
<TR>
<TD rowSpan="2">${iServer2_SpatialQueryMode_R1C1}</TD>
<TD colSpan="3">${iServer2_SpatialQueryMode_R1C2}</TD></TR>
<TR>
<TD><IMG src="../../../../../images/SdP.png"/></TD>
<TD><IMG src="../../../../../images/SdL.png"/></TD>
<TD><IMG src="../../../../../images/SdR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SP.png"/></TD>
<TD><IMG src="../../../../../images/Disjoint_PP.png"/></TD>
<TD><IMG src="../../../../../images/Disjoint_PL.png"/></TD>
<TD><IMG src="../../../../../images/Disjoint_PR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SL.png"/></TD>
<TD><IMG src="../../../../../images/Disjoint_LP.png"/></TD>
<TD><IMG src="../../../../../images/Disjoint_LL.png"/></TD>
<TD><IMG src="../../../../../images/Disjoint_LR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SR.png"/></TD>
<TD><IMG src="../../../../../images/Disjoint_RP.png"/></TD>
<TD><IMG src="../../../../../images/Disjoint_RL.png"/></TD>
<TD><IMG src="../../../../../images/Disjoint_RR.png"/></TD></TR></TBODY></TABLE></p> 
		 */
		public static const DISJOINT:int	        = 1;
		
		/**
		 * ${iServer2_SpatialQueryMode_attribute_Intersect_D}
		 * <p><TABLE border="1">
<TBODY>
<TR>
<TD rowSpan="2">${iServer2_SpatialQueryMode_R1C1}</TD>
<TD colSpan="3">${iServer2_SpatialQueryMode_R1C2}</TD></TR>
<TR>
<TD><IMG src="../../../../../images/SdP.png"/></TD>
<TD><IMG src="../../../../../images/SdL.png"/></TD>
<TD><IMG src="../../../../../images/SdR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SP.png"/></TD>
<TD><IMG src="../../../../../images/Intersect_PP.png"/></TD>
<TD><IMG src="../../../../../images/Intersect_PL.png"/></TD>
<TD><IMG src="../../../../../images/Intersect_PR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SL.png"/></TD>
<TD></TD>
<TD></TD>
<TD></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SR.png"/></TD>
<TD><IMG src="../../../../../images/Intersect_RP.png"/></TD>
<TD><IMG src="../../../../../images/Intersect_RL.png"/></TD>
<TD><IMG src="../../../../../images/Intersect_RR.png"/></TD></TR></TBODY></TABLE></p> 
		 */
		public static const INTERSECT:int		    = 2;		
		/**
		 * ${iServer2_SpatialQueryMode_attribute_Touch_D}
		 * <p><TABLE border="1">
<TBODY>
<TR>
<TD rowSpan="2">${iServer2_SpatialQueryMode_R1C1}</TD>
<TD colSpan="3">${iServer2_SpatialQueryMode_R1C2}</TD></TR>
<TR>
<TD><IMG src="../../../../../images/SdP.png"/></TD>
<TD><IMG src="../../../../../images/SdL.png"/></TD>
<TD><IMG src="../../../../../images/SdR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SP.png"/></TD>
<TD></TD>
<TD><IMG src="../../../../../images/Touch_PL.png"/></TD>
<TD><IMG src="../../../../../images/Touch_PR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SL.png"/></TD>
<TD><IMG src="../../../../../images/Touch_LP.png"/></TD>
<TD><IMG src="../../../../../images/Touch_LL.png"/></TD>
<TD><IMG src="../../../../../images/Touch_LR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SR.png"/></TD>
<TD><IMG src="../../../../../images/Touch_RP.png"/></TD>
<TD><IMG src="../../../../../images/Touch_RL.png"/></TD>
<TD><IMG src="../../../../../images/Touch_RR.png"/></TD></TR></TBODY></TABLE></p> 
		 */
		public static const TOUCH:int				= 3;	
		/**
		 * ${iServer2_SpatialQueryMode_attribute_Overlap_D}
		 * <p><TABLE border="1">
<TBODY>
<TR>
<TD rowSpan="2">${iServer2_SpatialQueryMode_R1C1}</TD>
<TD colSpan="3">${iServer2_SpatialQueryMode_R1C2}</TD></TR>
<TR>
<TD><IMG src="../../../../../images/SdP.png"/></TD>
<TD><IMG src="../../../../../images/SdL.png"/></TD>
<TD><IMG src="../../../../../images/SdR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SP.png"/></TD>
<TD></TD>
<TD></TD>
<TD></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SL.png"/></TD>
<TD></TD>
<TD><IMG src="../../../../../images/Overlap_LL.png"/></TD>
<TD></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SR.png"/></TD>
<TD></TD>
<TD></TD>
<TD><IMG src="../../../../../images/Overlap_RR.png"/></TD></TR></TBODY></TABLE></p> 
		 */
		public static const OVERLAP:int	            = 4;
		
		/**
		 * ${iServer2_SpatialQueryMode_attribute_Cross_D}
		 * <p><TABLE border="1">
<TBODY>
<TR>
<TD rowSpan="2">${iServer2_SpatialQueryMode_R1C1}</TD>
<TD colSpan="3">${iServer2_SpatialQueryMode_R1C2}</TD></TR>
<TR>
<TD><IMG src="../../../../../images/SdP.png"/></TD>
<TD><IMG src="../../../../../images/SdL.png"/></TD>
<TD><IMG src="../../../../../images/SdR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SP.png"/></TD>
<TD></TD>
<TD></TD>
<TD></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SL.png"/></TD>
<TD></TD>
<TD><IMG src="../../../../../images/Cross_LL.png"/></TD>
<TD><IMG src="../../../../../images/Cross_LR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SR.png"/></TD>
<TD></TD>
<TD></TD>
<TD></TD></TR></TBODY></TABLE></p> 
		 */
		public static const CROSS:int				= 5;		
		/**
		 * ${iServer2_SpatialQueryMode_attribute_Within_D}
		 * <p><TABLE border="1">
<TBODY>
<TR>
<TD rowSpan="2">${iServer2_SpatialQueryMode_R1C1}</TD>
<TD colSpan="3">${iServer2_SpatialQueryMode_R1C2}</TD></TR>
<TR>
<TD><IMG src="../../../../../images/SdP.png"/></TD>
<TD><IMG src="../../../../../images/SdL.png"/></TD>
<TD><IMG src="../../../../../images/SdR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SP.png"/></TD>
<TD><IMG src="../../../../../images/Within_PP.png"/></TD>
<TD><IMG src="../../../../../images/Within_PL.png"/></TD>
<TD><IMG src="../../../../../images/Within_PR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SL.png"/></TD>
<TD></TD>
<TD><IMG src="../../../../../images/Within_LL.png"/></TD>
<TD><IMG src="../../../../../images/Within_LR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SR.png"/></TD>
<TD></TD>
<TD></TD>
<TD><IMG src="../../../../../images/Within_RR.png"/></TD></TR></TBODY></TABLE></p> 
		 */
		public static const WITHIN:int				= 6;	
		/**
		 * ${iServer2_SpatialQueryMode_attribute_Contain_D}
		 * <p><TABLE border="1">
<TBODY>
<TR>
<TD rowSpan="2">${iServer2_SpatialQueryMode_R1C1}</TD>
<TD colSpan="3">${iServer2_SpatialQueryMode_R1C2}</TD></TR>
<TR>
<TD><IMG src="../../../../../images/SdP.png"/></TD>
<TD><IMG src="../../../../../images/SdL.png"/></TD>
<TD><IMG src="../../../../../images/SdR.png"/></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SP.png"/></TD>
<TD><IMG src="../../../../../images/Contain_PP.png"/></TD>
<TD></TD>
<TD></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SL.png"/></TD>
<TD><IMG src="../../../../../images/Contain_LP.png"/></TD>
<TD><IMG src="../../../../../images/Contain_LL.png"/></TD>
<TD></TD></TR>
<TR>
<TD><IMG src="../../../../../images/SR.png"/></TD>
<TD><IMG src="../../../../../images/Contain_RP.png"/></TD>
<TD><IMG src="../../../../../images/Contain_RL.png"/></TD>
<TD><IMG src="../../../../../images/Contain_RR.png"/></TD></TR></TBODY></TABLE></p> 
		 */
		public static const CONTAIN:int	            = 7;
		/**
		 * ${iServer2_SpatialQueryMode_constructor_D} 
		 * 
		 */
		public function SpatialQueryMode()
		{
		}

	}
}