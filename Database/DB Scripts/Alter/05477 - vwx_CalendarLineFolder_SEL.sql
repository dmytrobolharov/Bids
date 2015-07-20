/****** Object:  View [dbo].[vwx_CalendarLineFolder_SEL]    Script Date: 04/03/2013 14:54:35 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_CalendarLineFolder_SEL]'))
DROP VIEW [dbo].[vwx_CalendarLineFolder_SEL]
GO

CREATE VIEW [dbo].[vwx_CalendarLineFolder_SEL]
AS
SELECT     clf.CalendarHeaderID, clf.LineFolderID, vlf.LineFolderID AS Expr1, vlf.LineFolderNo, vlf.LineFolderDescription, vlf.LineSubFolder1, vlf.LineSubFolder2, 
                      vlf.LineSubFolder3, vlf.LineSubFolder4, vlf.LineSubFolder5, vlf.LineSubFolder6, vlf.LineSubFolder7, vlf.LineSubFolder8, vlf.LineSubFolder9, vlf.CUser, vlf.CDate, 
                      vlf.MUser, vlf.MDate, vlf.MChange, vlf.LineFolderActive, vlf.LineFolderTypeID, vlf.SeasonYearID, vlf.LineFolderSortBy, vlf.FlashCostFixedMarkup, vlf.LineListTypeID, 
                      vlf.LineFolderDivisionID, vlf.Active, vlf.StyleType, vlf.StyleCategory
FROM         dbo.pCalendarLineFolder AS clf INNER JOIN
                      dbo.vwx_LineFolder_Header_SEL AS vlf ON clf.LineFolderID = vlf.LineFolderID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05477', GetDate())
GO
