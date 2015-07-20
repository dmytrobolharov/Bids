IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSpec_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleSpec_UPDATE]
GO



CREATE PROCEDURE [dbo].[spx_StyleSpec_UPDATE]
(
@SpecID				uniqueidentifier,
@POM				nvarchar(10),
@PointMeasure		nvarchar(225),
@TOL				numeric(18,4),
@TOLN				numeric(18,4),
@Spec				numeric(18,4),
@Proto0				numeric(18,4),
@Proto1				numeric(18,4),
@Proto2				numeric(18,4),
@Proto3				numeric(18,4),
@Proto4				numeric(18,4),
@Proto5				numeric(18,4),
@Proto6				numeric(18,4),
@Proto7				numeric(18,4),
@Proto8				numeric(18,4),
@Proto9				numeric(18,4),
@Proto10			numeric(18,4),
@Proto11			numeric(18,4),
@Proto12			numeric(18,4),
@Proto13			numeric(18,4),
@Proto14			numeric(18,4),
@Proto15			numeric(18,4),
@Proto16			numeric(18,4),
@Proto17			numeric(18,4),
@Proto18			numeric(18,4),
@Proto19			numeric(18,4),
@ModifiedBy			nvarchar(200),
@ModifiedDate		datetime
)

AS 

--IF @Spec <> 0.000

	BEGIN

		DECLARE 
		@origStyleID			nvarchar(50),
		@origStyleSet			nvarchar(50),
		@origWashType			nvarchar(200),
		@origPOM				nvarchar(10), 
		@origPointMeasure		nvarchar(225), 
		@origTOL				numeric(18,4),
		@origTOLN				numeric(18,4),
		@origSpec				numeric(18,4), 
		@intPOM					nvarchar(50), 
		@intPointMeasure		int, 
		@intTOL					int,
		@intTOLN				int,
		@intSpec				int,
		@intChange				int 


		SELECT @origStyleID = StyleID, @origStyleSet = StyleSet, @origPOM = POM, 
		@origPointMeasure = PointMeasur, @origTOL = ISNULL(TOL,0), @origTOLN = ISNULL(TOLN,0), 
		@origSpec = Spec FROM dbo.pStyleSpec WHERE SpecID = @SpecID
		
		SELECT @origWashType = WashType FROM pStyleHeader WHERE StyleID = @origStyleID

		DECLARE @DataChanged int
		SET @DataChanged = 0

			IF @origPOM <> @POM 
			BEGIN
				SET @DataChanged = 1
			END
			IF @origPointMeasure <> @PointMeasure 
			BEGIN
				SET @DataChanged = 1
			END
			IF @origSpec <> @Spec 
			BEGIN
				SET @DataChanged = 1
			END	

	    --SELECT @origWashType
		IF @origWashType = 'WASH' OR @origWashType IS NULL OR @origWashType  = ''
			BEGIN
			IF @origTOL <> @TOL
				SET @DataChanged = 1
			END		
		ELSE
			BEGIN
			IF @origTOLN <> @TOLN 
				SET @DataChanged = 1
			END
		END

		--SELECT @DataChanged AS DC
		IF @DataChanged = 1
		BEGIN

			BEGIN
			IF @POM = @origPOM 
				SET @intPOM = 0
			ELSE
				SET @intPOM = 1	
			END

			BEGIN
			IF @PointMeasure = @origPointMeasure
				SET @intPointMeasure = 0
			ELSE
				SET @intPointMeasure = 1	
			END

			BEGIN
			IF @TOL = @origTOL
				SET @intTOL = 0
			ELSE
				SET @intTOL = 1	
			END

			BEGIN
			IF @TOLN = @origTOLN
				SET @intTOLN = 0
			ELSE
				SET @intTOLN = 1	
			END

			BEGIN
			IF @Spec = @origSpec
				SET @intSpec = 0
			ELSE
				SET @intSpec = 1	
			END

			BEGIN
			IF @origWashType = 'WASH' OR @origWashType = NULL
				BEGIN
					BEGIN
					IF @TOL = @origTOL
						SET @intTOL = 0
					ELSE
						SET @intTOL = 1
					END
					SET @intChange = (@intPOM + @intPointMeasure + @intTOLN + @intTOL + @intSpec)
				END	
			ELSE
				BEGIN
					BEGIN
					IF @TOLN = @origTOLN
						SET @intTOLN = 0
					ELSE
						SET @intTOLN = 1
					END	
					SET @intChange = (@intPOM + @intPointMeasure + @intTOL + @intTOLN + @intSpec)
				END
			END
			
			
			--IF (SELECT COUNT(*) AS CountPOM FROM dbo.pStyleSpec WHERE SpecID = @SpecID AND POM = @POM AND PointMeasur = @PointMeasure AND Spec = @Spec) = 0

				BEGIN
				
				PRINT 'Updated'

				CREATE TABLE [#tempStyleDevelopmentItem] ( 
				[RecID]						int IDENTITY(1,1)  NOT NULL,
				[StyleDevelopmentItemID]	uniqueidentifier NULL,
				[StyleDevelopmentID]    	uniqueidentifier NULL,
				[StyleID]               	uniqueidentifier NULL,
				[SizeRange]             	nvarchar(50) NULL,
				[Variation]             	int NULL,
				[CUser]                 	nvarchar(200) NULL,
				[CDate]                 	datetime NULL,
				[MUser]                 	nvarchar(200) NULL,
				[MDate]                 	datetime NULL,
				)

				--IF  @intChange <> 0	
				
				DECLARE @RowStyleLoop 			int
				DECLARE @RowStyleCount 			int
				DECLARE @tmpStyleID				uniqueidentifier
				DECLARE @SpecMasterID			uniqueidentifier
				DECLARE @tmpStyleVariation		int


				DECLARE @StyleDevelopmentId uniqueidentifier
				SELECT @tmpStyleVariation = Variation, @StyleDevelopmentId = StyleDevelopmentId FROM pStyleDevelopmentItem WHERE StyleId = @origStyleId

				BEGIN
					INSERT INTO #tempStyleDevelopmentItem
						(StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation)
					SELECT StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation 
						FROM pStyleDevelopmentItem 
					WHERE StyleDevelopmentID = @StyleDevelopmentId AND Variation = @tmpStyleVariation
				END

				SET @RowStyleLoop = 1
				SET @RowStyleCount = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)
				
				BEGIN
					SET @SpecMasterID = newid()
				END

				WHILE @RowStyleLoop <= @RowStyleCount 

					BEGIN

						SELECT @tmpStyleID = StyleID FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop

								BEGIN
								
								IF @origStyleID = @tmpStyleID
									 IF @origWashType = 'WASH' OR @origWashType IS NULL OR @origWashType  = ''
										BEGIN
											UPDATE pStyleSpec
											SET SpecMasterID = @SpecMasterID, POM = @POM, PointMeasur = @PointMeasure,TOL = @TOL, Spec = @Spec, InitialSpec = @Spec, Proto0 = @Proto0, Proto1 = @Proto1, Proto2 = @Proto2, 
											Proto3 = @Proto3, Proto4 = @Proto4, Proto5 = @Proto5, Proto6 = @Proto6, Proto7 = @Proto7, Proto8 = @Proto8, Proto9 = @Proto9, Proto10 = @Proto10, Proto11 = @Proto11,
											Proto12 = @Proto12, Proto13 = @Proto13, Proto14 = @Proto14, Proto15 = @Proto15, Proto16 = @Proto16, Proto17 = @Proto17, Proto18 = @Proto18, Proto19 = @Proto19, 
											MUser = @ModifiedBy, MDate = @ModifiedDate
											WHERE StyleID = @tmpStyleID AND StyleSet = @origStyleSet AND POM = @origPOM	
										END
									ELSE
										BEGIN
											
											UPDATE pStyleSpec
											SET SpecMasterID = @SpecMasterID, POM = @POM, PointMeasur = @PointMeasure, TOLN = @TOLN, Spec = @Spec, InitialSpec = @Spec, Proto0 = @Proto0, Proto1 = @Proto1, Proto2 = @Proto2, 
											Proto3 = @Proto3, Proto4 = @Proto4, Proto5 = @Proto5, Proto6 = @Proto6, Proto7 = @Proto7, Proto8 = @Proto8, Proto9 = @Proto9, Proto10 = @Proto10, Proto11 = @Proto11,
											Proto12 = @Proto12, Proto13 = @Proto13, Proto14 = @Proto14, Proto15 = @Proto15, Proto16 = @Proto16, Proto17 = @Proto17, Proto18 = @Proto18, Proto19 = @Proto19, 
											MUser = @ModifiedBy, MDate = @ModifiedDate
											WHERE StyleID = @tmpStyleID AND StyleSet = @origStyleSet AND POM = @origPOM
										END	
								ELSE
										BEGIN
											UPDATE pStyleSpec
											SET SpecMasterID = @SpecMasterID, POM = @POM, PointMeasur = @PointMeasure, MUser = @ModifiedBy, MDate = @ModifiedDate
											WHERE StyleID = @tmpStyleID AND StyleSet = @origStyleSet AND POM = @origPOM	
										END
								END
								
								BEGIN
									UPDATE pSampleRequestSpecItem
									SET POM = @POM, PointMeasur = @PointMeasure, TOL = @TOL, TOLN = @TOLN, MUser = @ModifiedBy, MDate = @ModifiedDate
									WHERE StyleID = @tmpStyleID AND StyleSet = @origStyleSet AND POM = @origPOM	
								END
						
								
								PRINT 'SELECT UPDATE'

						SET @RowStyleLoop = @RowStyleLoop + 1
						
					END					

			END
					
		END			
		
		IF @intChange <> 0
		BEGIN
			SELECT 'FROM (' + @origPOM + ')' + @origPointMeasure + ':' + CONVERT(nvarchar(50), @origSpec) + '" TO (' + POM + ')' + PointMeasur + ':' + CONVERT(nvarchar(50),Spec)  AS Message  FROM dbo.pStyleSpec WHERE (SpecID = @SpecID) 
		END	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01457', GetDate())
GO