IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SELECT] (
@PlanningId uniqueidentifier
)

AS
BEGIN

	SELECT * FROM pPlanning WHERE PlanningID = @PlanningId
    
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07474', GetDate())
GO