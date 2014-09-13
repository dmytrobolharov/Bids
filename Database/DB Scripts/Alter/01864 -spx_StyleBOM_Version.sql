IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_Version]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOM_Version]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_Version]    Script Date: 09/06/2011 11:59:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_StyleBOM_Version](@StyleMaterialID uniqueidentifier)
AS SELECT     dbo.pStyleBOM.MChange AS StyleMaterialVersion, dbo.pMaterial.MChange AS MaterialVersion, dbo.pStyleBOM.MaterialID
FROM         dbo.pStyleBOM WITH (NOLOCK) INNER JOIN
                      dbo.pMaterial WITH (NOLOCK) ON dbo.pStyleBOM.MaterialID = dbo.pMaterial.MaterialID
WHERE     (dbo.pStyleBOM.StyleMaterialID = @StyleMaterialID)

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01864'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01864', GetDate())
END

GO