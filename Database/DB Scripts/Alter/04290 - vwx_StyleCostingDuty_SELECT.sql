/****** Object:  View [dbo].[vwx_StyleCostingDuty_SELECT]    Script Date: 11/05/2012 14:04:41 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleCostingDuty_SELECT]'))
DROP VIEW [dbo].[vwx_StyleCostingDuty_SELECT]
GO

/****** Object:  View [dbo].[vwx_StyleCostingDuty_SELECT]    Script Date: 11/05/2012 14:04:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_StyleCostingDuty_SELECT]
AS
SELECT     CustomID, CustomSort, TempID, TempNo, MDate, MUser, CDate, CUser, DutyCustom2, DutyCustom1, DutyGender, DutyMaterialType, DutyCountry, DutySurcharge, 
                      DutyPerc, DutyCategory, DutyItem, DutyFiber, Custom, CustomKey, CAST(ISNULL(Active, 0) AS INT) AS Active
FROM         dbo.pStyleCostingDuty

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04290', GetDate())
GO
