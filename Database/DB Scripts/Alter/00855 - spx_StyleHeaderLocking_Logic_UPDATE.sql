IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHeaderLocking_Logic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleHeaderLocking_Logic_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_StyleHeaderLocking_Logic_UPDATE] (
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@TeamID	UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS 

	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 
	
	SELECT @StyleSeasonYearID = StyleSeasonYearID
	FROM dbo.pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID

	UPDATE pStyleHeader 
	SET HeaderLocked = 0 , MUser = @MUser , MDate = @MDate 
	WHERE StyleID = @StyleID
	

	--Production Status = SENT TO SAP needs to change to APPROVED when clicking unlock.	
	UPDATE pStyleColorwaySeasonYear SET StyleColorStatus = 200 
	WHERE StyleColorStatus = 300 AND StyleSeasonYearID = @StyleSeasonYearID
	
		
	--Production Status = Dropped –needs to stay Dropped when clicking unlock
	--** Need to change status to "Not Sampled"
	--UPDATE pStyleColorwaySeasonYear SET StyleColorStatus = 100 WHERE StyleColorStatus = 0 AND StyleID =@StyleID
	
	--Production Status  = In Progress – needs to stay In Progress when clicking unlock
	-- NO CHANGE
	
	--Sample Status = SENT TO SAP needs to change to Sampled when clicking unlock
	UPDATE pStyleColorwaySeasonYear SET SampleStatus = 200
	WHERE SampleStatus = 300 AND StyleSeasonYearID = @StyleSeasonYearID
	
	--Sample Status = Dropped – Needs to stay Dropped when clicking unlock
	--** Need to change status to "Not Sampled"
	--UPDATE pStyleColorwaySeasonYear SET SampleStatus = 100 WHERE SampleStatus = 0 AND StyleID =@StyleID
	
	
	--Sample status = Sampled –Needs to stay Sampled when clicking unlock

	
	update  pStyleColorwaySeasonYear set Locked = 0 
	WHERE StyleSeasonYearID = @StyleSeasonYearID



GO