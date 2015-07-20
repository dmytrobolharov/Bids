IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageNewCopy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageNewCopy_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ImageNewCopy_INSERT]  (
@ImageHID  uniqueidentifier ,  
@ImageNID uniqueidentifier  ,
@CreatedName  nvarchar (200) , 
@CreatedDate datetime ,
@ImageID uniqueidentifier , 
@Version int,
@TradePartnerID uniqueidentifier = null
)
AS

DECLARE @SystemStorageID uniqueidentifier
SET @SystemStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WHERE CurrentServerStorage = 1),'00000000-0000-0000-0000-000000000000')


INSERT INTO hImage  (ImageHistoryID, ImageID, WorkflowID, ImageTypeID, ImageFileType, ImageCode, ImageDescription, ImageKeywords, ImageLocation, ImageDateLastAccessed, 
	 ImageDateLastModified, ImageFile, ImageSize, ImageType, ImageMainFolder, ImageSubFolder, ImageUserFolder, ImageSubFolder1, 
               ImageSubFolder2, ImageSubFolder3, ImageSubFolder4, ImageSubFolder5, ImageSubFolder6, ImageSubFolder7, ImageSubFolder8, ImageSubFolder9, 
	 ImageSubFolder10,ImageSubFolder11,ImageSubFolder12, ImageSubFolder13, ImageSubFolder14, ImageSubFolder15, ImageSubFolder16, ImageSubFolder17, ImageSubFolder18, ImageSubFolder19, 
	 CUser, CDate, MUser, MDate, Version, Classic, LockID, LockUser, LockUserName, SystemServerStorageID)
SELECT  @ImageHID  AS ImageHistoryID,  @ImageNID AS ImageID, WorkflowID, ImageTypeID, ImageFileType, ImageCode, ImageDescription, ImageKeywords, 
	ImageLocation, ImageDateLastAccessed, ImageDateLastModified, ImageFile, ImageSize, ImageType, ImageMainFolder, ImageSubFolder, 
	 ImageUserFolder, ImageSubFolder1, ImageSubFolder2, ImageSubFolder3, ImageSubFolder4, ImageSubFolder5, ImageSubFolder6, ImageSubFolder7, 
	ImageSubFolder8, ImageSubFolder9,
	ImageSubFolder10,ImageSubFolder11,ImageSubFolder12, ImageSubFolder13, ImageSubFolder14, ImageSubFolder15, ImageSubFolder16, ImageSubFolder17, ImageSubFolder18, ImageSubFolder19, 
	@CreatedName  AS CUser,  @CreatedDate AS CDate,  @CreatedName   AS  MUser, @CreatedDate AS MDate, 1 AS  Version, Classic, 
	0 AS _LockID, 0 AS _LockUser, 'UNKNOWN' AS _LockUserName, @SystemStorageID AS SystemServerStorageID 
FROM hImage WITH (NOLOCK)
 WHERE ImageID =  @ImageID AND Version =  @Version 

INSERT INTO pImage  (ImageID, WorkflowID, ImageTypeID, ImageFileType, ImageCode, ImageDescription, ImageKeywords, ImageLocation, ImageDateLastAccessed, 
	ImageDateLastModified, ImageFile, ImageSize, ImageType, ImageMainFolder, ImageSubFolder, ImageUserFolder, ImageSubFolder1, 
	ImageSubFolder2, ImageSubFolder3, ImageSubFolder4, ImageSubFolder5, ImageSubFolder6, ImageSubFolder7, ImageSubFolder8, ImageSubFolder9, 
	ImageSubFolder10,ImageSubFolder11,ImageSubFolder12, ImageSubFolder13, ImageSubFolder14, ImageSubFolder15, ImageSubFolder16, ImageSubFolder17, ImageSubFolder18, ImageSubFolder19, 
	CUser, CDate, MUser, MDate, Version, ImageCopyID, ImageCopyVersion, ImageCopyUser, ImageCopyDate, SystemServerStorageID, TradePartnerID, ImageWorkflowTemplateID)
SELECT @ImageNID AS  ImageID, a.WorkflowID, a.ImageTypeID, a.ImageFileType, a.ImageCode, a.ImageDescription, a.ImageKeywords, b.ImageLocation, a.ImageDateLastAccessed, 
	a.ImageDateLastModified, b.ImageFile,  a.ImageSize, a.ImageType, a.ImageMainFolder, a.ImageSubFolder, a.ImageUserFolder, a.ImageSubFolder1, 
	a.ImageSubFolder2, a.ImageSubFolder3, a.ImageSubFolder4, a.ImageSubFolder5, a.ImageSubFolder6, a.ImageSubFolder7, a.ImageSubFolder8, a.ImageSubFolder9, 
	a.ImageSubFolder10, a.ImageSubFolder11, a.ImageSubFolder12, a.ImageSubFolder13, a.ImageSubFolder14, a.ImageSubFolder15, a.ImageSubFolder16, a.ImageSubFolder17, a.ImageSubFolder18, a.ImageSubFolder19, 
	@CreatedName  AS  CUser, @CreatedDate AS CDate, @CreatedName AS MUser, @CreatedDate AS MDate, 1 AS  Version,  @ImageID  AS ImageCopyID , 
	@Version AS ImageCopyVersion , @CreatedName  AS  ImageCopyUser , @CreatedDate AS  ImageCopyDate, @SystemStorageID AS SystemServerStorageID, @TradePartnerID AS TradePartnerID, a.ImageWorkflowTemplateID
	FROM pImage a WITH (NOLOCK) ,  hImage  b WITH (NOLOCK)
	WHERE a.ImageID = @ImageID
	AND a.ImageID = b.ImageID 
	AND b.Version = @Version

EXEC spx_ImageWorkflow_Logic_UPDATE @ImageID = @ImageNID, @CUser = @CreatedName, @CDate = @CreatedDate

DECLARE @ImageWorkflowTemplate UNIQUEIDENTIFIER

SELECT @ImageWorkflowTemplate = ImageWorkflowTemplateID FROM pImage WHERE ImageID = @ImageID

EXEC spx_Image_New_WorkflowStatus_UPDATE @ImageId = @ImageNID, @ImageWorkflowTemplateID = @ImageWorkflowTemplate

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08984', GetDate())
GO