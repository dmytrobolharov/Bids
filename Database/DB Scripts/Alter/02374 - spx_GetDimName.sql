-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_GetDimName]    Script Date: 12/18/2011 18:05:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_GetDimName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_GetDimName]
GO



/****** Object:  StoredProcedure [dbo].[spx_GetDimName]    Script Date: 12/18/2011 18:05:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_GetDimName] (
@WorkFlowItemID  UNIQUEIDENTIFIER
)
AS
	--DECLARE @CSV nvarchar(255)	
	--SELECT @CSV= SUBSTRING((SELECT distinct ',' + ('''' + convert(nvarchar(100),StyleBOMDimensionId)	+ '''' ) FROM pStyleBOMDimensionItem 
	--WHERE StyleID = @StyleID FOR XML PATH('')),2,200000)
	--print @CSV

	--DECLARE @CST nvarchar(300)	
	--set @CST = 'select ItemDim1TypeName,ItemDim2TypeName,ItemDim3TypeName from dbo.pStyleBOMDimension where cast (StyleBOMDimensionId as nvarchar (200)) in (' + @CSV + ')'
	--exec(@CST)
	
--DECLARE @StyleBOMDimensionId UNIQUEIDENTIFIER
--SELECT TOP 1 @StyleBOMDimensionId = StyleBOMDimensionId FROM pStyleBOMDimensionItem WHERE StyleID = @StyleID

select ItemDim1TypeName,ItemDim2TypeName,ItemDim3TypeName from dbo.pStyleBOMDimension
where WorkFlowItemID = @WorkFlowItemID



GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02374'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02374', GetDate())

END

GO

