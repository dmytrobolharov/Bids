IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Image_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Image_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Image_INSERT](@ImageID uniqueidentifier, @Version int,
@CUser nvarchar(200), @CDate datetime, @MUser nvarchar(200), @MDate datetime)
AS 

DECLARE @SystemStorageID uniqueidentifier
SET @SystemStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WHERE CurrentServerStorage = 1),'00000000-0000-0000-0000-000000000000')


INSERT INTO pImage (ImageID, CUser, CDate, MUser, MDate, Version, SystemServerStorageID) 
	VALUES (@ImageID, @CUser, @CDate, @MUser, @MDate, @Version, @SystemStorageID)

--INSERT INTO hImage (ImageHistoryID, ImageID, CUser, CDate, MUser, MDate, Version, SystemServerStorageID) 
--	VALUES (@ImageID, @ImageID, @CUser, @CDate, @MUser, @MDate, @Version, @SystemStorageID)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03719', GetDate())
GO