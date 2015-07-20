
IF EXISTS (select * from sysobjects where id = object_id('spx_StyleColorwaySeasonalYear_UPDATE') and sysstat & 0xf = 4)
	drop procedure spx_StyleColorwaySeasonalYear_UPDATE
GO

CREATE PROCEDURE spx_StyleColorwaySeasonalYear_UPDATE(
@StyleColorID uniqueidentifier,
@StyleID uniqueidentifier,
@ModifiedBy nvarchar(200),
@ModifiedDate datetime,
@StyleSeasonYearID NVARCHAR(50)= NULL)

AS 

DECLARE @StyleColorStatus  int,
@StyleColorDelivery1 int,
@StyleColorDelivery2 int,
@StyleColorDelivery3 int,
@StyleColorDelivery4 int


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
VALUES     ('DB_Version', '2.6.9999', '030', GetDate())
GO

