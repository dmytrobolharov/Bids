
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ConstructionDetail_Relink]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ConstructionDetail_Relink]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ConstructionDetail_Relink]
(@ConstructionDetailID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME )
AS

DECLARE @sLevel0ID as varchar(50)
DECLARE @sLevel1ID as varchar(50)
DECLARE @sLevel2ID as varchar(50)
DECLARE @sLevel3ID as varchar(50)
DECLARE @ImageID as varchar(50)
DECLARE @nCount as int

BEGIN
	SELECT @sLevel0ID = Level0ID, @sLevel1ID = Level1ID, @sLevel2ID = Level2ID, @sLevel3ID = Level3ID FROM pConPageDetail WITH (NOLOCK) WHERE ConstructionDetailID = @ConstructionDetailID
	SELECT @nCount = count(*) FROM vwx_Control_CDFeature_SELECT WITH (NOLOCK) WHERE Level0ID = @sLevel0ID AND Level1ID = @sLevel1ID  AND  Level2ID = @sLevel2ID  AND  Level3ID = @sLevel3ID
	IF  (@nCount <> 0)
	BEGIN
		SELECT @ImageID = ImageID FROM vwx_Control_CDFeature_SELECT WITH (NOLOCK) WHERE Level0ID = @sLevel0ID AND Level1ID = @sLevel1ID  AND  Level2ID = @sLevel2ID  AND  Level3ID = @sLevel3ID
		Update pConPageDetail SET Linked = 1, ImageID = @ImageID, MUser = @MUser, MDate = @MDate Where ConstructionDetailID = @ConstructionDetailID
	END

	IF @@Error <> 0 GOTO Error

	RETURN
Error:
	ROLLBACK TRANSACTION
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02143'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '02143', GetDate())
	END
GO