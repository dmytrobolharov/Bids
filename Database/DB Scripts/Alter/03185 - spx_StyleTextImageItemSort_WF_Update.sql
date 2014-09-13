IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTextImageItemSort_WF_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleTextImageItemSort_WF_Update]
GO


CREATE PROCEDURE [dbo].[spx_StyleTextImageItemSort_WF_Update]  
(@WorkflowID UNIQUEIDENTIFIER,  
@ItemID UNIQUEIDENTIFIER,  
@TeamID UNIQUEIDENTIFIER,  
@Sort NVARCHAR(10),  
@MUser NVARCHAR(200),  
@MDate DATETIME)  
AS   
  
 
  BEGIN  
   UPDATE pStyleDetailForm   
   SET  MUser = @MUser, MDate = @MDate, Sort = @Sort  
   WHERE StyleDetailFormID = @ItemID  
  END  
  
  
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03185', GetDate())

GO    
    
 