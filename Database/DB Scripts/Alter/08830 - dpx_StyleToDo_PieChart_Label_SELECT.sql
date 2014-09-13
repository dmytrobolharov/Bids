IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleToDo_PieChart_Label_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_StyleToDo_PieChart_Label_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleToDo_PieChart_Label_SELECT]
(
	@DivisionID UNIQUEIDENTIFIER
	, @StyleTypeID INT = NULL
	, @StyleCategoryID UNIQUEIDENTIFIER = NULL
	, @StyleStatusID NVARCHAR(5) = NULL
)
AS
BEGIN
	DECLARE @Division NVARCHAR(200) = (SELECT Custom FROM iCustom1 WHERE CustomID = @DivisionID)
	DECLARE @StyleType NVARCHAR(200) = (SELECT StyleTypeDescription FROM pStyleType WHERE StyleTypeID = @StyleTypeID)
	DECLARE @StyleCategory NVARCHAR(200) = (SELECT StyleCategory FROM pStyleCategory WHERE StyleCategoryId = @StyleCategoryID)
	DECLARE @StyleStatus NVARCHAR(200) = (SELECT Custom FROM xCustom8 WHERE CustomKey = @StyleStatusID)

	SELECT @Division + ISNULL(' -> ' + @StyleType, '') + ISNULL(' -> ' + @StyleCategory, '') + ISNULL(' -> ' + @StyleStatus, '') AS TXT

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08830', GetDate())
GO
