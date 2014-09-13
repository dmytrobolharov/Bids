-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSetBOMItemTemp_SELECTED]    Script Date: 12/18/2011 18:08:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSetBOMItemTemp_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSetBOMItemTemp_SELECTED]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSetBOMItemTemp_SELECTED]    Script Date: 12/18/2011 18:08:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestSetBOMItemTemp_SELECTED] (
@StyleID uniqueidentifier,
@SampleRequestGroupID uniqueidentifier
)

AS 

DECLARE @StyleSet nvarchar
DECLARE @Pc1 nvarchar(100)
DECLARE @Pc2 nvarchar(100)
DECLARE @Pc3 nvarchar(100)
DECLARE @Pc4 nvarchar(100)


SELECT @StyleSet = StyleSet ,  @Pc1 =  PC1  ,  @Pc2 =  PC2  ,   @Pc3 =  PC3  ,  @Pc4 =  PC4 
FROM dbo.pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID 

IF @PC1 IS Null OR @PC1 = '' SET @PC1 = '1st Set'
IF @PC2 IS Null OR @PC2 = '' SET @PC2 = '2nd Set'
IF @PC3 IS Null OR @PC3 = '' SET @PC3 = '3rd Set'
IF @PC4 IS Null OR @PC4 = '' SET @PC4 = '4th Set'

SELECT StyleSet AS ID , 
CASE StyleSet 
	WHEN 1 THEN @PC1
	WHEN 2 THEN @PC2
	WHEN 3 THEN @PC3
	WHEN 4 THEN @PC4
END AS StyleSet  
FROM pSampleRequestSetItemTemp WITH (NOLOCK)
WHERE SampleRequestGroupID  =  @SampleRequestGroupID
ORDER BY ID

SELECT top 1 StyleSet AS ID , 
CASE StyleSet 
	WHEN 1 THEN @PC1
	WHEN 2 THEN @PC2
	WHEN 3 THEN @PC3
	WHEN 4 THEN @PC4
END AS StyleSet  
FROM pSampleRequestSetItemTemp WITH (NOLOCK)
WHERE SampleRequestGroupID  =  @SampleRequestGroupID
ORDER BY ID

select top 1  ID,StyleSet from
(SELECT top 2 StyleSet AS ID , 
CASE StyleSet 
	WHEN 1 THEN @PC1
	WHEN 2 THEN @PC2
	WHEN 3 THEN @PC3
	WHEN 4 THEN @PC4
END AS StyleSet  
FROM pSampleRequestSetItemTemp WITH (NOLOCK)
WHERE SampleRequestGroupID  =  @SampleRequestGroupID
group by StyleSet
ORDER BY ID)tamp 
ORDER BY ID desc

select top 1 ID,StyleSet from
(SELECT top 3 StyleSet AS ID , 
CASE StyleSet 
	WHEN 1 THEN @PC1
	WHEN 2 THEN @PC2
	WHEN 3 THEN @PC3
	WHEN 4 THEN @PC4
END AS StyleSet  
FROM pSampleRequestSetItemTemp WITH (NOLOCK)
WHERE SampleRequestGroupID  =  @SampleRequestGroupID
ORDER BY ID)tamp
ORDER BY ID desc

select top 1 ID,StyleSet from
(SELECT top 4 StyleSet AS ID , 
CASE StyleSet 
	WHEN 1 THEN @PC1
	WHEN 2 THEN @PC2
	WHEN 3 THEN @PC3
	WHEN 4 THEN @PC4
END AS StyleSet  
FROM pSampleRequestSetItemTemp WITH (NOLOCK)
WHERE SampleRequestGroupID  =  @SampleRequestGroupID
ORDER BY ID)tamp 
ORDER BY ID desc

/*


SET @StyleSet = (SELECT StyleSet FROM dbo.pStyleHeader WITH (NOLOCK) WHERE (StyleID = @StyleID))

SET @Pc1 = (SELECT PC1 FROM dbo.pStyleHeader WITH (NOLOCK) WHERE (StyleID = @StyleID))
SET @Pc2 = (SELECT PC2 FROM dbo.pStyleHeader WITH (NOLOCK) WHERE (StyleID = @StyleID))
SET @Pc3 = (SELECT PC3 FROM dbo.pStyleHeader WITH (NOLOCK) WHERE (StyleID = @StyleID))
SET @Pc4 = (SELECT PC4 FROM dbo.pStyleHeader WITH (NOLOCK) WHERE (StyleID = @StyleID))

IF @PC1 IS Null SET @PC1 = '1st Set'
IF @PC2 IS Null SET @PC2 = '2nd Set'
IF @PC3 IS Null SET @PC3 = '3rd Set'
IF @PC4 IS Null SET @PC4 = '4th Set'


if (@StyleSet = '1') 
	BEGIN
	SELECT '1' AS ID, @Pc1 as StyleSet WHERE 1 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	END
ELSE IF (@StyleSet = '2') 
	BEGIN
	SELECT '1' AS ID, @Pc1 as StyleSet WHERE 1 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	UNION
	SELECT '2' AS ID, @Pc2 as StyleSet WHERE 2 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	END
ELSE IF (@StyleSet = '3') 
	BEGIN
	SELECT '1' AS ID, @Pc1 as StyleSet WHERE 1 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	UNION
	SELECT '2' AS ID, @Pc2 as StyleSet WHERE 2 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	UNION
	SELECT '3' AS ID, @Pc3 as StyleSet WHERE 3 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)		
	END
ELSE IF (@StyleSet = '4') 
	BEGIN
	SELECT '1' AS ID, @Pc1 as StyleSet WHERE 1 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	UNION
	SELECT '2' AS ID, @Pc2 as StyleSet WHERE 2 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)
	UNION
	SELECT '3' AS ID, @Pc3 as StyleSet WHERE 3 IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)		
	UNION
	SELECT '4' AS ID, @Pc4 as StyleSet WHERE 4  IN  (SELECT StyleSet FROM pSampleRequestSetItemTemp WITH (NOLOCK) WHERE SampleRequestGroupID = @SampleRequestGroupID)	
	END
*/

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02378'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02378', GetDate())

END

GO