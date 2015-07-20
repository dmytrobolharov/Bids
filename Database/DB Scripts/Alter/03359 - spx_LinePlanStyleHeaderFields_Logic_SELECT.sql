IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanStyleHeaderFields_Logic_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanStyleHeaderFields_Logic_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanStyleHeaderFields_Logic_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
/*
--***
--** Comment#01 - Artemio Gomez - 3/26/2010
--** Add and extra paramenter to the stored procedure to define if this SP is executed from a page when trying to do a copy style search
--** Default value will be "0", This in case a client wants or not to filter or Loock the hearchy fields.
--***
*/
CREATE PROCEDURE [dbo].[spx_LinePlanStyleHeaderFields_Logic_SELECT] (
@LinePlanItemID UNIQUEIDENTIFIER ,
@StyleCopy INT   = 0  -- Comment#01 
) 
AS 



CREATE TABLE #tmp ( 
RecID INT IDENTITY (1,1),
StyleHeaderField NVARCHAR(200),
DefaultValue NVARCHAR(200),
SetDefault INT DEFAULT 1 
)


IF @StyleCopy = 0 
BEGIN 

	DECLARE @LinePlanTemplateID UNIQUEIDENTIFIER 
	DECLARE @VALUE1 NVARCHAR(200) -- CustomField2 
	DECLARE @VALUE2 NVARCHAR(200) -- Styletype
	DECLARE @VALUE3 NVARCHAR(200) -- StyleCategory

	SELECT 
	@LinePlanTemplateID  = d.LinePlanTemplateID, 
	@VALUE1 = b.LinePlanAttributeText1, 
	@VALUE2 = c2.LinePlanAttributeValue,
	@VALUE3 = LOWER( CAST(e.StyleCategoryId AS nvarchar(40)) )
	FROM pLinePlanItem a
	INNER JOIN pLinePlanRange b ON a.LinePlanRangeID = b.LinePlanRangeID 
	INNER JOIN pLinePlanAttributeItem c2 ON b.LinePlanAttributeItemID2 = c2.LinePlanAttributeItemID
	INNER JOIN pLinePlanAttributeItem c3 ON b.LinePlanAttributeItemID3 = c3.LinePlanAttributeItemID
	INNER JOIN pStyleCategory e ON e.StyleCategoryID = c3.LinePlanAttributeValue
	INNER JOIN pLinePlan d ON a.LinePlanID = d.LinePlanID 
	WHERE a.LinePlanItemID = @LinePlanItemID 

	INSERT INTO #tmp ( StyleHeaderField ) 
	SELECT c.StyleHeaderField 
	FROM pLinePlanItem a
	INNER JOIN pLinePlan b ON a.LinePlanID =  b.LinePlanID 
	INNER JOIN pLinePlanTemplateItem c ON c.LinePlanTemplateID = b.LinePlanTemplateID 
	WHERE a.LinePlanItemID = @LinePlanItemID 
	AND c.Active = '1'
	AND c.LinePlanTemplateID = @LinePlanTemplateID
	ORDER BY CAST( c.LinePlanTemplateItemSort AS INT ) 

	DECLARE @ROWID INT 
	DECLARE @TOTAL INT 
	DECLARE @VALUE NVARCHAR(200)

	SET @ROWID =  1
	SELECT @TOTAL = COUNT (*) FROM #tmp

	WHILE @ROWID <= @TOTAL
	BEGIN 

		SET @VALUE = NULL 
		
		IF @ROWID = 1			SET @VALUE  = @VALUE1
		ELSE IF @ROWID = 2		SET @VALUE  = @VALUE2
		ELSE IF @ROWID = 3 		SET @VALUE  = @VALUE3
		
		
		IF @VALUE IS NOT NULL
		BEGIN  
			--IF @ROWID = 3 
			--	UPDATE #tmp SET DefaultValue = @VALUE, SetDefault = 0  WHERE RecID = @ROWID 
			--ELSE 
				UPDATE #tmp SET DefaultValue = @VALUE WHERE RecID = @ROWID 
		END 

		SET @ROWID = @ROWID  + 1
	END 

END 

SELECT  * FROM #tmp

DROP TABLE #tmp

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03359'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03359', GetDate())
END	
GO