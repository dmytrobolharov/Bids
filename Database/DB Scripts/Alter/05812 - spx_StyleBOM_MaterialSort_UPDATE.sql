/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_MaterialSort_UPDATE]    Script Date: 06/06/2013 14:21:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_MaterialSort_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_MaterialSort_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_MaterialSort_UPDATE]    Script Date: 06/06/2013 14:21:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleBOM_MaterialSort_UPDATE]
	@StyleMaterialID UNIQUEIDENTIFIER,
	@MaterialSort VARCHAR(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE pStyleBOM SET MaterialSort = @MaterialSort
	WHERE StyleMaterialID = @StyleMaterialID
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05812', GetDate())
GO
