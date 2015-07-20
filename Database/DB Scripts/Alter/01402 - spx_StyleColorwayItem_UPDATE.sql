IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayItem_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleColorwayItem_UPDATE]
GO 


CREATE PROCEDURE [dbo].[spx_StyleColorwayItem_UPDATE]  (
	@MaterialColorID uniqueidentifier,
	@StyleMaterialID uniqueidentifier = NULL,
	@StyleColorItemID uniqueidentifier = NULL,	
	@StyleID uniqueidentifier = NULL,
	@StyleSet int = 1,
	@SeasonYearID uniqueidentifier = NULL,
	@AllColor int = 0,
	@MUser nvarchar(200),
	@MDate datetime 
) 
AS 


IF @AllColor = 1 
--It will update all colorways 
BEGIN 

	IF @SeasonYearID IS NULL 
		UPDATE pStyleColorwayItem SET MaterialColorID = @MaterialColorID, MUser = @MUser, MDate = @MDate
		WHERE StyleMaterialID = @StyleMaterialID 
			AND StyleID = @StyleID 
			AND StyleSet = @StyleSet 
	ELSE
	
		UPDATE dbo.pStyleColorwayItem
		SET MaterialColorID = @MaterialColorID, MUser = @MUser, MDate = @MDate
		FROM dbo.pStyleColorwayItem 
			INNER JOIN dbo.pStyleSeasonYear b ON b.StyleID = dbo.pStyleColorwayItem.StyleID	
				AND b.SeasonYearID = @SeasonYearID
			INNER JOIN dbo.pStyleColorwaySeasonYear c ON c.StyleColorwayID  =  dbo.pStyleColorwayItem.StyleColorID 
				AND c.StyleSeasonYearID = b.StyleSeasonYearID
		WHERE  dbo.pStyleColorwayItem.StyleMaterialID = @StyleMaterialID
		AND dbo.pStyleColorwayItem.StyleSet  = @StyleSet

	
END 
ELSE
--It will update individual colorway with selected color chip (@MaterialColorID)
BEGIN 
		UPDATE pStyleColorwayItem SET 
			MaterialColorID = @MaterialColorID,
			MUser = @MUser,
			MDate = @MDate
		WHERE StyleColorItemID = @StyleColorItemID 
END 



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01402', GETDATE())
GO	







