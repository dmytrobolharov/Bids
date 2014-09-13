IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTextImageItemSort_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleTextImageItemSort_Update]
GO

CREATE PROCEDURE [dbo].[spx_StyleTextImageItemSort_Update]  
(@WorkflowID UNIQUEIDENTIFIER,  
@ItemID UNIQUEIDENTIFIER,  
@TeamID UNIQUEIDENTIFIER,  
@Sort NVARCHAR(10),  
@MUser NVARCHAR(200),  
@MDate DATETIME)  
AS   
  
 DECLARE @CountWF INT
 
 SELECT @CountWF = COUNT(*) FROM dbo.pImageWFValidation WHERE WorkflowID = @WorkflowID
 
 If @WorkFlowId = '40000000-0000-0000-0000-000000000018'  OR @CountWF > 0 
  BEGIN  
   UPDATE pStyleDetailForm   
   SET  MUser = @MUser, MDate = @MDate, Sort = @Sort  
   WHERE StyleDetailFormID = @ItemID  
  END  
    
 Else  
  BEGIN  
   UPDATE pStyleImageItem  
   SET  MUser = @MUser, MDate = @MDate, Sort = @Sort  
   WHERE StyleImageItemID = @ItemID  
  END  



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03181', GetDate())

GO
 