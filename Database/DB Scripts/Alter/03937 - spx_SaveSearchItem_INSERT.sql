IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SaveSearchItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SaveSearchItem_INSERT]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SaveSearchItem_INSERT]  ( 
	@TeamID uniqueidentifier
) 
AS

BEGIN
	   
	INSERT INTO pSavedSearchItem (SavedSearchID,FieldName,FieldValue,TeamID) 
	SELECT SavedSearchID, 
		   FieldName, 
		   FieldValue, 
		   TeamID 
	FROM pSavedSearchItemTemp where TeamID = @TeamID
END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03937', GetDate())
GO
