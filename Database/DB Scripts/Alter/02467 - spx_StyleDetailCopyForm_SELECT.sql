
/****** Object:  StoredProcedure [dbo].[spx_LinePlan_ListGrid_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetailCopyForm_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE spx_StyleDetailCopyForm_SELECT

GO
/****** Object:  StoredProcedure [dbo].[spx_LinePlan_ListGrid_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailCopyForm_SELECT](
@StyleID uniqueidentifier,
@StyleSet int,
@WorkflowID uniqueidentifier)

AS 
BEGIN
	SELECT	 WorkFlowItemId 
	FROM	  pStyleDetailForm 
	WHERE	 StyleID = @StyleID AND 
			StyleSet = @StyleSet AND 
			WorkflowID = @WorkflowID
END

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02467'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.0.0000', '02467', GetDate())
END	