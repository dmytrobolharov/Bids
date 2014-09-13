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
				
				SET @ChangeTransID = NULL
				
				--** Create TransactionLog
				IF @ChangeManagementEnabled =  1 
				BEGIN 
				
					--** TechPack exists ? 
					IF EXISTS ( SELECT  * FROM dbo.pStyleHeader a
							INNER JOIN dbo.pTechPack b ON a.TechPackId =  b.TechPackID
							WHERE a.StyleID = @StyleID
					)
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
				END 


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
