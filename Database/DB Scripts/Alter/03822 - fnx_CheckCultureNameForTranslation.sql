IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_CheckCultureNameForTranslation]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_CheckCultureNameForTranslation]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnx_CheckCultureNameForTranslation]
(
    @CultureName VARCHAR(6)
)

RETURNS BIT

AS

BEGIN

DECLARE @RESULT BIT

-- supported languages of Microsoft Translator

IF  LEFT(@CultureName, 2) = 'ar' OR
	LEFT(@CultureName, 2) = 'bg' OR
	LEFT(@CultureName, 2) = 'ca' OR
	LEFT(@CultureName, 2) = 'zh' OR
	LEFT(@CultureName, 2) = 'cs' OR
	LEFT(@CultureName, 2) = 'da' OR
	LEFT(@CultureName, 2) = 'nl' OR
	LEFT(@CultureName, 2) = 'en' OR
	LEFT(@CultureName, 2) = 'et' OR
	LEFT(@CultureName, 2) = 'fa' OR
	LEFT(@CultureName, 2) = 'fi' OR
	LEFT(@CultureName, 2) = 'fr' OR
	LEFT(@CultureName, 2) = 'de' OR
	LEFT(@CultureName, 2) = 'el' OR
	LEFT(@CultureName, 2) = 'ht' OR
	LEFT(@CultureName, 2) = 'he' OR
	LEFT(@CultureName, 2) = 'hi' OR
	LEFT(@CultureName, 2) = 'hu' OR
	LEFT(@CultureName, 2) = 'id' OR
	LEFT(@CultureName, 2) = 'it' OR
	LEFT(@CultureName, 2) = 'ja' OR
	LEFT(@CultureName, 2) = 'ko' OR
	LEFT(@CultureName, 2) = 'lv' OR
	LEFT(@CultureName, 2) = 'lt' OR
	LEFT(@CultureName, 2) = 'no' OR
	LEFT(@CultureName, 2) = 'pl' OR
	LEFT(@CultureName, 2) = 'pt' OR
	LEFT(@CultureName, 2) = 'ro' OR
	LEFT(@CultureName, 2) = 'ru' OR
	LEFT(@CultureName, 2) = 'sk' OR
	LEFT(@CultureName, 2) = 'sl' OR
	LEFT(@CultureName, 2) = 'es' OR
	LEFT(@CultureName, 2) = 'sv' OR
	LEFT(@CultureName, 2) = 'th' OR
	LEFT(@CultureName, 2) = 'tr' OR
	LEFT(@CultureName, 2) = 'uk' OR
	LEFT(@CultureName, 2) = 'vi'
BEGIN
	SET @RESULT = 1
END
ELSE
BEGIN
	SET @RESULT = 0
END

RETURN @RESULT
    
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03822', GetDate())
GO
