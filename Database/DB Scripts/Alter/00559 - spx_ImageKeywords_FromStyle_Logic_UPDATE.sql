IF EXISTS (select * from sysobjects where id = object_id('spx_ImageKeywords_FromStyle_Logic_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_ImageKeywords_FromStyle_Logic_UPDATE
GO


CREATE PROCEDURE dbo.spx_ImageKeywords_FromStyle_Logic_UPDATE(
@StyleID UNIQUEIDENTIFIER,
@ImageID UNIQUEIDENTIFIER,
@ImageVersion INT
)
AS 



--**
--* Select the Style Keywords 
--**
DECLARE @CustomField1 NVARCHAR(200)
DECLARE @CustomField4 NVARCHAR(200)
DECLARE @CustomField5 NVARCHAR(200)
DECLARE @CustomField6 NVARCHAR(200)
DECLARE @CustomField7 NVARCHAR(200)
DECLARE @CustomField8 NVARCHAR(200)
DECLARE @CustomField9 NVARCHAR(200)
DECLARE @CustomField10 NVARCHAR(200)
DECLARE @CustomField11 NVARCHAR(200)
DECLARE @CustomField12 NVARCHAR(200)
DECLARE @CustomField13 NVARCHAR(200)

SELECT @CustomField1=CustomField1, @CustomField4=CustomField4, @CustomField5=CustomField5, @CustomField6=CustomField6,
@CustomField7=CustomField7, @CustomField8=CustomField8, @CustomField9=CustomField9,
@CustomField10=CustomField10, @CustomField11=CustomField11, @CustomField12=CustomField12, @CustomField13=CustomField13
FROM pStyleHeader a WITH (NOLOCK)
WHERE a.StyleID = @StyleID


DECLARE @Keywords NVARCHAR(4000)
SET @Keywords = ''

IF LEN(ISNULL(@CustomField1,'')) > 0  SET @Keywords = @CustomField1 + ','
IF LEN(ISNULL(@CustomField4,'')) > 0  SET @Keywords = @Keywords + @CustomField4 + ','
IF LEN(ISNULL(@CustomField5,'')) > 0  SET @Keywords = @Keywords + @CustomField5 + ','
IF LEN(ISNULL(@CustomField6,'')) > 0  SET @Keywords = @Keywords + @CustomField6 + ','
IF LEN(ISNULL(@CustomField7,'')) > 0  SET @Keywords = @Keywords + @CustomField7 + ','
IF LEN(ISNULL(@CustomField8,'')) > 0  SET @Keywords = @Keywords + @CustomField8 + ','
IF LEN(ISNULL(@CustomField9,'')) > 0  SET @Keywords = @Keywords + @CustomField9 + ','
IF LEN(ISNULL(@CustomField10,'')) > 0  SET @Keywords = @Keywords + @CustomField10 + ','
IF LEN(ISNULL(@CustomField11,'')) > 0  SET @Keywords = @Keywords + @CustomField11 + ','
IF LEN(ISNULL(@CustomField12,'')) > 0  SET @Keywords = @Keywords + @CustomField12 + ','
IF LEN(ISNULL(@CustomField13,'')) > 0  SET @Keywords = @Keywords + @CustomField13 + ','

SET @Keywords = SUBSTRING(@Keywords , 1, LEN(@Keywords)-1)


--**
--* Update Keywords in image records
--**
BEGIN 
	UPDATE dbo.pImage
	SET ImageKeywords = @Keywords
	WHERE ImageID = @ImageID AND Version = @ImageVersion
END 

BEGIN
	UPDATE dbo.hImage
	SET ImageKeywords = @Keywords
	WHERE ImageID = @ImageID AND Version = @ImageVersion
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '559', GetDate())
GO