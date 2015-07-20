IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanShowroom_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanShowroom_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LinePlanShowroom_DELETE]
	@linePlanID UNIQUEIDENTIFIER, 
	@ShowroomID UNIQUEIDENTIFIER
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM 
		pLinePlanShowroom
	WHERE 
		LinePlanID=@LinePlanID
		AND ShowroomID=@ShowroomID 

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04302', GetDate())
GO
