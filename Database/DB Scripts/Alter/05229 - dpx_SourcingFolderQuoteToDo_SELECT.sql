
/****** Object:  StoredProcedure [dbo].[dpx_SourcingFolderQuoteToDo_SELECT]    Script Date: 03/04/2013 13:48:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_SourcingFolderQuoteToDo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_SourcingFolderQuoteToDo_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[dpx_SourcingFolderQuoteToDo_SELECT]    Script Date: 03/04/2013 13:48:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[dpx_SourcingFolderQuoteToDo_SELECT]
	@SourcingHeaderID UNIQUEIDENTIFIER = NULL
AS
BEGIN	
	SELECT	SourcingHeaderID,	SourcingName FROM pSourcingHeader	WHERE SourcingHeaderID=@SourcingHeaderID		
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05229', GetDate())
GO
