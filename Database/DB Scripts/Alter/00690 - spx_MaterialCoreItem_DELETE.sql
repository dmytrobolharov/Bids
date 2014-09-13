IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterial_ChangeLogLogic_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMaterial_ChangeLogLogic_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_StyleMaterial_ChangeLogLogic_DELETE](
	@ChangeTransID UNIQUEIDENTIFIER
)
AS

--** If transaction record doesnt exist, return
IF @ChangeTransID IS NULL OR CAST(@ChangeTransID AS NVARCHAR(40)) = '00000000-0000-0000-0000-000000000000'
	RETURN

IF NOT EXISTS ( SELECT  * FROM dbo.pChangeTransaction  WITH (NOLOCK) WHERE ChangeTransID = @ChangeTransID )
	RETURN


DECLARE 
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@RowCounter INT,
	@TotalCount INT


--***
--** Beacuse materials can be delete from multiple (linked) styles, need to rearrange the ChangeTransactionID
--** using ChangeAfterValue column to store StyleID 
--***
DECLARE 
	@NewChangeTransID  UNIQUEIDENTIFIER,
	@ChangeTransPageName NVARCHAR(200),
	@ChangeTransTableID UNIQUEIDENTIFIER,
	@ChangeTransTablePKID UNIQUEIDENTIFIER,
	@ChangeTransDate DATETIME

CREATE TABLE #tmpStyle( 
	RowID INT IDENTITY (1,1),
	StyleID UNIQUEIDENTIFIER,
	ChangeTransID UNIQUEIDENTIFIER DEFAULT NEWID()
)

INSERT INTO #tmpStyle ( StyleID )
SELECT DISTINCT ChangeAftervalue 
FROM pChangeLogItem a WITH (NOLOCK)
	INNER JOIN pChangeLog b WITH (NOLOCK) ON a.ChangeLogID = b.ChangeLogID
WHERE a.ChangeTransID = @ChangeTransID
AND b.ChangeTableID = '036F8B4C-C1CC-DF11-AF06-005056C00008' -- pStyleMaterials


SELECT @ChangeTransPageName =  ChangeTransPageName, 
	@ChangeTransTableID = ChangeTransTableID,
	@ChangeTransTablePKID = ChangeTransTablePKID,
	@ChangeTransUserID  = ChangeTransUserID,
	@ChangeTransDate  = ChangeTransDate 
FROM dbo.pChangeTransaction 
WHERE ChangeTransID = @ChangeTransID	


SET @RowCounter = 1
SELECT @TotalCount = COUNT(*) FROM #tmpStyle

WHILE @RowCounter <= @TotalCount 
BEGIN
	SELECT @StyleID = StyleID , @NewChangeTransID = ChangeTransID 
	FROM #tmpStyle WHERE RowID = @RowCounter 

	INSERT INTO dbo.pChangeTransaction 
	        ( ChangeTransID ,
	          ChangeTransPageName ,
	          ChangeTransTableID ,
	          ChangeTransTablePKID ,
	          ChangeTransUserID ,
	          ChangeTransDate,
	          ChangeTransTypeID
	        )
	VALUES  ( @NewChangeTransID,
		      @ChangeTransPageName ,
	          @ChangeTransTableID ,
	          @StyleID,
	          @ChangeTransUserID ,
	          @ChangeTransDate,
	          2 --DELETE
			)

	-- UPDATE Log with new Transaction ID		
	UPDATE pChangeLogItem
	SET ChangeTransID = @NewChangeTransID,
		ChangeAfterValue = NULL
	WHERE ChangeTransID = @ChangeTransID 
	AND ChangeAfterValue = CAST( @StyleID AS NVARCHAR(40))

	UPDATE dbo.pChangeLog
	SET ChangeTransID = @NewChangeTransID
	FROM pChangeLog WITH (NOLOCK)
		INNER JOIN pChangeLogItem WITH (NOLOCK) ON pChangeLog.ChangeLogID = pChangeLogItem.ChangeLogID
	WHERE pChangeLogItem.ChangeTransID = @NewChangeTransID

	SET @RowCounter = @RowCounter  + 1 

END

--Delete previous Transaction ID
DELETE FROM pChangeTransaction WHERE ChangeTransID = @ChangeTransID

GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialCoreItem_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialCoreItem_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_MaterialCoreItem_DELETE](
	@MaterialCoreItemID UNIQUEIDENTIFIER,
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@ChangeTransPageName NVARCHAR(200),
	@MUser NVARCHAR(200),
	@MDate DATETIME,
	@ChangeManagementEnabled INT = 0
)
AS 

BEGIN

	BEGIN TRY --Start the Try Block..
		BEGIN TRANSACTION -- Start the transaction..

			--***
			--** Delete StyleMaterials 
			--***
			CREATE TABLE #sm (
				ROWID INT IDENTITY (1,1),
				StyleMaterialID UNIQUEIDENTIFIER,
				StyleID UNIQUEIDENTIFIER
			)

			INSERT INTO #sm (StyleMaterialID, StyleID) 
			SELECT StyleMaterialID, StyleID 
			FROM pStyleMaterials WITH(NOLOCK) WHERE StyleMaterialLinkID = @MaterialCoreItemID 

			DECLARE 
				@StyleMaterialID UNIQUEIDENTIFIER, 
				@StyleID UNIQUEIDENTIFIER, 
				@ROWID_SM INT,
				@TOTAL_SM INT

			SELECT @TOTAL_SM =  COUNT(*) FROM #sm
			SET @ROWID_SM = 1 

			DECLARE @ChangeTransID UNIQUEIDENTIFIER

			WHILE  @ROWID_SM <= @TOTAL_SM 
			BEGIN

				SELECT @StyleMaterialID = StyleMaterialID, @StyleID = StyleID
				FROM #sm WHERE ROWID = @ROWID_SM 

				--** Create TransactionLog
				IF @ChangeManagementEnabled =  1 
				BEGIN 
					SET @ChangeTransID = NEWID() 				
					INSERT INTO pChangeTransaction (
							ChangeTransID,
							ChangeTransPageName,
							ChangeTransTableID,
							ChangeTransTablePKID,
							ChangeTransUserID,
							ChangeTransDate,
							ChangeTransTypeID)
					VALUES(
							@ChangeTransID,
							@ChangeTransPageName,
							'036F8B4C-C1CC-DF11-AF06-005056C00008', -- pStyleHeader
							@StyleID,
							@ChangeTransUserID,
							@MDate,
							2 )-- Delete
				END 
				ELSE 
					SET @ChangeTransID = NULL


				EXEC spx_StyleMaterial_DELETE 
					@StyleMaterialID = @StyleMaterialID,
					@ChangeTransID = @ChangeTransID,
					@ChangeTransUserID = @ChangeTransUserID,
					@MUser = @MUser,
					@MDate = @MDate

				EXEC spx_StyleMaterial_ChangeLogLogic_DELETE @ChangeTransID

				SET @ROWID_SM = @ROWID_SM + 1 
			END 

			DROP TABLE #sm

			--***
			--** Delete MaterialCoreItem record 
			--***
			DELETE FROM pMaterialCoreColorItem WHERE MaterialCoreItemID = @MaterialCoreItemID
			DELETE FROM pMaterialCoreItem WHERE MaterialCoreItemID = @MaterialCoreItemID
		COMMIT TRAN -- Transaction Success!
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
		ROLLBACK TRAN --RollBack in case of Error
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE();
        SELECT @ErrorSeverity = ERROR_SEVERITY();
        SELECT @ErrorState = ERROR_STATE();

        RAISERROR (
				   @ErrorMessage, -- Message text.
                   @ErrorSeverity, -- Severity.
                   @ErrorState -- State.
                   );

	END CATCH

END




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '690', GetDate())
GO
