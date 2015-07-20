/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_INSERT]    Script Date: 06/04/2013 14:23:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflow_INSERT]
GO

CREATE  PROCEDURE [dbo].[spx_StyleWorkflow_INSERT]

(@StyleID uniqueidentifier,
@StyleSet int = 1,
@WorkflowID uniqueidentifier,
@WorkflowType int = 0,
@WorkDate datetime,
@WorkStart datetime,
@WorkDue datetime,
@WorkAssignedTo int =0,
@WorkStatus int=6,
@WorkVersion int=0,
@WorkComments nvarchar(4000),
@WorkSort nvarchar(2),
@UserName nvarchar(100),
@UserDate datetime= GETDATE  ,
@WorkDay int ) 


AS

DECLARE @IsSeasonal INT = (SELECT IsSeasonal FROM Mapping WHERE Map = @WorkflowID) 

IF (SELECT COUNT(StyleSet)  FROM  pStyleWorkflow WITH (NOLOCK) WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID ) = 0 
	BEGIN 
	
	-- insert missing seasonal workflows for all season years
	if @IsSeasonal = 1	
	begin
		INSERT INTO pStyleWorkflow
			(StyleID, StyleSet, WorkflowID, WorkflowType, WorkDate, WorkStart, WorkDue, WorkAssignedTo,  WorkStatus, 
			WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate, WorkDay, StyleSeasonYearID)
		SELECT @StyleID, @StyleSet, @WorkflowID, @WorkflowType, @WorkDate, @WorkStart, @WorkDue, @WorkAssignedTo, 
			 @WorkStatus, @WorkVersion, @WorkComments, @WorkSort, @UserName, @UserDate, @UserName, @UserDate, @WorkDay, StyleSeasonYearID
		FROM pStyleSeasonYear WHERE StyleID = @StyleID 
			AND StyleSeasonYearID NOT IN (SELECT StyleSeasonYearID FROM pStyleWorkflow WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID)
	end
	else
	begin
		INSERT INTO pStyleWorkflow
			(StyleID, StyleSet, WorkflowID, WorkflowType, WorkDate, WorkStart, WorkDue, WorkAssignedTo,  WorkStatus, 
			WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate, WorkDay)
		VALUES (@StyleID, @StyleSet, @WorkflowID, @WorkflowType, @WorkDate, @WorkStart, @WorkDue, @WorkAssignedTo, 
			 @WorkStatus, @WorkVersion, @WorkComments, @WorkSort, @UserName, @UserDate, @UserName, @UserDate, @WorkDay )
	end	
	
	END
ELSE
	BEGIN
	UPDATE  pStyleWorkflow
	SET  WorkDate = @WorkDate, WorkStart = @WorkStart, WorkDue = @WorkDue, WorkAssignedTo = @WorkAssignedTo, WorkVersion = @WorkVersion, 
		WorkComments = @WorkComments, WorkSort = @WorkSort, MUser = @UserName, MDate = @UserDate ,  WorkDay = @WorkDay	
	WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND WorkflowID = @WorkflowID
	END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05800', GetDate())
GO
