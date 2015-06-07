IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_TemplateDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_TemplateDelete]
GO

CREATE PROCEDURE [dbo].[spx_StyleMeas_TemplateDelete]
(
	@AMLMeasHdrId UNIQUEIDENTIFIER
	, @CUser NVARCHAR(200)
	, @CDate DATETIME
)
AS
BEGIN
	DELETE FROM pAMLMeasLbl	WHERE AMLMeasHdrId = @AMLMeasHdrId
	DELETE FROM pAMLMeasPOM	WHERE AMLMeasHdrId = @AMLMeasHdrId
	DELETE FROM pAMLMeasIGC	WHERE AMLMeasHdrId = @AMLMeasHdrId
	DELETE FROM pAMLMeasHdr	WHERE AMLMeasHdrId = @AMLMeasHdrId
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09211', GetDate())
GO