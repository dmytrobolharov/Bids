IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialNew_Size_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialNew_Size_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialNew_Size_INSERT]
	@MaterialSizeID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialSize NVARCHAR(200),
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	INSERT INTO pMaterialSize(MaterialSizeID, MaterialID, MaterialSize, MaterialPrice, CUser, CDate, MUser, MDate)
	VALUES (@MaterialSizeID, @MaterialID, @MaterialSize, 0, @CUser, @CDate, @CUser, @CDate)
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06098', GetDate())
GO
