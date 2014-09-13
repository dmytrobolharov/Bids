IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowDependency_UPDATE]'))
drop procedure spx_StyleWorkflowDependency_UPDATE
  go

create procedure [dbo].[spx_StyleWorkflowDependency_UPDATE]
(
	@StyleWorkflowID			uniqueidentifier,
	
	@WorkSort   				int,
	@WorkDay					int,
	@WorkDue					datetime,
	@WorkStart					datetime,
	@ActualCompletedDate		datetime,
	@StyleSet					int,
	
	@MUser						nvarchar(50),
	@MDate						datetime
)
as

 
 update pStyleWorkflow
    set WorkSort = @WorkSort,
		WorkDay = @WorkDay,
		WorkDue = @WorkDue,
		WorkStart = @WorkStart,
		ActualCompletedDate = @ActualCompletedDate,
	    MUser = @MUser,
	    MDate = @MDate
  where StyleWorkflowID = @StyleWorkflowID 
    and StyleSet = @StyleSet

go    
    




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03644', GetDate())

GO

