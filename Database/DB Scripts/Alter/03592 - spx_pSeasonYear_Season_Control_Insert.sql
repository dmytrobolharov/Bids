
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 06 june 2012                                                                               */
-- * WorkItem #7868                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_pSeasonYear_Season_Control_Insert]    Script Date: 06/05/2012 20:42:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pSeasonYear_Season_Control_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pSeasonYear_Season_Control_Insert]
GO



/****** Object:  StoredProcedure [dbo].[spx_pSeasonYear_Season_Control_Insert]    Script Date: 06/05/2012 20:42:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_pSeasonYear_Season_Control_Insert]
(
@Season VARCHAR(20), 
@CUser AS NVARCHAR(50),
@CDate AS DATETIME 
) 
AS
DECLARE @Year NVARCHAR(4)

DECLARE cur_SY CURSOR FOR
SELECT DISTINCT(Custom) FROM pYear
OPEN cur_SY;
FETCH NEXT FROM cur_SY INTO @Year
WHILE @@FETCH_STATUS = 0
BEGIN
	IF (SELECT COUNT(Season) FROM pSeasonYear WHERE YEAR = @Year and Season = @Season) = 0
	INSERT INTO pSeasonYear 
	(
	SeasonYearID,
	Season,
	Year,
	Active,
	CustomID,
	CUser,
	CDate
	) 
	VALUES
	(
	NEWID(),
	@Season,
	@Year,
	1,
	NEWID(),
	@CUser,
	@CDate
	)
	FETCH NEXT FROM cur_SY INTO @Year
END
CLOSE cur_SY;
DEALLOCATE cur_SY;


GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.1.0000', '03592', GetDate())



GO

