begin

	Declare @DeskMenuTypeID int
	Declare @DeskMenuID int

	if not exists (select * from [sDeskMenu] WHERE [DeskName] = 'Partner History')
		begin
			select @DeskMenuTypeID = DeskMenuTypeID From sDeskMenuType where UPPER(DeskMenuTypeName) = 'PARTNER FOLDER'
			select @DeskMenuID = COALESCE(MAX(DeskMenuID),0) + 1 From sDeskMenu
			
			INSERT INTO [dbo].[sDeskMenu]
			   ([DeskMenuID]
			   ,[DeskMenuTypeID]
			   ,[DeskName]           
			   ,[DeskDescription]
			   ,[DeskIcon]
			   ,[DeskUrl]
			   ,[DeskSort]
			   ,[DeskActive]
			   ,[DeskWindowName]
			  )
			VALUES
			   (@DeskMenuID
			   ,@DeskMenuTypeID
			   ,'Partner History'           
			   ,'NULL'
			   ,'pg-next.gif'
			   ,'../Vendor/Vendor_Folder_History_List.aspx'
			   ,'00' + convert(nvarchar(3),@DeskMenuID)
			   ,1
			   ,'main'
			   )
		end
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04463', GetDate())
GO
