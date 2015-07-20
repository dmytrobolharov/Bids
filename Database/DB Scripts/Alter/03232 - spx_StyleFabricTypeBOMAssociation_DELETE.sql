/****** Object:  StoredProcedure [dbo].[spx_StyleFabricTypeBOMAssociation_DELETE]    Script Date: 03/14/2012 15:12:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFabricTypeBOMAssociation_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFabricTypeBOMAssociation_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleFabricTypeBOMAssociation_DELETE]    Script Date: 03/14/2012 15:12:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleFabricTypeBOMAssociation_DELETE]
	@CADModel2BOMID UNIQUEIDENTIFIER
AS
BEGIN
	DELETE FROM pCADModel2BOM WHERE CADModel2BOMId = @CADModel2BOMId
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03232'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03232', GetDate())

END

GO 