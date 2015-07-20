IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageCatalogItem_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ImageCatalogItem_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ImageCatalogItem_INSERT]
(
@ImageCatalogItemID uniqueidentifier,
@ImageCatalogID uniqueidentifier,
@ImageID uniqueidentifier,
@ImageVersion int,
@UserName nvarchar(100),
@UserDate datetime
)
AS 

DECLARE @Version1 INT  
DECLARE @Version2 INT  

SELECT @Version1 = a.Version  FROM pImage  a  where a.ImageID = @ImageID
SELECT @Version2 =MAX(Version) FROM hImage  where ImageID = @ImageID

IF @Version2 = @Version1
      SET @ImageVersion  = @Version1
ELSE
      SET @ImageVersion = 1 


IF (SELECT COUNT(*)  FROM pImageCatalogItem WHERE ImageID = @ImageID AND ImageCatalogID = @ImageCatalogID )  = 0
BEGIN
      INSERT INTO dbo.pImageCatalogItem(
		ImageCatalogItemID, 
		ImageCatalogID, 
		ImageID, 
		ImageVersion, 
		CUser, 
		CDate, 
		MUser, 
		MDate)
      VALUES(
		@ImageCatalogItemID, 
		@ImageCatalogID, 
		@ImageID, 
		@ImageVersion, 
		@UserName, 
		@UserDate, 
		@UserName, 
		@UserDate)
END

BEGIN
      INSERT INTO dbo.pImageCatalogItemStatus(
		ImageCatalogID, 
		ImageCatalogStatus, 
		TeamID, 
		ImageCatalogItemID, 
		ImageID)
      SELECT 
		dbo.pImageCatalogTeam.ImageCatalogID, 
		'In Preparation' AS ImageCatalogStatus, 
		dbo.pImageCatalogTeam.TeamID, 
		dbo.pImageCatalogItem.ImageCatalogItemID, 
		dbo.pImageCatalogItem.ImageID
      FROM 
		dbo.pImageCatalogTeam INNER JOIN dbo.pImageCatalogItem 
		ON dbo.pImageCatalogTeam.ImageCatalogID = dbo.pImageCatalogItem.ImageCatalogID
      WHERE 
		dbo.pImageCatalogItem.ImageID = @ImageID AND 
		dbo.pImageCatalogTeam.ImageCatalogID = @ImageCatalogID
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05631', GetDate())
GO
