-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 22 January 2012                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
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

IF EXISTS (select * from sysobjects where id = object_id('spx_LinePlanItemNewLogic_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_LinePlanItemNewLogic_UPDATE
GO

CREATE PROCEDURE spx_LinePlanItemNewLogic_UPDATE
(
	@LinePlanItemID UNIQUEIDENTIFIER , 
	@StyleID UNIQUEIDENTIFIER , 
	@CUser NVARCHAR(200), 
	@CDate DATETIME
)
AS

DECLARE @LinePlanID  UNIQUEIDENTIFIER 
DECLARE @AttributeName NVARCHAR(200)	
DECLARE @LinePlanAttributeType NVARCHAR(200)	
DECLARE @Division NVARCHAR(200) -- #01

-- Start #01 
--Select @Division = b.LinePlanAttributeText1 
--from pLinePlanItem a
--INNER JOIN pLinePlanRange b ON a.LinePlanRangeID = b.LinePlanRangeID
--Where LinePlanItemId= @LinePlanItemID
--AND b.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'

--UPDATE pStyleHeader
--Set CustomField2 = @Division
--Where StyleID = @StyleID
-- End #01

UPDATE pLinePlanItem SET 
	StyleID = @StyleID,
	MDate = @CDate,
	MUser = @CUser
WHERE LinePlanItemID = @LinePlanItemID 

SELECT @LinePlanAttributeType  = d.LinePlanAttributeType, @AttributeName  = c.AttributeName  
FROM pLinePlanItem a 
INNER JOIN pLinePlanStyleAttributeItem  b ON a.LinePlanStyleAttributeItemID   = b.LinePlanStyleAttributeItemID  
INNER JOIN pLinePlanStyleAttribute  c ON b.LinePlanStyleAttributeID = c.LinePlanStyleAttributeID 
INNER JOIN pLinePlanAttributeType d ON d.LinePlanAttributeTypeID = c.LinePlanAttributeTypeID 
WHERE  a.LinePlanItemID = @LinePlanItemID

IF @LinePlanAttributeType IS NOT NULL  AND @AttributeName  IS NOT NULL 
BEGIN

	IF LTRIM(RTRIM(LOWER(@LinePlanAttributeType))) = 'group' 
	BEGIN
		UPDATE pStyleHeader SET CustomField10 = @AttributeName WHERE StyleID = @StyleID 
	END 
	ELSE IF LTRIM(RTRIM(LOWER(@LinePlanAttributeType))) = 'style level' 
	BEGIN
		UPDATE pStyleHeader SET CustomField20 = @AttributeName WHERE StyleID = @StyleID 
	END 
	ELSE IF LTRIM(RTRIM(LOWER(@LinePlanAttributeType))) = 'Fabrication'						--Comment #02
	BEGIN
		UPDATE pStyleHeader SET CustomField17 = @AttributeName WHERE StyleID = @StyleID 
	END 
	ELSE IF LTRIM(RTRIM(LOWER(@LinePlanAttributeType))) = 'Denim Fit'						--Comment #02
	BEGIN
		UPDATE pStyleHeader SET CustomField18 = @AttributeName WHERE StyleID = @StyleID 
	END 
	ELSE IF LTRIM(RTRIM(LOWER(@LinePlanAttributeType))) = 'Treatment'						--Comment #02
	BEGIN
		UPDATE pStyleHeader SET CustomField19 = @AttributeName WHERE StyleID = @StyleID 
	END 
	ELSE IF LTRIM(RTRIM(LOWER(@LinePlanAttributeType))) = 'Branding'						--Comment #02
	BEGIN
		UPDATE pStyleHeader SET CustomField21 = @AttributeName WHERE StyleID = @StyleID 
	END

END 

/*
SELECT @LinePlanID = LinePlanID FROM pLinePlanItem WHERE LinePlanItemID =  @LinePlanItemID 
UPDATE pStyleHeader 
SET StyleWorkflowID = '10000000-1000-1000-1000-100000000000',
StyleStatusID  = 0,
LinePlanID = @LinePlanID , 
LinePlanItemID = @LinePlanItemID
WHERE StyleID =@StyleID
*/
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '02979', GetDate())
GO

SET NOCOUNT Off
GO
