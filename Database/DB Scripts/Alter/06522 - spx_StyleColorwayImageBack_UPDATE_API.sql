/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayImageBack_UPDATE_API]    Script Date: 11/05/2013 13:26:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayImageBack_UPDATE_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayImageBack_UPDATE_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayImageBack_UPDATE_API]    Script Date: 11/05/2013 13:26:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[spx_StyleColorwayImageBack_UPDATE_API](
	@StyleColorwaySeasonYearID UNIQUEIDENTIFIER,
	@ImageVersion INT
)
AS



BEGIN
	UPDATE pStyleColorwaySeasonYear SET DesignImageBackVersion=@ImageVersion 
	WHERE StyleColorwaySeasonYearID = @StyleColorwaySeasonYearID 
		
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06522', GetDate())
GO