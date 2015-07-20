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

/****** Object:  StoredProcedure [dbo].[spx_WorkFlowItemBOMList_SELECT]    Script Date: 12/18/2011 18:07:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkFlowItemBOMList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkFlowItemBOMList_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_WorkFlowItemBOMList_SELECT]    Script Date: 12/18/2011 18:07:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_WorkFlowItemBOMList_SELECT] 
(   @WorkflowId uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet1 int,
	@StyleSet2 int = null,
	@StyleSet3 int = null,
	@StyleSet4 int = null
)
AS
BEGIN
	
	SELECT WorkFlowItemID,WorkflowItemTypeId,WorkFlowItemName
	FROM pWorkFlowItem  
	WHERE StyleID = @StyleID
	AND StyleSet = @StyleSet1
	AND WorkflowId = @WorkflowId
	Order By Sort
	
IF(@StyleSet2 is not null )
BEGIN
	SELECT WorkFlowItemID,WorkflowItemTypeId,WorkFlowItemName
	FROM pWorkFlowItem  
	WHERE StyleID = @StyleID
	AND StyleSet = @StyleSet2
	AND WorkflowId = @WorkflowId
	Order By Sort
END	

IF(@StyleSet3 is not null )
BEGIN
	SELECT WorkFlowItemID,WorkflowItemTypeId,WorkFlowItemName
	FROM pWorkFlowItem  
	WHERE StyleID = @StyleID
	AND StyleSet = @StyleSet3
	AND WorkflowId = @WorkflowId
	Order By Sort
END	
	
END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02377'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02377', GetDate())

END

GO