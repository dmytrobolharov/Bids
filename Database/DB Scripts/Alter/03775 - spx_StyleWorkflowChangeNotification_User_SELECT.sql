/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowChangeNotification_User_SELECT]    Script Date: 08/14/2012 10:57:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowChangeNotification_User_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowChangeNotification_User_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowChangeNotification_User_SELECT]    Script Date: 08/14/2012 10:57:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleWorkflowChangeNotification_User_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkflowID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @WorkflowID = '50000000-0000-0000-0000-000000000005' -- costing
		-- select user, responsible for costing workflow
		SELECT u.Email FROM vwx_StyleWorkflowItems wi
		LEFT JOIN Users u ON wi.WorkAssignedTo = u.UserId
		WHERE wi.StyleID = @StyleID AND wi.WorkflowID = @WorkflowID AND u.Email <> ''
	ELSE
	BEGIN
		-- select user responsible for particular workflow
		SELECT u.Email FROM vwx_StyleWorkflowItems wi
		LEFT JOIN Users u ON wi.WorkAssignedTo = u.UserId
		WHERE wi.StyleID = @StyleID AND wi.StyleSet = @StyleSet AND wi.WorkflowID = @WorkflowID AND u.Email <> ''
	END
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03775', GetDate())
GO