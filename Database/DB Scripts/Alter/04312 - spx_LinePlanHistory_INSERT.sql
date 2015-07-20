IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanHistory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanHistory_INSERT]
GO
CREATE PROCEDURE [dbo].[spx_LinePlanHistory_INSERT]
(@LinePlanId uniqueidentifier,
@TeamId uniqueidentifier,
@CreatedDate datetime)
AS 


IF (SELECT COUNT(*) FROM pLinePlanHistory WITH (NOLOCK) WHERE TeamID = @TeamID AND LinePlanId = @LinePlanId) = 0
	BEGIN
		INSERT INTO pLinePlanHistory  (LinePlanId, TeamID, CDate) VALUES ( @LinePlanId, @TeamID, @CreatedDate)
	END
ELSE
	BEGIN
		UPDATE pLinePlanHistory SET  CDate = @CreatedDate WHERE LinePlanId = @LinePlanId AND TeamID = @TeamID
	END

BEGIN
	DELETE FROM pLinePlanHistory WHERE TeamID = @TeamID AND  LinePlanId NOT IN (SELECT TOP 9 LinePlanId From pLinePlanHistory WITH (NOLOCK) WHERE TeamID = @TeamID ORDER BY CDate DESC)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04312', GetDate())
GO
