IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayItem_Linked_AllRM_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleColorwayItem_Linked_AllRM_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_StyleColorwayItem_Linked_AllRM_UPDATE](
	@MaterialColorID uniqueidentifier,
	@StyleMaterialID uniqueidentifier = NULL,
	@StyleColorItemID uniqueidentifier = NULL,	
	@StyleID uniqueidentifier = NULL,
	@StyleSet int = 1,
	@SeasonYearID uniqueidentifier = NULL,
	@AllColor int = 0,
	@MUser nvarchar(200),
	@MDate datetime, 
	@AllSize INT = 0,
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@ChangeTransPageName NVARCHAR(200),
	@ChangeManagementEnabled INT,
	@NoApplicableColor INT = 0
) 
AS


	DECLARE 
		@tmpStylematerialID UNIQUEIDENTIFIER,
		@tmpStyleColorItemID UNIQUEIDENTIFIER,
		@MaterialID UNIQUEIDENTIFIER,
		@StyleColorID UNIQUEIDENTIFIER,
		@ROWID INT,
		@TOTAL INT
		
		
	SELECT @MaterialID = MaterialID FROM pStyleMaterials WITH(NOLOCK) WHERE StyleMaterialID = @StyleMaterialID 
	SELECT @StyleColorID = StyleColorID FROM dbo.pStyleColorwayItem WHERE StyleColorItemID = @StyleColorItemID

	
	CREATE TABLE #sm (
		ROWID INT IDENTITY (1,1),
		StyleMaterialID UNIQUEIDENTIFIER,
		StyleColorItemID UNIQUEIDENTIFIER
	)
	
	
	INSERT INTO #sm (StylematerialID, StyleColorItemID)
	SELECT a.StylematerialID, b.StyleColorItemID  
	FROM dbo.pStyleMaterials a WITH(NOLOCK)
		INNER JOIN dbo.pStyleColorwayItem b WITH(NOLOCK) ON  a.StyleMaterialID = b.StyleMaterialID 
				AND b.StyleColorID = @StyleColorID
	WHERE a.StyleID =@StyleID AND a.StyleSet = @StyleSet AND a.MaterialID =@MaterialID
	
	SET @ROWID = 1 
	SELECT @TOTAL = COUNT(*) FROM #sm
	
	WHILE @ROWID <= @TOTAL 
	BEGIN
	
		SELECT @tmpStylematerialID = StyleMaterialID, @tmpStyleColorItemID = StyleColorItemID
		FROM #sm WHERE ROWID = @ROWID
	
		EXEC spx_StyleColorwayItem_Linked_UPDATE
			@MaterialColorID = @MaterialColorID, 
			@StyleMaterialID = @tmpStylematerialID,
			@StyleColorItemID = @tmpStyleColorItemID,
			@StyleID = @StyleID,
			@StyleSet = @StyleSet,
			@SeasonYearID = @SeasonYearID,
			@AllColor = @AllColor,
			@MUser = @MUser,
			@MDate = @MDate,
			@AllSize = @AllSize,
			@ChangeTransUserID = @ChangeTransUserID, 
			@ChangeTransPageName = @ChangeTransPageName,
			@ChangeManagementEnabled = @ChangeManagementEnabled,
			@NoApplicableColor = @NoApplicableColor


		SET @ROWID = @ROWID + 1
	END 
	


GO