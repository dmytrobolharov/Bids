IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanStyleColorway_UnlockLogic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanStyleColorway_UnlockLogic_UPDATE]
GO


CREATE PROCEDURE dbo.spx_LinePlanStyleColorway_UnlockLogic_UPDATE(
	@StyleColorwaySeasonYearID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS


UPDATE pStyleColorwaySeasonYear
SET Locked = 0, MUser = @MUser, MDate = @MDate
WHERE StyleColorwaySeasonYearID = @StyleColorwaySeasonYearID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '783', GetDate())
GO
