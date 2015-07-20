IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SKUHeader_CHECK]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SKUHeader_CHECK]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_SKUHeader_CHECK]
	@SKUHeaderID UNIQUEIDENTIFIER
AS
BEGIN
	
	IF EXISTS(SELECT * FROM pPlanningSKUHeader WHERE PlanningSKUHeaderID = @SKUHeaderID	)
		SELECT 1 AS PlanningSKU
	ELSE
		SELECT 0 AS PlanningSKU
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08121', GetDate())
GO
