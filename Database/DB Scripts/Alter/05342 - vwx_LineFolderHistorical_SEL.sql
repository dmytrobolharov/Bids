/****** Object:  View [dbo].[vwx_LineFolderHistorical_SEL]    Script Date: 03/19/2013 15:21:04 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolderHistorical_SEL]'))
DROP VIEW [dbo].[vwx_LineFolderHistorical_SEL]
GO

CREATE VIEW [dbo].[vwx_LineFolderHistorical_SEL]
AS
SELECT     lfh.LineFolderMasterID, lfh.LineFolderID, vlf.LineFolderID AS Expr1, vlf.LineFolderNo, vlf.LineFolderDescription, vlf.LineSubFolder1, vlf.LineSubFolder2, 
                      vlf.LineSubFolder3, vlf.LineSubFolder4, vlf.LineSubFolder5, vlf.LineSubFolder6, vlf.LineSubFolder7, vlf.LineSubFolder8, vlf.LineSubFolder9, vlf.CUser, vlf.CDate, 
                      vlf.MUser, vlf.MDate, vlf.MChange, vlf.LineFolderActive, vlf.LineFolderTypeID, vlf.SeasonYearID, vlf.LineFolderSortBy, vlf.FlashCostFixedMarkup, vlf.LineListTypeID, 
                      vlf.LineFolderDivisionID, vlf.Active, vlf.StyleType, vlf.StyleCategory
FROM         dbo.pLineFolderHistorical AS lfh INNER JOIN
                      dbo.vwx_LineFolder_Header_SEL AS vlf ON lfh.LineFolderID = vlf.LineFolderID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05342', GetDate())
GO
