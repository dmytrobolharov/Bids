/****** Object:  StoredProcedure [dbo].[spx_Image_DELETE]    Script Date: 08/22/2014 16:03:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Image_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Image_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_Image_DELETE]    Script Date: 08/22/2014 16:03:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Image_DELETE]

(@ImageHistoryID uniqueidentifier)

AS 

DECLARE @ImageID uniqueidentifier
DECLARE @ImageVersion as nvarchar(10)
DECLARE @ImageCount as int
DECLARE @ImageSelected as INT

SELECT @ImageID = ImageID, @ImageVersion = Version FROM dbo.hImage WITH (NOLOCK)
WHERE ImageHistoryID = @ImageHistoryID  
ORDER BY Version DESC

--Check if it's latest version of the image database
BEGIN
	if (SELECT COUNT(*) FROM pImage WITH (NOLOCK) WHERE ImageID = @ImageID AND Version = @ImageVersion) = 0 
		set @ImageSelected = 0
	else
		SET @ImageSelected = 1
END	

--Delete Image History
BEGIN
DELETE hImage WHERE ImageHistoryID = @ImageHistoryID
	IF @ImageSelected = 1 
		DECLARE @TmpImageID uniqueidentifier
		DECLARE @TmpImageVersion as int
		SELECT @TmpImageVersion = Version FROM hImage WITH (NOLOCK) WHERE ImageID = @ImageID ORDER BY Version ASC
		UPDATE pImage SET Version = @TmpImageVersion WHERE ImageID = @ImageID 
END

--Delete Main Image Folder if Image History is empty
IF NOT EXISTS(SELECT * FROM hImage WITH (NOLOCK) WHERE ImageID = @ImageID)
BEGIN

	-- Breaking the connections between all the calendars
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER
	
	DECLARE CalendarsCursor CURSOR SCROLL FOR
	SELECT TACalTemplateID FROM pTACalReference 
	WHERE ReferenceId = @ImageID AND TACalReferenceTypeId = 6
	
	OPEN CalendarsCursor
	FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC spx_TACalReference_DELETE @TACalTemplateID, @ImageID
		FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	END
	CLOSE CalendarsCursor
	DEALLOCATE CalendarsCursor
	
	-- Deleting image
	DELETE pImage WHERE ImageID = @ImageID
END

BEGIN
	SELECT @ImageID = ImageID, @ImageVersion = Version
	FROM dbo.pImage WITH (NOLOCK)
	WHERE  ImageID = @ImageID
END

SELECT @ImageCount = COUNT(*) FROM dbo.hImage WITH (NOLOCK)
WHERE  ImageID = @ImageID

SELECT @ImageCount AS ImageCount

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08967', GetDate())
GO
