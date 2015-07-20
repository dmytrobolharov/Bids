IF EXISTS(SELECT BOLExceptionId FROM pStyleBOLException WHERE BOLExceptionId = '00000000-0000-0000-0000-000000000000')
	BEGIN
		UPDATE pStyleBOLException SET BOLExceptionName = 'Standard' WHERE BOLExceptionId = '00000000-0000-0000-0000-000000000000'
	END
ELSE
	BEGIN
		INSERT INTO pStyleBOLException (BOLExceptionId,BOLExceptionName)
		VALUES ('00000000-0000-0000-0000-000000000000','Standard')
	END
GO 


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02223'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02223', GetDate())
END

GO
