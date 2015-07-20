/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayImageBack_DELETE_API]    Script Date: 11/07/2013 13:07:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayImageBack_DELETE_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayImageBack_DELETE_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayImageBack_DELETE_API]    Script Date: 11/07/2013 13:07:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[spx_StyleColorwayImageBack_DELETE_API](
	@StyleColorwaySeasonYearID UNIQUEIDENTIFIER
)
AS


BEGIN
	UPDATE pStyleColorwaySeasonYear SET DesignImageBackVersion=0, DesignImageBackID='00000000-0000-0000-0000-000000000000' 
	WHERE StyleColorwaySeasonYearID = @StyleColorwaySeasonYearID 
		
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06542', GetDate())
GO
