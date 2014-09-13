IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_RemoveAgent_Docs]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_RemoveAgent_Docs]
GO

CREATE PROCEDURE [dbo].[spx_RemoveAgent_Docs] 
( 
@StyleDocumentID UNIQUEIDENTIFIER, 
@CUser nvarchar(200)
) 
AS  
BEGIN  
  
 BEGIN TRY --Start the Try Block..  
  BEGIN TRANSACTION -- Start the transaction.. 
	BEGIN            
	   DELETE FROM dbo.pStyleDocument WHERE StyleDocumentID=@StyleDocumentID AND CUser=@CUser            
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

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '192', GetDate())

GO




