IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SystemServerStorageLineList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SystemServerStorageLineList_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_SystemServerStorageLineList_SELECT](@LineListDocumentID uniqueidentifier)
AS 

IF (SELECT COUNT(*) FROM pLineListDocument WHERE LineListDocumentID = @LineListDocumentID) = 0
	BEGIN
		SELECT TOP 1 
			sSystemServerStorageSetting.LineListPath  
		 FROM sSystemServerStorageSetting 
		WHERE CurrentServerStorage = 1
	END
ELSE
	BEGIN
		SELECT 
			sSystemServerStorageSetting.LineListPath  
		FROM pLineListDocument WITH (NOLOCK) INNER JOIN
			  sSystemServerStorageSetting WITH (NOLOCK) ON pLineListDocument.SystemServerStorageID = sSystemServerStorageSetting.SystemServerStorageID
		WHERE (pLineListDocument.LineListDocumentID = @LineListDocumentID)  
	END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07180', GetDate())
GO
