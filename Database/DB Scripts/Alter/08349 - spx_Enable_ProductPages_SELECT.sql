IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Enable_ProductPages_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Enable_ProductPages_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Enable_ProductPages_SELECT]
	@FolderTypeId INT,
	@ProductId UNIQUEIDENTIFIER
AS
BEGIN
	IF @FolderTypeId = '2' 
		BEGIN
		SELECT EnableProductPages FROM pStyleHeader WHERE StyleID = @ProductId 
	END
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08349', GetDate())
GO


