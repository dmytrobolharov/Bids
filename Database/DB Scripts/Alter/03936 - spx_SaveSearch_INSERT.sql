IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SaveSearch_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SaveSearch_INSERT]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SaveSearch_INSERT]  ( 
	@TeamID uniqueidentifier, 
	@StyleTypeID int,
	@SearchName nvarchar(500),
	@SearchDescription nvarchar(MAX),
	@Active int,
	@CDate datetime,
	@CUser nvarchar(200),
	@MDate datetime,
	@MUser nvarchar(200)
	) 
AS

BEGIN 
	IF (SELECT COUNT(*) FROM pSavedSearch) = 0 
	BEGIN
		INSERT INTO pSavedSearch (TeamID,StyleTypeID, SearchName, SearchDescription, Active, CDate, CUser, MDate, MUser) 
		VALUES (@TeamID,@StyleTypeID,@SearchName, @SearchDescription, @Active, @CDate, @CUser, @MDate, @MUser)
	END
END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03936', GetDate())
GO
