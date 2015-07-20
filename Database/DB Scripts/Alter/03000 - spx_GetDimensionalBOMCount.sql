
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 24 Jan 2011                                                                                */
-- * WorkItem #6822                                                                             */
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

/****** Object:  StoredProcedure [dbo].[spx_GetDimensionalBOMCount]    Script Date: 01/24/2012 18:39:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_GetDimensionalBOMCount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_GetDimensionalBOMCount]
GO



/****** Object:  StoredProcedure [dbo].[spx_GetDimensionalBOMCount]    Script Date: 01/24/2012 18:39:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[spx_GetDimensionalBOMCount]
(
	@StyleID	VARCHAR(50)
	,@StyleSet	VARCHAR(5)
	,@WorkFlowItemID NVARCHAR(100)
)
AS

BEGIN

DECLARE @DimensionsCount INT

SELECT DimensionColumnName,DimensionColumnValue,ItemDim1TypeName,ItemDim2TypeName,ItemDim3TypeName
		INTO #tblStyleBOMDimension 
			FROM 
			(SELECT StyleBOMDimensionID,ItemDim1TypeId,ItemDim2TypeId,ItemDim3TypeId,ItemDim1TypeName,ItemDim2TypeName,ItemDim3TypeName 
			FROM pStyleBOMDimension WHERE StyleID = @StyleID
			AND StyleSet=@StyleSet
			AND WorkFlowItemID=@WorkFlowItemID
			)p
			UNPIVOT
			(DimensionColumnValue FOR DimensionColumnName 
			IN (ItemDim1TypeId,ItemDim2TypeId,ItemDim3TypeId)) AS unpvt;
			
SELECT  COUNT(*) AS 'DIMCOUNT' FROM #tblStyleBOMDimension 
WHERE DimensionColumnValue <>'00000000-0000-0000-0000-000000000000'

DROP  TABLE #tblStyleBOMDimension

END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03000'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03000', GetDate())

END

GO

