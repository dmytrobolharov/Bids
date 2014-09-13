IF EXISTS (select * from sysobjects where id = object_id('spx_StyleCostingTypeLogic_CopyFrom_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_StyleCostingTypeLogic_CopyFrom_INSERT
GO


CREATE  PROCEDURE spx_StyleCostingTypeLogic_CopyFrom_INSERT (
@StyleID UNIQUEIDENTIFIER, 
@StyleSeasonYearID UNIQUEIDENTIFIER,
@StyleCostingID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200),
@CDate DATETIME
)
AS


DECLARE @StyleCostingTypeID  INT 

SELECT @StyleCostingTypeID = StyleCostingTypeID  FROM pStyleCosting 
WHERE StyleCostingID = @StyleCostingID

IF (SELECT COUNT(*) FROM pStyleCosting WHERE StyleSeasonYearID = @StyleSeasonYearID AND StyleCostingTypeID = @StyleCostingTypeID)  = 0 
BEGIN 

	INSERT INTO pStyleCosting ( 
	StyleCostingID, StyleID, StyleCostingTypeID, StyleCostingFreightTypeID, sTYLECostingStatus,  
	StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, 
	StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, 
	StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, 
	StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, 
	StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, 
	StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, 
	StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, 
	CUSer, CDate, MUser, MDate, Active, StyleSeasonYearID)
	SELECT NEWID() AS StyleCostingID, @StyleID AS StyleID, StyleCostingTypeID, StyleCostingFreightTypeID, sTYLECostingStatus,  
	StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, 
	StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, 
	StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, 
	StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, 
	StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, 
	StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, 
	StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, 
	@CUser AS CUSer, @CDate AS CDate, @CUser AS MUser, @CDate AS MDate, Active, @StyleSeasonYearID AS StyleSeasonYearID
	FROM pStyleCosting
	WHERE StyleCostingID = @StyleCostingID 
	
END 

GO