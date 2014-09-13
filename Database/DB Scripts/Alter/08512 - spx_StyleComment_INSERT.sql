IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleComment_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleComment_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleComment_INSERT]
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkflowID UNIQUEIDENTIFIER,
	@StyleComment NVARCHAR(MAX),
	@CTeamID UNIQUEIDENTIFIER,
	@WorkFlowItemID UNIQUEIDENTIFIER = NULL,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS

INSERT INTO dbo.pStyleComment  ( 
	StyleID, StyleSet, WorkflowID, 
	CUser, CDate, MUser, MDate, 
	StyleComment, CTeamID, WorkFlowItemId) 
VALUES (
	@StyleID, @StyleSet, @WorkflowID, 
	@CUser, @CDate, @CUser, @CDate, 
	@StyleComment, @CTeamID, @WorkFlowItemId)
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08512', GetDate())
GO
