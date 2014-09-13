IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_LinkedStyleCOSession_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_LinkedStyleCOSession_DELETE]
GO

CREATE PROCEDURE dbo.spx_LinePlan_LinkedStyleCOSession_DELETE(
	@TeamID UNIQUEIDENTIFIER,
	@ClientSessionID NVARCHAR(40)
)
AS

	DELETE FROM pLinePlanStyleLinkedTemp 
	WHERE TeamID = @TeamID
	OR ClientSessionID = @ClientSessionID
	
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01052', GetDate())
GO