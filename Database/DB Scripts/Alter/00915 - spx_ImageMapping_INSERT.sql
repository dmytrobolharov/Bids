
/****** Object:  StoredProcedure [dbo].[spx_ImageMappingMaterialLogic_UPDATE]    Script Date: 12/24/2010 13:02:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageMappingMaterialLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageMappingMaterialLogic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_ImageMappingStyleLogic_UPDATE]    Script Date: 12/24/2010 13:02:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageMappingStyleLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageMappingStyleLogic_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_ImageMappingMaterialLogic_UPDATE]    Script Date: 12/24/2010 13:02:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ImageMappingMaterialLogic_UPDATE]
(@MaterialID uniqueidentifier,
@ImageID uniqueidentifier,
@ImageVersion int)
AS 

BEGIN 
	UPDATE dbo.pMaterial SET 
		pMaterial.Z = pImage.ImageSubFolder1 
	FROM pImage 
	WHERE (pImage.ImageID = @ImageID) 
		AND (pImage.Version = @ImageVersion) 
		AND (pMaterial.MaterialID = @MaterialID)
END 


GO

/****** Object:  StoredProcedure [dbo].[spx_ImageMappingStyleLogic_UPDATE]    Script Date: 12/24/2010 13:02:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ImageMappingStyleLogic_UPDATE]
(@StyleID uniqueidentifier,
@ImageID uniqueidentifier,
@ImageVersion int)
AS 

BEGIN 
	UPDATE dbo.pStyleHeader SET 
		pStyleHeader.CustomField30 = hImage.ImageSubFolder1 
	FROM hImage 
	WHERE (hImage.ImageID = @ImageID) 
		AND (hImage.Version = @ImageVersion) 
		AND (pStyleHeader.StyleID = @StyleID)
END 




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '915', GetDate())
GO