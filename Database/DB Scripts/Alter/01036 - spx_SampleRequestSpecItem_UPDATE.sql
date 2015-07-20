SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SampleRequestSpecItem_UPDATE') 
DROP PROCEDURE spx_SampleRequestSpecItem_UPDATE
GO

Create  PROCEDURE [dbo].[spx_SampleRequestSpecItem_UPDATE] (
	@SampleRequestSpecID uniqueidentifier, 
	@Status int,
	@WashType nvarchar(20),
	@Pom nvarchar(10),
	@PomMeasurment nvarchar(200),
	@Tol numeric(18,4),
	@TolN numeric(18,4),
	@Var numeric(18,2),   /*** Clay Parker July 6 2009 - Modified 18,4 to 18,2 to correct rounding issues onscreen in sample request **/
	@Ask numeric(18,4),
	@Rev numeric(18,4),
	@Spec numeric(18,4),
	@Final numeric(18,4),
	@ModifiedBy nvarchar(200),
	@ModifiedDate datetime
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
	DECLARE @ApprovedType as INT 
	SELECT @ApprovedType = ApprovedType FROM pSampleRequestSubmitStatus WHERE StatusID = @Status
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
VALUES ('DB_Version', '4.0.0000', '01036', GetDate())
GO
