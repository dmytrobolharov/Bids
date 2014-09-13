/****** Object:  StoredProcedure [dbo].[spx_StyleColorwaySeasonYear_Cleanup_DELETE]    Script Date: 03/18/2014 13:31:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwaySeasonYear_Cleanup_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwaySeasonYear_Cleanup_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleColorwaySeasonYear_Cleanup_DELETE]    Script Date: 03/18/2014 13:31:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_StyleColorwaySeasonYear_Cleanup_DELETE]
	@StyleID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DELETE FROM pStyleColorwaySeasonYear
	WHERE StyleColorwayID NOT IN (
		SELECT ItemDim1ID FROM pStyleBOMDimensionItem WHERE StyleID = @StyleID AND ItemDim1ID IS NOT NULL
		UNION
		SELECT ItemDim2ID FROM pStyleBOMDimensionItem WHERE StyleID = @StyleID AND ItemDim2ID IS NOT NULL
		UNION
		SELECT ItemDim3ID FROM pStyleBOMDimensionItem WHERE StyleID = @StyleID AND ItemDim3ID IS NOT NULL
		UNION
		SELECT StyleColorID FROM pStyleColorwayItem WHERE StyleID = @StyleID AND MaterialColorID IS NOT NULL
	)
	AND StyleID = @StyleID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07271', GetDate())
GO
