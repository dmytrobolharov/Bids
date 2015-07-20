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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMWorkflowAccess]    Script Date: 12/18/2011 18:29:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMWorkflowAccess]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMWorkflowAccess]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMWorkflowAccess]    Script Date: 12/18/2011 18:29:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMWorkflowAccess]  (
@TeamID UNIQUEIDENTIFIER  ,
@SampleRequestTradeID UNIQUEIDENTIFIER 
)

AS


DECLARE @Total INT 
DECLARE @Current INT 
DECLARE @AccessRoleID INT 
DECLARE @AccessDelete INT 
DECLARE @AccessModify INT 
DECLARE @RestrictionDelete  INT 
DECLARE @RestrictionModify  INT 


CREATE TABLE   #tempAccess  (
	rowid INT IDENTITY ( 1,1)  ,
	AccessRoleID INT,	
	AccessDelete INT ,  
	AccessModify INT
)


INSERT INTO  #tempAccess (AccessRoleId , AccessDelete , AccessModify ) 
SELECT AccessRoleId , AccessDelete , AccessModify
FROM dbo.sAccessSampleFolder WITH (NOLOCK)
WHERE TeamID = @TeamID
AND SampleTypeId IN ( 
	select SampleWorkflowID from dbo.pSampleRequestSubmitBOM WITH (NOLOCK)
	where SampleRequestTradeID = @SampleRequestTradeID
)
GROUP BY AccessRoleID , AccessDelete , AccessModify


SELECT @Total   = COUNT (*) FROM  #tempAccess  
SET @Current = 1


SET @RestrictionDelete   = 0 
SET @RestrictionModify  = 0 


WHILE @Current <= @Total 
BEGIN
	
	SELECT @AccessRoleID=AccessRoleID, @AccessDelete=AccessDelete , @AccessModify = AccessModify 
	FROM #tempAccess
	WHERE  rowid = @Current 


	IF @AccessRoleID = 0 
	BEGIN
		SET @RestrictionDelete  = @RestrictionDelete  + 1 	
		SET @RestrictionModify = @RestrictionModify  + 1 
	END
	ELSE 
	BEGIN 
		IF @AccessRoleID = 2 
		BEGIN
			IF @AccessDelete = 0
				SET @RestrictionDelete  = @RestrictionDelete  + 1 
			
			IF @AccessModify = 0 
				SET @RestrictionModify = @RestrictionModify  + 1 
		END 
	END 

	SET @Current = @Current + 1 
END 


SELECT  @RestrictionDelete AS RestrictionDelete, @RestrictionModify as RestrictionModify





DROP TABLE #tempAccess

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02396'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02396', GetDate())

END

GO
