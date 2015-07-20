IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowDefaultStatus_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowDefaultStatus_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowDefaultStatus_UPDATE] 
@StyleID AS UNIQUEIDENTIFIER
AS
UPDATE dbo.pStyleWorkflow SET WorkStatus = 1 WHERE StyleID = @StyleID
UPDATE dbo.pWorkflowItem SET WorkStatus = 1 WHERE StyleID = @StyleID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08351', GetDate())
GO