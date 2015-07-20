/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_TempColors_DELETE]    Script Date: 04/29/2013 17:03:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_TempColors_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_TempColors_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_TempColors_DELETE]    Script Date: 04/29/2013 17:03:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleBOM_TempColors_DELETE]
	@TeamID UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM pStyleBOMDimensionTempColor
    WHERE TeamID = @TeamID AND StyleBOMDimensionID = @StyleBOMDimensionID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05654', GetDate())
GO
