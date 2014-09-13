IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMPending_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMPending_DELETE]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMPending_DELETE]    Script Date: 09/06/2011 11:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spx_StyleBOMPending_DELETE]
(
@StyleMaterialID uniqueidentifier
)
AS 

	DELETE FROM pStyleBOMTemp  WHERE (StyleMaterialID = @StyleMaterialID)
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01861'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01861', GetDate())
END

GO