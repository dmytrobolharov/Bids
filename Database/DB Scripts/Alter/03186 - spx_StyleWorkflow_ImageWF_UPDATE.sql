IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_ImageWF_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflow_ImageWF_UPDATE]
GO


CREATE PROCEDURE dbo.spx_StyleWorkflow_ImageWF_UPDATE  
(@WorkStatus int,   
@StyleID nvarchar(50),  
@StyleSet nvarchar(50),  
@WorkflowID nvarchar(50),  
@MUser nvarchar(100),  
@MDate datetime)  
AS   

  
UPDATE  dbo.pStyleWorkflow  
SET  WorkStatus = @WorkStatus , MDate = @MDate , MUser = @MUser
WHERE (StyleID = @StyleID) AND (StyleSet = @StyleSet) AND (WorkflowID = @WorkflowID)  

  
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03186', GetDate())

GO   
