/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayImageBack_CREATE_API]    Script Date: 11/21/2013 13:48:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayImageBack_CREATE_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayImageBack_CREATE_API]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayImageBack_CREATE_API]    Script Date: 11/21/2013 13:48:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[spx_StyleColorwayImageBack_CREATE_API](
	@StyleID UNIQUEIDENTIFIER,
	@ImageID UNIQUEIDENTIFIER,
	@ColorID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@ImageVersion INT
)
AS

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
SELECT @StyleSeasonYearID = StyleSeasonYearID FROm pStyleSeasonYear
WHERE StyleID=@StyleID and SeasonYearID=@SeasonYearID

BEGIN
	UPDATE pStyleColorwaySeasonYear SET DesignImageBackVersion=@ImageVersion, DesignImageBackID=@ImageID 
	WHERE StyleID = @StyleID and StyleColorwayID= @ColorID and StyleSeasonYearID = @StyleSeasonYearID
		
	UPDATE pStyleColorwaySeasonYear SET DesignImageBackVersion=@ImageVersion, DesignImageBackID=@ImageID 
	WHERE StyleID = @StyleID and ColorPaletteID= @ColorID and StyleSeasonYearID = @StyleSeasonYearID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06639', GetDate())
GO