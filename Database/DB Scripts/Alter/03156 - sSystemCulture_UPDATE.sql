UPDATE [sSystemCulture]
   SET [DateValidationRegEx] = '$(?<=\d)(?:(?:(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})|(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))|(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2}))($|\ (?=\d)))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$'
 WHERE ([CultureIndentifierID] = '0x7C04' AND [CultureName] = 'zh-CHT' AND [CultureCountry] = 'Chinese (Traditional)') OR
	   ([CultureIndentifierID] = '0x0004' AND [CultureName] = 'zh-CHS' AND [CultureCountry] = 'Chinese (Simplified)') 
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03156'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03156', GetDate())

END
GO
