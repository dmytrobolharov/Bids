IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialCore_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialCore_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_MaterialCore_DELETE](
	@MaterialCoreID UNIQUEIDENTIFIER,
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
			--** Get Materials in group, remove them from Multi-Cloth Styles
			--***
			CREATE TABLE #style (
				ROWID INT IDENTITY (1,1),
				StyleID UNIQUEIDENTIFIER 
			)

			INSERT INTO #style ( StyleID )
			SELECT StyleID FROM pStyleHeader WITH (NOLOCK) WHERE MaterialCoreID = @MaterialCoreID

			DECLARE @ROWID INT
			DECLARE @TOTAL INT
			DECLARE @StyleID UNIQUEIDENTIFIER 

			SELECT @TOTAL = COUNT(*) FROM #style
			SET @ROWID = 1 

			WHILE @ROWID <= @TOTAL 
			BEGIN

				SELECT @StyleID = StyleID FROM #style WHERE ROWID = @ROWID 

				CREATE TABLE #sm (
					ROWID INT IDENTITY (1,1),
					StyleMaterialID UNIQUEIDENTIFIER 
				)

				INSERT INTO #sm (StyleMaterialID) 
				SELECT a.StyleMaterialID 
				FROM pStyleMaterials a WITH (NOLOCK) 
					INNER JOIN pMaterialCoreItem b WITH (NOLOCK) ON a.StyleMaterialLinkID = b.MaterialCoreItemID
				WHERE a.StyleID = @StyleID 
				AND a.MultiCloth  = 1 
				AND b.MaterialCoreID = @MaterialCoreID 


				DECLARE 
					@StyleMaterialID UNIQUEIDENTIFIER,
					@ROWID_SM INT,
					@TOTAL_SM INT,
					@ChangeTransID UNIQUEIDENTIFIER

				SELECT @TOTAL_SM =  COUNT(*) FROM #sm
				SET @ROWID_SM = 1 

				WHILE  @ROWID_SM <= @TOTAL_SM 
				BEGIN
					SELECT @StyleMaterialID = StyleMaterialID FROM #sm WHERE ROWID = @ROWID_SM 

					--** Create TransactionLog
					IF @ChangeManagementEnabled = 1
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

				SET @ROWID = @ROWID + 1 
			END 


			--***
			--** Remove MaterialCore records 
			--***		
			DELETE FROM pMaterialCoreColorItem WHERE MaterialCoreID = @MaterialCoreID
			DELETE FROM pMaterialCoreItem WHERE MaterialCoreID = @MaterialCoreID
			DELETE FROM pMaterialCoreColor WHERE MaterialCoreID = @MaterialCoreID
			DELETE FROM pMaterialCore WHERE MaterialCoreID = @MaterialCoreID
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
VALUES     ('DB_Version', '4.0.0000', '727', GetDate())
GO
