IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSpecItem_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_SampleRequestSpecItem_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestSpecItem_UPDATE](
	@SampleRequestSpecID UNIQUEIDENTIFIER, 
	@Status INT,
	@WashType NVARCHAR(20),
	@Pom NVARCHAR(10),
	@PomMeasurment NVARCHAR(200),
	@Tol NUMERIC(18,4),
	@TolN NUMERIC(18,4),
	@Var NUMERIC(18,4),   /*** Clay Parker July 6 2009 - Modified 18,4 to 18,2 to correct rounding issues onscreen in sample request **/
	@Ask NUMERIC(18,4),
	@Rev NUMERIC(18,4),
	@Spec NUMERIC(18,4),
	@Final NUMERIC(18,4),
	@ModifiedBy NVARCHAR(200),
	@ModifiedDate DATETIME
)


AS 

	IF @WashType = 'NONWASH'
		BEGIN
			UPDATE dbo.pSampleRequestSpecItem SET 
				POM = @Pom,
				PointMeasur = @PomMeasurment,
				TOLN = @TolN, 
				Ask = @Ask,
				Var = @Var,
				Rev = @Rev,
				Spec = @Spec,
				Final = @Final,
				MUser = @ModifiedBy, 
				MDate = @ModifiedDate
			WHERE (SampleRequestSpecID = @SampleRequestSpecID)  
		END
	ELSE
		BEGIN
			UPDATE dbo.pSampleRequestSpecItem SET 
				POM = @Pom,
				PointMeasur = @PomMeasurment,
				TOL = @Tol, 
				Ask = @Ask,
				Var = @Var,
				Rev = @Rev,
				Spec = @Spec,
				Final = @Final,
				MUser = @ModifiedBy, 
				MDate = @ModifiedDate
			WHERE (SampleRequestSpecID = @SampleRequestSpecID)  
		END
		
	IF @Status = 1 --Resubmit
	BEGIN
		UPDATE pSampleRequestSpecItem SET Rev = Ask
		FROM pSampleRequestSpecItem 
		WHERE (SampleRequestSpecID = @SampleRequestSpecID) AND (Rev = 0)
	END  

	-- Modified by Artemio 
	--  December 5, 2008		
	DECLARE @ApprovedType AS INT 
	SELECT @ApprovedType = ApprovedType FROM pSampleRequestSubmitStatus WITH(NOLOCK) WHERE StatusID = @Status
	IF @ApprovedType IS NULL
		SET @ApprovedType = 0

			

	--IF @Status = 3 OR @Status = 2 --Approved
	IF @ApprovedType = 1 --Approved
		BEGIN		
			UPDATE pSampleRequestSpecItem SET Rev = Ask
			FROM pSampleRequestSpecItem 
			WHERE (SampleRequestSpecID = @SampleRequestSpecID) AND (Rev = 0)
			
			UPDATE pSampleRequestSpecItem SET Final = Rev
			WHERE (SampleRequestSpecID = @SampleRequestSpecID) AND (Final = 0) AND (Rev <> 0)
				
		END  



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01370', GETDATE())
GO