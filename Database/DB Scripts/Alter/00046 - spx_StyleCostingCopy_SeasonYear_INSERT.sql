IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingCopy_SeasonYear_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingCopy_SeasonYear_INSERT]
GO


CREATE  PROCEDURE [dbo].[spx_StyleCostingCopy_SeasonYear_INSERT](
@StyleID UNIQUEIDENTIFIER,
@NewStyleID UNIQUEIDENTIFIER,
@SeasonYearID UNIQUEIDENTIFIER,
@CreatedBy NVARCHAR(200),
@CreatedDate DATETIME
)
AS 

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 
DECLARE @NewStyleSeasonYearID UNIQUEIDENTIFIER 

SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID 
SELECT @NewStyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @NewStyleID AND SeasonYearID = @SeasonYearID 


INSERT INTO dbo.pStyleCostingHeader
                      (StyleID, StyleCostingTypeID, StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, StyleCostingCustomField1, StyleCostingCustomField2, 
                      StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, StyleCostingCustomField7, 
                      StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, 
                      StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, 
                      StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, StyleCostingCustomField22, 
                      StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, 
                      StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, CUser, CDate, MUser, MDate, Active, 
                      StyleSeasonYearID)
SELECT     @NewStyleID AS StyleId, StyleCostingTypeID, StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, StyleCostingCustomField1, 
                      StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, 
                      StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, 
                      StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, 
                      StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, 
                      StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, 
                      StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, @CreatedBy AS CreatedBy, 
                      @CreatedDate AS CreatedDate, @CreatedBy AS CreatedBy, @CreatedDate AS CreatedDate, Active,
                      @NewStyleSeasonYearID
FROM         dbo.pStyleCostingHeader WITH (NOLOCK)
WHERE StyleId = @StyleId





INSERT INTO dbo.pStyleCosting
                      (StyleID, StyleCostingTypeID, StyleCostingFreightTypeID, StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, StyleCostingCustomField1, 
                      StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, 
                      StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, 
                      StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, 
                      StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, 
                      StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, 
                      StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, 
                      StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, CUser, CDate, MUser, MDate, 
                      Active, StyleSeasonYearID)
SELECT     @NewStyleID AS StyleId, StyleCostingTypeID, StyleCostingFreightTypeID, StyleQuotaDutyID, StyleCostingDate, StyleCostingStatus, 
                      StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, 
                      StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, 
                      StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, 
                      StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, 
                      StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, 
                      StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, 
                      StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, 
                      @CreatedBy AS Cuser, @CreatedDate AS Cdate, @CreatedBy AS Muser, @CreatedDate AS Mdate, 1,
                      @NewStyleSeasonYearID
FROM         dbo.pStyleCosting WITH (NOLOCK)
WHERE StyleId = @StyleId




GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '046', GetDate())
GO





