IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NBOLMachineType_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NBOLMachineType_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_NBOLMachineType_INSERT] 
	(@MachineClassId   uniqueidentifier,
	@CUser nvarchar(200),
	@CDate datetime,
	@Active int = 1)
AS

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (5)

BEGIN 

	SELECT @nCount = count(*) FROM pNBOLMachineType WITH (NOLOCK) WHERE MachineClassID = @MachineClassId
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pNBOLMachineType WITH (NOLOCK) WHERE MachineClassID = @MachineClassId
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	print  'nCount=' + Cast(@nCount  as varchar (10) ) + '   nMax=' + Cast( @nMax as varchar (10) ) + '   nSort=' + Cast( @nSort  as varchar (10) )
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '00000' +  cast ( @nSort as nvarchar (5) ) , 5 )
	print  'vccount 1 = '  + @vcCount

INSERT INTO pNBOLMachineType
    (MachineClassID, CUser, CDate, MUser, MDate, Active, Sort)
VALUES (@MachineClassId, @CUser, @CDate, @CUser, @CDate, @Active, @vcCount)

END

GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03528', GetDate())
GO