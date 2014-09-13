SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spx_CDFeature_COPY]
(@Level1ID UNIQUEIDENTIFIER,
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
	(Level1ID, Level2ID, Level3ID) VALUES (@Level1ID, @Level2ID, @NewLevel3ID)

	IF @@Error <> 0 GOTO Error

	RETURN
Error:
	ROLLBACK TRANSACTION
END

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '614', GetDate())
GO