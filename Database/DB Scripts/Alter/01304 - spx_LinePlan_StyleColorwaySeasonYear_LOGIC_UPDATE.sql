IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_StyleColorwaySeasonYear_LOGIC_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_StyleColorwaySeasonYear_LOGIC_UPDATE]
GO


CREATE PROCEDURE dbo.spx_LinePlan_StyleColorwaySeasonYear_LOGIC_UPDATE(
	@StyleColorwaySeasonYearID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME,
	@SQLUpdate NVARCHAR(MAX)
)
AS

EXECUTE sp_executesql @SQLUpdate


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01304', GetDate())

GO









