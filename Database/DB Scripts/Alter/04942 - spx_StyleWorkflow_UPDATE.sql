
/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_UPDATE]    Script Date: 01/31/2013 00:45:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflow_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_UPDATE]    Script Date: 01/31/2013 00:45:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_StyleWorkflow_UPDATE]
(@WorkStartDate datetime,
@WorkAssignedTo int,
@WorkStatus int,
@WorkComments nvarchar(4000),
@StyleID nvarchar(50),
@StyleSet nvarchar(50),
@WorkflowID nvarchar(50),
@WorkDueDate nvarchar(50),
@MUser nvarchar(100),
@MDate datetime)
AS 

DECLARE @CompletedDate as datetime 

IF @WorkStatus  = 100  
	SET @CompletedDate  = @MDate
ELSE
	SET @CompletedDate  = NULL


UPDATE  dbo.pStyleWorkflow
SET WorkStart = @WorkStartDate, WorkDue = @WorkDueDate, WorkAssignedTo = @WorkAssignedTo, WorkStatus = @WorkStatus, 
 WorkComments = @WorkComments ,  WorkStatusDate = @CompletedDate
WHERE (StyleID = @StyleID) AND (StyleSet = @StyleSet) AND (WorkflowID = @WorkflowID)



GO






INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04942', GetDate())
GO