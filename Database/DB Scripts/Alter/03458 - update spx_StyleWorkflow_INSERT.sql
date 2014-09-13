IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_INSERT]'))

drop procedure spx_StyleWorkflow_INSERT
go


/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_INSERT]    Script Date: 05/08/2012 12:24:39 ******/
CREATE PROCEDURE [dbo].[spx_StyleWorkflow_INSERT]

(@StyleID uniqueidentifier,
@StyleSet int = 1,
@WorkflowID uniqueidentifier,
@WorkflowTemplateID uniqueidentifier,
@WorkflowTemplateItemID uniqueidentifier,

@PlannedStartDate datetime,
@PlannedDueDate datetime,
@PlannedWorkDays int,
@WorkAssignedTo int =0,
@WorkEscalateTo int =0,
@WorkflowAlerts int = 0,
@WorkflowAccessTypeID int = 0,
@WorkflowAccessTypeDesc nvarchar(255),
@WorkflowType int = 0,
@WorkDate datetime,
@WorkStart datetime,
@WorkDue datetime,
@WorkComplete nvarchar(50) = 0,
@WorkStatus int=6,
@WorkVersion int=0,
@WorkComments nvarchar(4000),
@WorkSort nvarchar(2),
@UserName nvarchar(100),
@UserDate datetime= GETDATE  ,
@WorkDay int ) 

AS 

IF (SELECT COUNT(StyleSet)  FROM  pStyleWorkflow WITH (NOLOCK) WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID ) = 0 
	BEGIN 
	INSERT INTO pStyleWorkflow
		(StyleID, StyleSet, WorkflowID, WorkflowTemplateID, WorkflowTemplateItemID, 
		PlannedStartDate, PlannedDueDate, PlannedWorkDays, WorkAssignedTo, WorkEscalateTo, 
		WorkflowAlerts, WorkflowAccessTypeID, WorkflowAccessTypeDesc,
		WorkflowType, WorkDate, WorkStart, WorkDue, WorkComplete, WorkStatus, 
		WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate, WorkDay)
	VALUES (@StyleID, @StyleSet, @WorkflowID, @WorkflowTemplateID, @WorkflowTemplateItemID, 
			@PlannedStartDate, @PlannedDueDate, @PlannedWorkDays, @WorkAssignedTo, @WorkEscalateTo, 
			@WorkflowAlerts, @WorkflowAccessTypeID, @WorkflowAccessTypeDesc,
			@WorkflowType, @WorkDate, @WorkStart, @WorkDue, @WorkComplete, @WorkStatus, 
			@WorkVersion, @WorkComments, @WorkSort, @UserName, @UserDate, @UserName, @UserDate, @WorkDay )
	END
ELSE
	BEGIN
	UPDATE  pStyleWorkflow
	SET  WorkDate = @WorkDate, WorkflowTemplateID = @WorkflowTemplateID, WorkflowTemplateItemID = @WorkflowTemplateItemID, 
		 PlannedStartDate = @PlannedStartDate, PlannedDueDate = @PlannedDueDate, PlannedWorkDays = @PlannedWorkDays,
		 WorkStart = @WorkStart, WorkDue = @WorkDue, WorkAssignedTo = @WorkAssignedTo, WorkVersion = @WorkVersion, 
		 WorkComments = @WorkComments, WorkSort = @WorkSort, MUser = @UserName, MDate = @UserDate ,  WorkDay = @WorkDay	
	WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID
	END
	
	
go



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03458', GetDate())
	

GO

