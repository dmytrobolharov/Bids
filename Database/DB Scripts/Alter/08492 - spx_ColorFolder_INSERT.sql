IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolder_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolder_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ColorFolder_INSERT] (
	  @ColorFolderID UNIQUEIDENTIFIER
	, @CUser NVARCHAR(200)
	, @CDate DATETIME)
AS 

DECLARE @SystemStorageID uniqueidentifier
SET @SystemStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WHERE CurrentServerStorage = 1),'00000000-0000-0000-0000-000000000000')


INSERT INTO pColorFolder (
	ColorFolderID, CUser, CDate, MUser, MDate, MChange, SystemServerStorageID) 
VALUES (
	@ColorFolderID, @CUser, @CDate, @CUser, @CDate, 1, @SystemStorageID)

INSERT INTO pColorFolderWorkflowPage(
	ColorFolderID, ColorFolderWorkflowID, WorkStatus,
	CUser, CDate, MUser, MDate, Sort)
SELECT cf.ColorFolderID, '10000000-0000-0000-0000-000000000000', 1,
	@CUser, @CDate, @CUser, @CDate, '0001'
FROM pColorFolder cf
LEFT JOIN pColorFolderWorkflowPage cfwp ON cf.ColorFolderID = cfwp.ColorFolderID 
	AND ColorFolderWorkflowID = '10000000-0000-0000-0000-000000000000'
WHERE cf.ColorFolderID = @ColorFolderID AND cfwp.ColorFolderWorkflowPageID IS NULL

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08492', GetDate())
GO
