IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SaveSearchItemTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SaveSearchItemTemp_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SaveSearchItemTemp_INSERT]  ( 
	@SavedSearchID uniqueidentifier, 
	@FieldName nvarchar(500),
	@FieldValue nvarchar(500),
	@TeamID uniqueidentifier
) 
AS

BEGIN 
	BEGIN
		INSERT INTO pSavedSearchItemTemp (SavedSearchID, FieldName, FieldValue, TeamID) 
		VALUES (@SavedSearchID, @FieldName, @FieldValue, @TeamID)
	END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03939', GetDate())
GO
