-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                               */
-- * Database:                                                                                  */
-- * 26 July 2011                                                                                */
-- * WorkItem#3506                                                                                         */
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

/****** Object:  StoredProcedure [dbo].[spx_RemoveMaterialAgent_Docs]    Script Date: 07/26/2011 10:19:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_RemoveMaterialAgent_Docs]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_RemoveMaterialAgent_Docs]
GO

/****** Object:  StoredProcedure [dbo].[spx_RemoveMaterialAgent_Docs]    Script Date: 07/26/2011 10:19:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_RemoveMaterialAgent_Docs]   
(   
@MaterialDocumentID UNIQUEIDENTIFIER,   
@CUser nvarchar(200)  
)   
AS    
BEGIN    
    
 BEGIN TRY --Start the Try Block..    
  BEGIN TRANSACTION -- Start the transaction..   
 BEGIN              
    DELETE FROM dbo.pMaterialDocument WHERE MaterialDocumentID=@MaterialDocumentID AND CUser=@CUser              
 END          
  COMMIT TRAN -- Transaction Success!    
 END TRY    
    
 BEGIN CATCH    
  IF @@TRANCOUNT > 0    
  ROLLBACK TRAN --RollBack in case of Error    
        DECLARE @ErrorMessage NVARCHAR(4000);    
        DECLARE @ErrorSeverity INT;    
        DECLARE @ErrorState INT;    
    
        SELECT @ErrorMessage = ERROR_MESSAGE();    
        SELECT @ErrorSeverity = ERROR_SEVERITY();    
        SELECT @ErrorState = ERROR_STATE();    
    
        RAISERROR (    
       @ErrorMessage, -- Message text.    
                   @ErrorSeverity, -- Severity.    
                   @ErrorState -- State.    
                   );    
    
 END CATCH    
    
END    
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01662'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01662', GetDate())
END
GO	





