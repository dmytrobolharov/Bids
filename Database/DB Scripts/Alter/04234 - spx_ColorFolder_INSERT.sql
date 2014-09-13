
/****** Object:  StoredProcedure [dbo].[spx_ColorFolder_INSERT]    Script Date: 10/18/2012 09:55:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolder_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolder_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorFolder_INSERT]    Script Date: 10/18/2012 09:55:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ColorFolder_INSERT](@ColorFolderID uniqueidentifier, @CUser nvarchar(200), @CDate datetime)
AS 

DECLARE @SystemStorageID uniqueidentifier
SET @SystemStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WHERE CurrentServerStorage = 1),'00000000-0000-0000-0000-000000000000')


INSERT INTO pColorFolder (ColorFolderID, CUser, CDate, MUser, MDate, MChange, SystemServerStorageID) 
	VALUES (@ColorFolderID, @CUser, @CDate, @CUser, @CDate, 1, @SystemStorageID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04234', GetDate())
GO