IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningActivity_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningActivity_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_PlanningActivity_INSERT]
(
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,	
	@TeamID UNIQUEIDENTIFIER,
	@CreatedBy NVARCHAR(200),
	@CreatedDate DATETIME,
	@PlanningActivityTypeID UNIQUEIDENTIFIER,
	@ParamValues NVARCHAR(200)
)
AS
BEGIN

	INSERT INTO pPlanningActivity
	   ([PlanningActivityID]
	   ,[PlanningActivityTypeID]
	   ,[PlanningID]
	   ,[SeasonYearID]
	   ,[StyleID]
	   ,[TeamID]
	   ,[CDate]
	   ,[CUser]
	   ,[ParamValues])
	VALUES
	   (NEWID()
	   ,@PlanningActivityTypeID
	   ,@PlanningID
	   ,@SeasonYearID
	   ,@StyleID
	   ,@TeamID
	   ,@CreatedDate
	   ,@CreatedBy
	   ,@ParamValues)		

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07943', GetDate())
GO
