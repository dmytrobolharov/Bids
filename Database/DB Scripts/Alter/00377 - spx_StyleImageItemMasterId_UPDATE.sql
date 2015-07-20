ALTER PROCEDURE [dbo].[spx_StyleImageItemMasterId_UPDATE]  (
@StyleID  UNIQUEIDENTIFIER 
)
AS

DECLARE @StyleMasterID  UNIQUEIDENTIFIER 
DECLARE @ImageID  UNIQUEIDENTIFIER 
DECLARE @StyleImageItemMasterID UNIQUEIDENTIFIER 
DECLARE @NewStyleImageItemMasterID UNIQUEIDENTIFIER 

SELECT @StyleMasterID= StyleMasterID FROM pStyleHeader WITH (NOLOCK)  WHERE StyleID = @StyleID  


IF @StyleMasterID  is not  null 
BEGIN 

	DECLARE cursor_image CURSOR FOR
	SELECT distinct StyleImageItemMasterID FROM pStyleImageItem WITH (NOLOCK)  WHERE StyleID IN  ( Select StyleID  FROM pStyleHeader WITH (NOLOCK) WHERE  StyleMasterID = @StyleMasterID  ) 
	
	OPEN cursor_image 
	
	FETCH NEXT from cursor_image INTO  @StyleImageItemMasterID
	
	WHILE @@FETCH_STATUS   = 0 
	BEGIN 
	
		SET @NewStyleImageItemMasterID   = NEWID()
	
		UPDATE pStyleImageItem  SET StyleImageItemMasterID   = @NewStyleImageItemMasterID  
		WHERE StyleID IN  ( Select StyleID  FROM pStyleHeader WITH (NOLOCK) WHERE  StyleMasterID = @StyleMasterID  ) 
		AND  StyleImageItemMasterID  = @StyleImageItemMasterID
		

		FETCH NEXT from cursor_image INTO  @StyleImageItemMasterID 
	END 
	
	
	CLOSE cursor_image 
	DEALLOCATE cursor_image 

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '377', GetDate())
GO