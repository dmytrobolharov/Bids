IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_SavedSearchItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_SavedSearchItem_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Style_SavedSearchItem_DELETE] (
@SavedSearchID UNIQUEIDENTIFIER 
)
AS 

DELETE FROM pSavedSearch WHERE SavedSearchID = @SavedSearchID
DELETE FROM pSavedSearchItem WHERE SavedSearchID = @SavedSearchID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03940', GetDate())
GO
