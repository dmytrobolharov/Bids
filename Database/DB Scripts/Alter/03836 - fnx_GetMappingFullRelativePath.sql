-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 24 August 2012                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetMappingFullRelativePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [dbo].[fnx_GetMappingFullRelativePath]
GO

/*
Comments:

General - Peter Durnin - August 30, 2012
	Pass the HttpServer location, the MapURL and the MapFolder and this will generate a full relative path.
*/
CREATE FUNCTION [dbo].[fnx_GetMappingFullRelativePath]
(
	@HttpServer nvarchar(4000),
	@MapURL nvarchar(500),
	@MapFolder nvarchar(50)
)

RETURNS nvarchar(500)

AS

BEGIN

	DECLARE @NewMapURL AS nvarchar(500)
	SET @NewMapURL = @MapURL

	IF LEN(@MapURL) > 0 AND LEN(@MapFolder) > 0
	BEGIN
		DECLARE @BaseURL AS nvarchar(500)
		SET @BaseURL = @HttpServer

		IF CHARINDEX('/', UPPER(@HttpServer)) > 0
		BEGIN
			SET @BaseURL = '/' + REVERSE(SUBSTRING(REVERSE(@HttpServer),0,CHARINDEX(REVERSE('/'),REVERSE(@HttpServer)))) + '/'
		END

		DECLARE @BaseURLTemp AS nvarchar(500)
		SET @BaseURLTemp = ''

		IF SUBSTRING(UPPER(@MapFolder), 1, 5) = 'APPS/'
		BEGIN
			SET @BaseURLTemp = @BaseURL + @MapFolder
		END
		ELSE
		BEGIN
			IF CHARINDEX('FOLDER', UPPER(@MapFolder)) > 0
			BEGIN
				SET @BaseURLTemp = @BaseURL + REPLACE(REPLACE(UPPER(@MapFolder), 'FOLDER', ''), ' ', '')
			END
			ELSE
			BEGIN
				SET @BaseURLTemp = @BaseURL + @MapFolder
			END
		END

		IF LEN(@BaseURLTemp) > 0
		BEGIN
			IF SUBSTRING(@BaseURLTemp, LEN(@BaseURLTemp), 1) <> '/'
			BEGIN
				SET @BaseURLTemp = @BaseURLTemp + '/'
			END
		END

		SET @NewMapURL = LOWER(@BaseURLTemp) + @MapURL
	END

	RETURN @NewMapURL

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03836', GetDate())
GO

SET NOCOUNT Off
GO
