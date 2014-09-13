/****** Object:  StoredProcedure [dbo].[spx_pMaterialTemplateItem_DELETE]    Script Date: 04/18/2012 15:37:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pMaterialTemplateItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pMaterialTemplateItem_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_pMaterialTemplateItem_DELETE]    Script Date: 04/18/2012 15:37:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_pMaterialTemplateItem_DELETE]
(@MaterialTemplatePageID uniqueidentifier,
@MaterialTemplateID uniqueidentifier)
AS 

DELETE FROM pMaterialTemplateItem
WHERE  (MaterialTemplatePageID = @MaterialTemplatePageID) AND (MaterialTemplateID = @MaterialTemplateID)

GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03373', GetDate())

GO