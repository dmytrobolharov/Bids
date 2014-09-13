IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ReportTable_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ReportTable_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_ReportTable_INSERT]
(
@StyleID uniqueidentifier = '00000000-0000-0000-0000-000000000000', -- if it is not Style Folder
@DataXmlId uniqueidentifier,
@DataColumnNumber int, 
@DataColumnName nvarchar(200), 
@DataHeader nvarchar(200), 
@DataValue nvarchar(4000), 
@DataSort varchar(5)
)
AS 

IF (SELECT COUNT(*) FROM rReportTable WITH (NOLOCK) WHERE DataXmlId = @DataXmlId AND DataColumnName = @DataColumnName) = 0
	BEGIN
		INSERT INTO rReportTable (StyleID, DataXmlId, DataColumnNumber, DataColumnName, DataHeader, DataValue, DataSort) 
		VALUES 
		(@StyleID, @DataXmlId, @DataColumnNumber, @DataColumnName, @DataHeader, @DataValue, @DataSort)
	END
ELSE
	BEGIN
		/*Delete the already existing record so that changes can be captured.*/
		DELETE
		FROM rReportTable
		WHERE DataXmlId = @DataXmlId AND DataColumnName = @DataColumnName

		/*Insert the field information.*/
		INSERT INTO rReportTable (StyleID, DataXmlId, DataColumnNumber, DataColumnName, DataHeader, DataValue, DataSort) 
		VALUES 
		(@StyleID, @DataXmlId, @DataColumnNumber, @DataColumnName, @DataHeader, @DataValue, @DataSort)
	END


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03200'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03200', GetDate())

END
GO