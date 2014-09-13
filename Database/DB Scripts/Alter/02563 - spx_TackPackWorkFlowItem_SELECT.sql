IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TackPackWorkFlowItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TackPackWorkFlowItem_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TackPackWorkFlowItem_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TackPackWorkFlowItem_SELECT] 
(   @WorkflowId uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int
)
AS
BEGIN

	SELECT 
		StyleID,StyleSet,WorkflowItemID 
	FROM 
		pWorkFlowItem 
	WHERE 
		StyleID= @StyleID 
		AND StyleSet=@StyleSet
		AND WorkflowID=@WorkflowId
		AND WorkFlowItemID 
		NOT IN 
		(
			SELECT 
				WorkFlowItemID 
			FROM 
				pStyleBOMXML 
			WHERE 
				StyleID=@StyleID 
				AND StyleSet=@StyleSet
		)

END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02563'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02563', GetDate())
END
GO