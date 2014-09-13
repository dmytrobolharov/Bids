/****** Object:  StoredProcedure [dbo].[spx_MaterialContent_DELETE]    Script Date: 05/20/2013 17:26:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialContent_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialContent_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialContent_DELETE]
(
@MaterialId uniqueidentifier
)
AS 


DELETE FROM pMaterialContent WHERE MaterialId = @MaterialId
DELETE FROM tmpMaterialColor WHERE MaterialID = @MaterialId
DELETE FROM tmpMaterialSeasonYear WHERE MaterialID = @MaterialId

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05716', GetDate())
GO
