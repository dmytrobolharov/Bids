IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TimeActionHistory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TimeActionHistory_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_TimeActionHistory_INSERT]
(@TACalTemplateId uniqueidentifier,
@TeamId uniqueidentifier,
@CreatedDate datetime)
AS 


IF (SELECT COUNT(*) FROM pTimeActionHistory WITH (NOLOCK) WHERE TeamID = @TeamID AND TACalTemplateID = @TACalTemplateID) = 0
	BEGIN
		INSERT INTO pTimeActionHistory  (TACalTemplateID, TeamID, CDate) VALUES ( @TACalTemplateID, @TeamID, @CreatedDate)
	END
Else
	BEGIN
		UPDATE pTimeActionHistory SET  CDate = @CreatedDate WHERE TACalTemplateID = @TACalTemplateID AND TeamID = @TeamID
	END

BEGIN
	DELETE FROM pTimeActionHistory WHERE TeamID = @TeamID AND  TACalTemplateID NOT IN (SELECT TOP 9 TACalTemplateID From pTimeActionHistory WITH (NOLOCK) WHERE TeamID = @TeamID ORDER BY CDate DESC)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07724', GetDate())
GO
