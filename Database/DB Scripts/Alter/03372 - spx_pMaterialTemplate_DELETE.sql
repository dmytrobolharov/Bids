/****** Object:  StoredProcedure [dbo].[spx_pMaterialTemplate_DELETE]    Script Date: 04/18/2012 15:35:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pMaterialTemplate_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pMaterialTemplate_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_pMaterialTemplate_DELETE]    Script Date: 04/18/2012 15:35:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_pMaterialTemplate_DELETE]
	@MaterialTemplateID UNIQUEIDENTIFIER
AS
BEGIN
	DELETE FROM pMaterialTemplateItem WHERE MaterialTemplateID = @MaterialTemplateID
	DELETE FROM pMaterialTemplate WHERE MaterialTemplateID = @MaterialTemplateID
END

GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03372', GetDate())

GO