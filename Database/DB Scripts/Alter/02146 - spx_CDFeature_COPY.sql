
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CDFeature_COPY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CDFeature_COPY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_CDFeature_COPY]
(@Level0ID UNIQUEIDENTIFIER,
@Level1ID UNIQUEIDENTIFIER,
@Level2ID UNIQUEIDENTIFIER,
@Level3ID UNIQUEIDENTIFIER,
@Active INT)
AS
BEGIN

	DECLARE @NewLevel3ID UNIQUEIDENTIFIER
	SET @NewLevel3ID = NEWID()

	INSERT INTO pConLevel3
	(Level3ID, Level3Desc, Detail, ImageID, ImageVersion, AuxField1, AuxField2, AuxField3, AuxField4, AuxField5, Active, MDate, MUser, CUser, CDate)
	SELECT @NewLevel3ID, Level3Desc, Detail, ImageID, ImageVersion, AuxField1, AuxField2, AuxField3, 
	AuxField4, AuxField5, @Active, MDate, MUser, CUser, CDate
	FROM pConLevel3 WITH (NOLOCK)
	WHERE (Level3ID = @Level3ID)

	IF @@Error <> 0 OR @@RowCount <> 1 GOTO Error

	INSERT INTO pConstructTree
	(Level0ID, Level1ID, Level2ID, Level3ID) VALUES (@Level0ID, @Level1ID, @Level2ID, @NewLevel3ID)

	IF @@Error <> 0 GOTO Error

	RETURN
Error:
	ROLLBACK TRANSACTION
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02146'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '02146', GetDate())
	END
GO