-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 21 January 2014                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
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

DECLARE @Row_Index as int
DECLARE @Row_Count int

DECLARE @ColumnID uniqueidentifier
DECLARE @ColumnLookupQuery nvarchar(3000)

DECLARE @LookupQuery nvarchar(3000)
DECLARE @WherePos int


--------------------------------------------------------------------
-- Start adding any Control Panel items that don't exist already. --
--------------------------------------------------------------------
SELECT IDENTITY(INT, 1,1) AS DDRowIndex, ColumnID, ColumnLookupQuery
INTO #TempDataDictionary
FROM dDataDictionary
WHERE ColumnLookupQuery LIKE '% ORDER BY ItemValue WHERE Active = ''1'''


SET @Row_Index = 1
SET @Row_Count = (SELECT COUNT(*) FROM #TempDataDictionary)

WHILE @Row_Index <= @Row_Count 
BEGIN
	SELECT @ColumnID = ColumnID, 
		   @ColumnLookupQuery = ColumnLookupQuery
	FROM #TempDataDictionary WHERE DDRowIndex = @Row_Index

	IF @ColumnID IS NOT NULL AND @ColumnLookupQuery IS NOT NULL
	BEGIN
		SET @WherePos = CHARINDEX(' ORDER BY ItemValue WHERE Active = ''1''', @ColumnLookupQuery)
		SET @LookupQuery = LEFT(@ColumnLookupQuery, @WherePos) + ' WHERE Active = 1 ORDER BY ItemValue'

		UPDATE dDataDictionary
		SET ColumnLookupQuery = @LookupQuery
		WHERE ColumnID = @ColumnID
	END

	SET @Row_Index = @Row_Index + 1
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
             VALUES ('DB_Version', '0.5.0000', '06981', GetDate())
GO

SET NOCOUNT Off
GO
