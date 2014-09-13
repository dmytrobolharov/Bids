IF EXISTS(SELECT BOLExceptionId FROM pStyleBOLException WHERE BOLExceptionId = '00000000-0000-0000-0000-000000000000')
   BEGIN
        PRINT 'Standart exception already exists'
   END
ELSE

BEGIN
	INSERT INTO pStyleBOLException
	(BOLExceptionId,BOLExceptionName)
	VALUES
	('00000000-0000-0000-0000-000000000000','Standart')
END
GO 


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02173'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02173', GetDate())
END

GO
