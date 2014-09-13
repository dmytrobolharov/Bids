/****** Object:  StoredProcedure [dbo].[spx_ColorFolder_DELETE]    Script Date: 08/22/2014 15:40:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolder_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolder_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorFolder_DELETE]    Script Date: 08/22/2014 15:40:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ColorFolder_DELETE]
@ColorFolderID  uniqueidentifier
AS 
BEGIN
	
	-- Breaking the connections between all the calendars
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER
	
	DECLARE CalendarsCursor CURSOR SCROLL FOR
	SELECT TACalTemplateID FROM pTACalReference 
	WHERE ReferenceId = @ColorFolderId AND TACalReferenceTypeId = 7
	
	OPEN CalendarsCursor
	FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC spx_TACalReferenceFromColor_DELETE @TACalTemplateID, @ColorFolderID
		FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	END
	CLOSE CalendarsCursor
	DEALLOCATE CalendarsCursor

	DELETE FROM pColorFolder WHERE ColorFolderID  = @ColorFolderId

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08966', GetDate())
GO
