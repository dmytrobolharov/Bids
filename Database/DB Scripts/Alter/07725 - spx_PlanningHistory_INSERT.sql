/****** Object:  StoredProcedure [dbo].[spx_PlanningHistory_INSERT]    Script Date: 05/22/2014 16:49:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningHistory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningHistory_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_PlanningHistory_INSERT]    Script Date: 05/22/2014 16:49:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_PlanningHistory_INSERT]
(@PlanningId uniqueidentifier,
@TeamId uniqueidentifier,
@CreatedDate datetime)
AS 


IF (SELECT COUNT(*) FROM pPlanningHistory WITH (NOLOCK) WHERE TeamID = @TeamID AND PlanningID = @PlanningId) = 0
	BEGIN
		INSERT INTO pPlanningHistory  (PlanningID, TeamID, CDate) VALUES ( @PlanningId, @TeamID, @CreatedDate)
	END
Else
	BEGIN
		UPDATE pPlanningHistory SET  CDate = @CreatedDate WHERE PlanningID = @PlanningId AND TeamID = @TeamID
	END

BEGIN
	DELETE FROM pPlanningHistory WHERE TeamID = @TeamID AND  PlanningID NOT IN (SELECT TOP 9 PlanningID From pPlanningHistory WITH (NOLOCK) WHERE TeamID = @TeamID ORDER BY CDate DESC)
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07725', GetDate())
GO