IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanStyleAttribute_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanStyleAttribute_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LinePlanStyleAttribute_DELETE]
	@linePlanID UNIQUEIDENTIFIER, 
	@LinePlanStyleAttributeID UNIQUEIDENTIFIER
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM 
		pLinePlanStyleAttribute
	WHERE 
		LinePlanID=@LinePlanID
		AND LinePlanStyleAttributeID=@LinePlanStyleAttributeID

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04303', GetDate())
GO
