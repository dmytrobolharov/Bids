IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleComponentDimensionLogic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleComponentDimensionLogic_UPDATE]
GO



CREATE PROCEDURE dbo.spx_StyleComponentDimensionLogic_UPDATE(
	@StyleMaterialID UNIQUEIDENTIFIER,
	@SQLUpdate NVARCHAR(MAX),
	@TeamID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS

DECLARE
	@MaterialImageID UNIQUEIDENTIFIER, 
	@MaterialImageVersion INT, 
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialNo NVARCHAR(200), 
	@MaterialName  NVARCHAR(200),
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@MaterialSize NVARCHAR(200),
	@MainMaterialID UNIQUEIDENTIFIER
	
DECLARE 
	@oLicense INT, 
	@oArtwork INT, 
	@oColorway INT, 
	@oMaterialDimension INT, 
	@oPlacement NVARCHAR(4000), 
	@oMainMaterial INT

	
DECLARE 
	@nLicense INT, 
	@nArtwork INT, 
	@nColorway INT, 
	@nMaterialDimension INT, 
	@nPlacement NVARCHAR(4000), 
	@nMainMaterial INT
	


-- Old values
SELECT @oLicense = a.License, @oArtwork = a.Artwork, @oColorway = a.Colorway, @oMaterialDimension = a.MaterialDimension, 
	@oPlacement = a.Placement, @oMainMaterial = a.MainMaterial,
	@MaterialImageID = MaterialImageID, @MaterialImageVersion = MaterialImageVersion, @MaterialID = MaterialID, 
	@MaterialNo = MaterialNo, @MaterialName = MaterialName, @StyleID = StyleID, @StyleSet = StyleSet, @MaterialSize = MaterialSize
FROM dbo.pStyleMaterials a
WHERE StyleMaterialID = @StyleMaterialID

SELECT @MainMaterialID = StyleMaterialID FROM dbo.pStyleMaterials WHERE @StyleID =  @StyleID AND MainMaterial = 1 


EXEC SP_EXECUTESQL @SQLUpdate

-- New values
SELECT @nLicense = a.License, @nArtwork = a.Artwork, @nColorway = a.Colorway, @nMaterialDimension = a.MaterialDimension, 
	@nPlacement = a.Placement, @nMainMaterial = a.MainMaterial 
FROM dbo.pStyleMaterials a
WHERE StyleMaterialID = @StyleMaterialID


IF @nMainMaterial = 1 AND @StyleSet = 1 
BEGIN
	UPDATE  dbo.pStyleHeader SET 
		StyleMaterialID = @StyleMaterialID, 
		MaterialImageID = @MaterialImageID, 
		MaterialImageVersion = @MaterialImageVersion, 
		MaterialID = @MaterialID, 
		MaterialNo = @MaterialNo, 
		MaterialName = @MaterialName  
	WHERE StyleID = @StyleID
END

exec spx_StyleMaterialVariation_UPDATE  @StyleMaterialId 	
exec spx_StyleMaterialGlobal_UPDATE @StyleMaterialId, @StyleId, @StyleSet


--*** Log changes 

DECLARE 
	@NewChangeID UNIQUEIDENTIFIER,
	@MaterialChanged NVARCHAR(1000),
	@StyleChangeDescription  NVARCHAR(1000)

SET @MaterialChanged  = @MaterialNo
IF @MaterialName IS NOT NULL 
	SET @MaterialChanged  = @MaterialChanged  + '- ' + @MaterialName
IF @MaterialSize IS NOT NULL
	SET @MaterialChanged  = @MaterialChanged  + ' ('  + @MaterialSize + ')'


--** License
IF @oLicense = 1 AND @nLicense = 0
BEGIN
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Removed from Licensee'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000009',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Delete', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 

IF @oLicense = 0 AND @nLicense = 1
BEGIN
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Added from Licensee'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000009',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Update', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 


--** Artwork
IF @oArtwork = 1 AND @nArtwork = 0
BEGIN
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Removed from Size\Treadment'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000010',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Delete', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 
IF @oArtwork = 0 AND @nArtwork = 1
BEGIN
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Added to Size\Treadment'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000010',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Update', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 


--** Colorway
IF @oColorway = 1 AND @nColorway = 0
BEGIN
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Removed from colorway'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000004',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Delete', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 
IF @oColorway = 0 AND @nColorway = 1
BEGIN
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Added to colorway'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000004',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Update', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 


IF @oPlacement <> @nPlacement
BEGIN 
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' - Placement changed FROM: '  + @oPlacement + ' To: ' + @nPlacement
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000004',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Update', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 


IF EXISTS ( SELECT * FROM pStyleHeader a WITH(NOLOCK) INNER JOIN dbo.pTechPack b WITH(NOLOCK) ON a.TechPackId = b.TechPackID )
BEGIN 

	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Update'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000014',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Update', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate


	IF @StyleSet = 1
	BEGIN 
	
		IF @nMainMaterial = 1
		BEGIN 
		
			IF  @MainMaterialID IS NULL OR  
				( @MainMaterialID IS NOT NULL  AND @MainMaterialID <> @StyleMaterialID)
			BEGIN
				-- New mainmaterial
				
				SET @NewChangeID = NEWID() 
				SET @StyleChangeDescription =  'Main Material ' + @MaterialChanged + ' added to Style'
						
				EXEC spx_StyleChange_INSERT 
					@ActiveID = '00000000-0000-0000-0000-000000000000',
					@ChangeID = @NewChangeID,
					@WorkflowID = '40000000-0000-0000-0000-000000000014',
					@StyleID = @StyleID,
					@StyleSet = @StyleSet,
					@StyleStatus = 0 ,
					@StyleChangeNotifyTo = '',
					@StyleChangeType = 'Update', 
					@StyleChangeDescription = @StyleChangeDescription,
					@ChangeBy = @MUser, 
					@ChangeDate = @MDate		
			END
			
			IF @MainMaterialID IS NOT NULL  AND @MainMaterialID <> @StyleMaterialID
			BEGIN 
			
				SET @NewChangeID = NEWID() 
				SET @StyleChangeDescription =  'Main Material ' + @MaterialChanged + ' removed from Style'
						
				EXEC spx_StyleChange_INSERT 
					@ActiveID = '00000000-0000-0000-0000-000000000000',
					@ChangeID = @NewChangeID,
					@WorkflowID = '40000000-0000-0000-0000-000000000014',
					@StyleID = @StyleID,
					@StyleSet = @StyleSet,
					@StyleStatus = 0 ,
					@StyleChangeNotifyTo = '',
					@StyleChangeType = 'Update', 
					@StyleChangeDescription = @StyleChangeDescription,
					@ChangeBy = @MUser, 
					@ChangeDate = @MDate			
			
			END 
		END 
		ELSE IF  @nMainMaterial = 0 AND @MainMaterialID = @StyleMaterialID
		BEGIN 
		
			SET @NewChangeID = NEWID() 
			SET @StyleChangeDescription =  'Main Material ' + @MaterialChanged + ' Removed from Style'
		
			EXEC spx_StyleChange_INSERT 
				@ActiveID = '00000000-0000-0000-0000-000000000000',
				@ChangeID = @NewChangeID,
				@WorkflowID = '40000000-0000-0000-0000-000000000014',
				@StyleID = @StyleID,
				@StyleSet = @StyleSet,
				@StyleStatus = 0 ,
				@StyleChangeNotifyTo = '',
				@StyleChangeType = 'Delete', 
				@StyleChangeDescription = @StyleChangeDescription,
				@ChangeBy = @MUser, 
				@ChangeDate = @MDate		
		
		END 
	
	END 

		
END 





GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01392', GETDATE())
GO