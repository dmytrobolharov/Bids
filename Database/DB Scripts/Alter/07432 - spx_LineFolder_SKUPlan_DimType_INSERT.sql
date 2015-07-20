IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SKUPlan_DimType_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SKUPlan_DimType_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_SKUPlan_DimType_INSERT]
	@LineFolderSKUHeaderID UNIQUEIDENTIFIER,	
	@DimTypeID UNIQUEIDENTIFIER,
	@Position INT
AS
BEGIN
	
	IF NOT EXISTS(SELECT * FROM pLineFolderSKUHeaderDimType WHERE LineFolderSKUHeaderID = @LinefolderSKUHeaderID AND DimTypeID = @DimTypeID)
	BEGIN
		INSERT INTO pLineFolderSKUHeaderDimType(LineFolderSKUHeaderID, DimTypeID, Position)
		VALUES (@LineFolderSKUHeaderID, @DimTypeID, @Position)
	END
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07432', GetDate())
GO
