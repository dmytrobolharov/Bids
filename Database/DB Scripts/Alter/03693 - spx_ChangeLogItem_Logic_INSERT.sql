IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogItem_Logic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLogItem_Logic_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_ChangeLogItem_Logic_INSERT] (
	@ChangeLogItemID UNIQUEIDENTIFIER
)
AS 


DECLARE 
	@ChangeTableID UNIQUEIDENTIFIER,
	@ChangeTransTypeID INT,
	@ChangeTablePKID NVARCHAR(40)


SELECT @ChangeTableID=c.ChangeTableID, @ChangeTransTypeID=b.ChangeTransTypeID,
@ChangeTablePKID=ChangeTablePKID
FROM dbo.pChangeLogItem a
	INNER JOIN dbo.pChangeTransaction b ON a.ChangeTransID = b.ChangeTransID
	INNER JOIN dbo.pChangeLog c ON c.ChangeLogID =  a.ChangeLogID
WHERE a.ChangeLogItemID = @ChangeLogItemID


DECLARE 
	@Custom_SMat_Name NVARCHAR(200),
	@Custom_SMat_No NVARCHAR(200),
	@Custom_SMat_Type NVARCHAR(200)
	
IF @ChangeTableID = '036F8B4C-C1CC-DF11-AF06-005056C00008' --pStyleMaterials
--AND (@ChangeTablePKID = 0  OR @ChangeTablePKID = 1 OR @ChangeTablePKID = 2)  -- Update and Add
BEGIN



	SELECT @Custom_SMat_Name = a.MaterialName, @Custom_SMat_No = a.MaterialNo, 
	@Custom_SMat_Type = b.ComponentDescription
	FROM dbo.pStyleMaterials a WITH (NOLOCK)
		INNER JOIN dbo.pComponentType b WITH (NOLOCK) ON a.MaterialType =  b.ComponentTypeID
	WHERE a.StyleMaterialID = @ChangeTablePKID

	UPDATE pChangeLogItem 
	SET Custom_SMat_Name = @Custom_SMat_Name , Custom_SMat_No = @Custom_SMat_No,
	Custom_SMat_Type = @Custom_SMat_Type
	WHERE ChangeLogItemID = @ChangeLogItemID

END 

--IF @ChangeTableID = '00000010-c1cc-df11-af06-005056c00008' 
--	BEGIN


--		SELECT @Custom_SMat_Name = a.MaterialName, @Custom_SMat_No = a.MaterialNo, 
--		@Custom_SMat_Type = b.ComponentDescription
--		FROM pMaterial a WITH (NOLOCK)
--			INNER JOIN dbo.pComponentType b WITH (NOLOCK) ON a.MaterialType =  b.ComponentTypeID
--		WHERE a.MaterialID = @ChangeTablePKID

--		UPDATE pChangeLogItem 
--		SET Custom_SMat_Name = @Custom_SMat_Name, Custom_SMat_No = @Custom_SMat_No,
--		Custom_SMat_Type = @Custom_SMat_Type
--		WHERE ChangeLogItemID = @ChangeLogItemID

--	END 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03693', GetDate())
GO