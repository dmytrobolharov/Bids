IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMaterial_Log_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_StyleMaterial_Log_INSERT
GO


CREATE PROCEDURE [dbo].[spx_StyleMaterial_Log_INSERT] (
@StyleID UNIQUEIDENTIFIER, 
@StyleChangeType NVARCHAR(50),
@MaterialNo NVARCHAR(50),
@StyleSet INT ,
@CUser NVARCHAR(200),
@CDate DATETIME 
)
AS


DECLARE @TechPackID UNIQUEIDENTIFIER 

SELECT @TechPackID = c.TechPackID
FROM dbo.pStyleHeader a
INNER JOIN dbo.pTechPack c ON a.TechPackId =  c.TechPackID 
WHERE a.StyleID = @StyleID 


IF @TechPackID IS NOT NULL 
BEGIN

	DECLARE @Description NVARCHAR(400)	
	DECLARE @NEWID  UNIQUEIDENTIFIER 
	
	SET @NEWID =  NEWID()
	IF UPPER (@StyleChangeType) =  'INSERT'
		SET @Description = 'Material ' + @MaterialNo + ' Added to Style' 
	ELSE IF  UPPER (@StyleChangeType) =  'DELETE'
		SET @Description = 'Material ' + @MaterialNo + ' Deleted from Style' 
	ELSE	
		RETURN
		
	EXEC spx_StyleChange_INSERT
		@ActiveID = '00000000-0000-0000-0000-000000000000',
        @ChangeID = @NEWID,
        @WorkflowID = '40000000-0000-0000-0000-000000000004',
        @StyleID = @StyleID,
        @StyleSet = @StyleSet,
        @StyleStatus = 0 ,
        @StyleChangeNotifyTo = ' ',
        @StyleChangeType = @StyleChangeType,
        @StyleChangeDescription = @Description,
        @ChangeBy = @CUser,
        @ChangeDate = @CDate

END
GO