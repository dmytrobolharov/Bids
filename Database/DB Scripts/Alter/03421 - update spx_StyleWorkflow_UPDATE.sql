
-- if drop...etc..
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_UPDATE]'))
drop procedure spx_StyleWorkflow_UPDATE
go


create procedure spx_StyleWorkflow_UPDATE
(
	@StyleWorkflowID			uniqueidentifier,
	
	@WorkflowOrder				int,
	@WorkDay					int,
	@WorkDue					datetime,
	@WorkStart					datetime,
	@ActualCompletedDate		datetime,
	
	@MUser						nvarchar(50),
	@MDate						datetime
)
as

 
 update pStyleWorkflow
    set WorkflowOrder = @WorkflowOrder,
		WorkDay = @WorkDay,
		WorkDue = @WorkDue,
		WorkStart = @WorkStart,
		ActualCompletedDate = @ActualCompletedDate,
	    MUser = @MUser,
	    MDate = @MDate
  where StyleWorkflowID = @StyleWorkflowID 

go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03421', GetDate())
	

GO


