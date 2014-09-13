/****** Object:  StoredProcedure [dbo].[spx_StyleColorwaySeasonalYear_UPDATE]    Script Date: 03/14/2013 15:55:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwaySeasonalYear_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwaySeasonalYear_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleColorwaySeasonalYear_UPDATE]    Script Date: 03/14/2013 15:55:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleColorwaySeasonalYear_UPDATE](
@StyleColorID uniqueidentifier,
@StyleID uniqueidentifier,
@ModifiedBy nvarchar(200),
@ModifiedDate datetime,
@SeasonYearID NVARCHAR(50)= NULL)

AS 

DECLARE @StyleColorStatus  int,
@StyleColorDelivery1 int,
@StyleColorDelivery2 int,
@StyleColorDelivery3 int,
@StyleColorDelivery4 int,
@StyleSeasonYearID UNIQUEIDENTIFIER

SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear
WHERE SeasonYearID = @SeasonYearID AND StyleID = @StyleID


Select @StyleColorStatus = a.StyleColorStatus, @StyleColorDelivery1 = a.StyleColorDelivery1, 
@StyleColorDelivery2 = a.StyleColorDelivery2, @StyleColorDelivery3 = a.StyleColorDelivery3, @StyleColorDelivery4 = a.StyleColorDelivery4 
From pStyleColorway a
Where (a.StyleColorID = @StyleColorID AND a.StyleID = @StyleID)


UPDATE    pStyleColorwaySeasonYear
SET              StyleColorStatus = @StyleColorStatus, StyleColorDelivery1 = @StyleColorDelivery1, 
StyleColorDelivery2 = @StyleColorDelivery2, 
StyleColorDelivery3 = @StyleColorDelivery3,
StyleColorDelivery4 = @StyleColorDelivery4, 
                  MUser = @ModifiedBy, MDate = @ModifiedDate 
WHERE     (StyleColorwayID = @StyleColorID AND StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05297', GetDate())
