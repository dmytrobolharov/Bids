
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 26 Sep 2011                                                                               */
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

/****** Object:  StoredProcedure [dbo].[rpx_Style_DevelopmentSpec_SELECT]    Script Date: 09/26/2011 11:23:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_DevelopmentSpec_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_DevelopmentSpec_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[rpx_Style_DevelopmentSpec_SELECT]    Script Date: 09/26/2011 11:23:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_Style_DevelopmentSpec_SELECT] 
	@StyleID AS varchar(255), 
	@StyleSet As int
AS

SELECT
	ps.POM,
	ps.PointMeasur,
	dbo.fnx_Num2Frac(ps.TOL) AS TOL, 
	dbo.fnx_Num2Frac(ps.Spec) AS Spec,
	CASE
	     WHEN sz.Sel0 = 1 THEN sz.Size0
	     WHEN sz.Sel1 = 1 THEN sz.Size1
	     WHEN sz.Sel2 = 1 THEN sz.Size2
	     WHEN sz.Sel3 = 1 THEN sz.Size3
	     WHEN sz.Sel4 = 1 THEN sz.Size4
	     WHEN sz.Sel5 = 1 THEN sz.Size5
	     WHEN sz.Sel6 = 1 THEN sz.Size6
	     WHEN sz.Sel7 = 1 THEN sz.Size7
	     WHEN sz.Sel8 = 1 THEN sz.Size8
	     WHEN sz.Sel9 = 1 THEN sz.Size9
	     WHEN sz.Sel10 = 1 THEN sz.Size10
	     WHEN sz.Sel11 = 1 THEN sz.Size11
	END AS SizeNo
FROM	pStyleSpec ps, pStyleSpecSize sz 
WHERE ((sz.StyleID = ps.StyleID) AND
	(ps.StyleSet = @StyleSet) AND
	(sz.StyleID = @StyleID) AND
	(ps.Spec <> 0)) 
ORDER BY ps.Sort, ps.POM, ps.PointMeasur

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01969'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01969', GetDate())

END

GO





