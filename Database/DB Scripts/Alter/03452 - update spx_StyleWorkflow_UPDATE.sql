if Exists(select * 
			from sys.columns 
		   where Name = N'WorkflowEscalateTo'               
             and Object_ID = Object_ID(N'pStyleWorkflow'))
             
begin      
-- Column Exists 
	EXEC sp_rename
    @objname = 'pStyleWorkflow.WorkflowEscalateTo',
    @newname = 'WorkEscalateTo',
    @objtype = 'COLUMN'
end
go



-- if drop...etc..
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_UPDATE]'))
drop procedure spx_StyleWorkflow_UPDATE
go


create procedure spx_StyleWorkflow_UPDATE
(@WorkStartDate datetime,
@WorkAssignedTo int,
@WorkEscalateTo int,
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
SET WorkStart = @WorkStartDate, WorkDue = @WorkDueDate, WorkAssignedTo = @WorkAssignedTo, WorkEscalateTo = @WorkEscalateTo,
	WorkStatus = @WorkStatus, WorkComments = @WorkComments ,  WorkStatusDate = @CompletedDate
WHERE (StyleID = @StyleID) AND (StyleSet = @StyleSet) AND (WorkflowID = @WorkflowID)


go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03452', GetDate())
	

GO


