/****** Object:  StoredProcedure [dbo].[spx_StyleColorway_Cleanup_DELETE]    Script Date: 03/18/2014 13:29:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_Cleanup_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorway_Cleanup_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleColorway_Cleanup_DELETE]    Script Date: 03/18/2014 13:29:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_StyleColorway_Cleanup_DELETE]
	@StyleID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM pStyleColorway
    WHERE StyleID = @StyleID
    AND StyleColorID NOT IN (
		SELECT DISTINCT StyleColorwayID FROM pStyleColorwaySeasonYear WHERE StyleID = @StyleID
		UNION
		SELECT DISTINCT StyleColorID FROM pStyleColorwayItem WHERE StyleID = @StyleID AND MaterialColorID IS NOT NULL
    )
    
    DELETE FROM pStyleColorwayItem
    WHERE StyleID = @StyleID
    AND StyleColorID NOT IN (SELECT StyleColorID FROM pStyleColorway WHERE StyleID = @StyleID)
    
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07267', GetDate())
GO
