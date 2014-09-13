/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayImageFront_CREATE_API]    Script Date: 11/05/2013 13:26:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayImageFront_CREATE_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayImageFront_CREATE_API]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayImageFront_CREATE_API]    Script Date: 11/05/2013 13:26:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[spx_StyleColorwayImageFront_CREATE_API](
	@StyleID UNIQUEIDENTIFIER,
	@ImageID UNIQUEIDENTIFIER,
	@StyleColorwayID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@ImageVersion INT
)
AS

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear
WHERE StyleID=@StyleID and SeasonYearID=@SeasonYearID

BEGIN
	UPDATE pStyleColorwaySeasonYear SET DesignImageFrontVersion=@ImageVersion, DesignImageFrontID=@ImageID 
	WHERE StyleID = @StyleID and StyleColorwayID= @StyleColorwayID and StyleSeasonYearID = @StyleSeasonYearID
		
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06523', GetDate())
GO