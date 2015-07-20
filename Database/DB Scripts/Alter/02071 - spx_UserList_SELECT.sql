-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 27 October 2011                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_UserList_SELECT') AND type = N'P' )
	DROP PROCEDURE spx_UserList_SELECT
GO


CREATE PROCEDURE spx_UserList_SELECT
(
	@FullNameFilter NVARCHAR(155) = NULL,
	@UserNameFilter NVARCHAR(25) = NULL,
	@UserGroupNameFilter NVARCHAR(200) = NULL
)
AS 
	DECLARE @SQLString NVARCHAR(4000)
	DECLARE @ParamDefinitions nvarchar(4000)

	SET @FullNameFilter = '%' + @FullNameFilter + '%'
	SET @UserNameFilter = '%' + @UserNameFilter + '%'

	SET @SQLString = ''
	SET @SQLString = @SQLString + '	SELECT u.TeamID, u.FirstName, u.MiddleName, u.LastName, u.UserName, u.Active'
	SET @SQLString = @SQLString + '	FROM Users u WITH (NOLOCK)'

	IF @UserGroupNameFilter IS NOT NULL
	BEGIN
		SET @SQLString = @SQLString + '	INNER JOIN uUserGroup ug ON u.TeamID = ug.TeamID'
		SET @SQLString = @SQLString + '	INNER JOIN uGroup g ON ug.GroupID = g.GroupID'
	END

	SET @SQLString = @SQLString + '	WHERE u.TradePartner = 0'

	IF @FullNameFilter IS NOT NULL
	BEGIN
		SET @SQLString = @SQLString + '	AND (UPPER(u.FirstName) LIKE UPPER(@FullNameFilter_IN)'
		SET @SQLString = @SQLString + '	OR UPPER(u.MiddleName) LIKE UPPER(@FullNameFilter_IN)'
		SET @SQLString = @SQLString + '	OR UPPER(u.LastName) LIKE UPPER(@FullNameFilter_IN))'
	END

	IF @UserNameFilter IS NOT NULL
	BEGIN
		SET @SQLString = @SQLString + '	AND (UPPER(u.UserName) LIKE UPPER(@UserNameFilter_IN))'
	END

	IF @UserGroupNameFilter IS NOT NULL
	BEGIN
		SET @SQLString = @SQLString + '	AND g.GroupName = @UserGroupNameFilter_IN'
	END

	SET @SQLString = @SQLString + '	ORDER BY u.FirstName, u.MiddleName, u.LastName'


	SET @ParamDefinitions = N'@FullNameFilter_IN nvarchar(155),
	                        @UserNameFilter_IN nvarchar(25),
	                        @UserGroupNameFilter_IN nvarchar(200)'


	EXECUTE sp_executesql
			@SQLString,
			@ParamDefinitions,
			@FullNameFilter_IN = @FullNameFilter,
			@UserNameFilter_IN = @UserNameFilter,
			@UserGroupNameFilter_IN = @UserGroupNameFilter
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '02071', GetDate())
GO

SET NOCOUNT Off
GO
