/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_UPDATE]    Script Date: 06/03/2013 17:15:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflow_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflow_UPDATE]
(@WorkStartDate datetime,
@WorkAssignedTo int,
@WorkStatus int,
@WorkComments nvarchar(4000),
@StyleID nvarchar(50),
@StyleSet nvarchar(50),
@WorkflowID nvarchar(50),
@SeasonYearID nvarchar(50),
@WorkDueDate nvarchar(50),
@MUser nvarchar(100),
@MDate datetime)
AS 

DECLARE @CompletedDate as datetime,
		@StyleSeasonYearID uniqueidentifier,
		@IsSeasonal INT

IF @WorkStatus  = 100  
	SET @CompletedDate  = @MDate
ELSE
	SET @CompletedDate  = NULL
	
SELECT @IsSeasonal = IsSeasonal FROM Mapping WHERE Map = @WorkflowID
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID

UPDATE  dbo.pStyleWorkflow
SET WorkStart = @WorkStartDate, WorkDue = @WorkDueDate, WorkAssignedTo = @WorkAssignedTo, WorkStatus = @WorkStatus, 
 WorkComments = @WorkComments ,  WorkStatusDate = @CompletedDate
WHERE (StyleID = @StyleID) AND (StyleSet = @StyleSet) AND (WorkflowID = @WorkflowID)
	AND (@IsSeasonal = 1 AND StyleSeasonYearID = @StyleSeasonYearID OR @IsSeasonal <> 1)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05796', GetDate())
GO
