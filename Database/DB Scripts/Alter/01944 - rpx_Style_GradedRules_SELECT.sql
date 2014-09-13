
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 15 Sep 2011                                                                               */
-- * WorkItem #5042                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[rpx_Style_GradedRules_SELECT]    Script Date: 09/15/2011 19:23:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_GradedRules_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_GradedRules_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[rpx_Style_GradedRules_SELECT]    Script Date: 09/15/2011 19:23:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_Style_GradedRules_SELECT]  
	@StyleID varchar(255), 
	@StyleSet int 
AS
 
SELECT	sz.Sel0 AS Sample0,
	sz.Sel1 AS Sample1,
	sz.Sel2 AS Sample2,
	sz.Sel3 AS Sample3,
	sz.Sel4 AS Sample4,
	sz.Sel5 AS Sample5,
	sz.Sel6 AS Sample6,
	sz.Sel7 AS Sample7,
	sz.Sel8 AS Sample8,
	sz.Sel9 AS Sample9,
	sz.Sel10 AS Sample10,
	sz.Sel11 AS Sample11,
	sz.Sel12 AS Sample12,
	sz.Sel13 AS Sample13,
	sz.Sel14 AS Sample14,
	sz.Sel15 AS Sample15,
	sz.Sel16 AS Sample16,
	sz.Sel17 AS Sample17,
	sz.Sel18 AS Sample18,
	sz.Sel19 AS Sample19,
	sz.Size0 AS Range0,
	sz.Size1 AS Range1,
	sz.Size2 AS Range2,
	sz.Size3 AS Range3,
	sz.Size4 AS Range4,
	sz.Size5 AS Range5,
	sz.Size6 AS Range6,
	sz.Size7 AS Range7,
	sz.Size8 AS Range8,
	sz.Size9 AS Range9,
	sz.Size10 AS Range10,
	sz.Size11 AS Range11,
	sz.Size12 AS Range12,
	sz.Size13 AS Range13,
	sz.Size14 AS Range14,
	sz.Size15 AS Range15,
	sz.Size16 AS Range16,
	sz.Size17 AS Range17,
	sz.Size18 AS Range18,
	sz.Size19 AS Range19,
	dbo.fnx_Num2Frac(ps.Size0) AS Size0,
	dbo.fnx_Num2Frac(ps.Size1) AS Size1,
	dbo.fnx_Num2Frac(ps.Size2) AS Size2,
	dbo.fnx_Num2Frac(ps.Size3) AS Size3,
	dbo.fnx_Num2Frac(ps.Size4) AS Size4,
	dbo.fnx_Num2Frac(ps.Size5) AS Size5,
	dbo.fnx_Num2Frac(ps.Size6) AS Size6,
	dbo.fnx_Num2Frac(ps.Size7) AS Size7,
	dbo.fnx_Num2Frac(ps.Size8) AS Size8,
	dbo.fnx_Num2Frac(ps.Size9) AS Size9,
	dbo.fnx_Num2Frac(ps.Size10) AS Size10,
	dbo.fnx_Num2Frac(ps.Size11) AS Size11,
	dbo.fnx_Num2Frac(ps.Size12) AS Size12,
	dbo.fnx_Num2Frac(ps.Size13) AS Size13,
	dbo.fnx_Num2Frac(ps.Size14) AS Size14,
	dbo.fnx_Num2Frac(ps.Size15) AS Size15,
	dbo.fnx_Num2Frac(ps.Size16) AS Size16,
	dbo.fnx_Num2Frac(ps.Size17) AS Size17,
	dbo.fnx_Num2Frac(ps.Size18) AS Size18,
	dbo.fnx_Num2Frac(ps.Size19) AS Size19,
	dbo.fnx_Num2Frac(ps.Grade0) AS Grade0, 
	dbo.fnx_Num2Frac(ps.Grade1) AS Grade1, 
	dbo.fnx_Num2Frac(ps.Grade2) AS Grade2,  
	dbo.fnx_Num2Frac(ps.Grade3) AS Grade3, 
	dbo.fnx_Num2Frac(ps.Grade4) AS Grade4, 
	dbo.fnx_Num2Frac(ps.Grade5) AS Grade5, 
	dbo.fnx_Num2Frac(ps.Grade6) AS Grade6, 
	dbo.fnx_Num2Frac(ps.Grade7) AS Grade7, 
	dbo.fnx_Num2Frac(ps.Grade8) AS Grade8, 
	dbo.fnx_Num2Frac(ps.Grade9) AS Grade9, 
	dbo.fnx_Num2Frac(ps.Grade10) AS Grade10, 
	dbo.fnx_Num2Frac(ps.Grade11) AS Grade11, 
	dbo.fnx_Num2Frac(ps.Grade12) AS Grade12, 
	dbo.fnx_Num2Frac(ps.Grade13) AS Grade13, 
	dbo.fnx_Num2Frac(ps.Grade14) AS Grade14, 
	dbo.fnx_Num2Frac(ps.Grade15) AS Grade15, 
	dbo.fnx_Num2Frac(ps.Grade16) AS Grade16, 
	dbo.fnx_Num2Frac(ps.Grade17) AS Grade17, 
	dbo.fnx_Num2Frac(ps.Grade18) AS Grade18, 
	dbo.fnx_Num2Frac(ps.Grade19) AS Grade19, 
	dbo.fnx_Num2Frac(ps.Proto0) AS Proto0, 
	dbo.fnx_Num2Frac(ps.Proto1) AS Proto1, 
	dbo.fnx_Num2Frac(ps.Proto2) AS Proto2,  
	dbo.fnx_Num2Frac(ps.Proto3) AS Proto3, 
	dbo.fnx_Num2Frac(ps.Proto4) AS Proto4, 
	dbo.fnx_Num2Frac(ps.Proto5) AS Proto5, 
	dbo.fnx_Num2Frac(ps.Proto6) AS Proto6, 
	dbo.fnx_Num2Frac(ps.Proto7) AS Proto7, 
	dbo.fnx_Num2Frac(ps.Proto8) AS Proto8, 
	dbo.fnx_Num2Frac(ps.Proto9) AS Proto9, 
	dbo.fnx_Num2Frac(ps.Proto10) AS Proto10, 
	dbo.fnx_Num2Frac(ps.Proto11) AS Proto11, 
	dbo.fnx_Num2Frac(ps.Proto12) AS Proto12, 
	dbo.fnx_Num2Frac(ps.Proto13) AS Proto13, 
	dbo.fnx_Num2Frac(ps.Proto14) AS Proto14, 
	dbo.fnx_Num2Frac(ps.Proto15) AS Proto15, 
	dbo.fnx_Num2Frac(ps.Proto16) AS Proto16, 
	dbo.fnx_Num2Frac(ps.Proto17) AS Proto17, 
	dbo.fnx_Num2Frac(ps.Proto18) AS Proto18, 
	dbo.fnx_Num2Frac(ps.Proto19) AS Proto19, 	
	ps.POM, ps.PointMeasur, 
	dbo.fnx_Num2Frac(ps.TOL) AS TOL,	
	dbo.fnx_Num2Frac(ps.TOLN) AS TOLN, 
	WashType = 
		CASE 
			WHEN UPPER(ph.WashType) IS NULL THEN 'TOL'
			WHEN UPPER(ph.WashType) = '' THEN 'TOL'
			WHEN UPPER(ph.WashType) = 'WASH' THEN 'TOL'
			ELSE 'TOLN'
		END 
FROM	pStyleSpecSize sz INNER JOIN pStyleSpec AS ps ON
	sz.StyleID = ps.StyleID INNER JOIN pStyleHeader AS ph ON
	ps.StyleID = ph.StyleID 
WHERE	(ps.StyleID = @StyleID)	AND
		(ps.StyleSet = @StyleSet) AND
		(ps.Spec <> 0)
ORDER BY Sort, POM, PointMeasur

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01944'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01944', GetDate())

END

GO





