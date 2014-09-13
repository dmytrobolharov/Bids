
begin
	Declare @DeskMenuTypeID int
	Declare @DeskMenuID int
	if not exists (select * from sDeskMenuType WHERE UPPER(DeskMenuTypeName) = 'VENDOR FOLDER')
		begin				
			select @DeskMenuTypeID = COALESCE(MAX(DeskMenuTypeID),0) + 1 From sDeskMenuType
			INSERT INTO [sDeskMenuType]
			   ([DeskMenuTypeID]
			   ,[DeskMenuTypeName]
			   ,[DeskMenuTypeIcon]           
			   ,[DeskMenuTypeSort]
			   ,[DeskMenuTypeActive]
			   ,[DeskMenuTypeRepId])
		   VALUES
			   (@DeskMenuTypeID
			   ,'Vendor Folder'
			   ,'icon_trade.gif'          
			   ,'0' + Convert(nvarchar(2),@DeskMenuTypeID)
			   ,1
			   ,NEWID())
		
		  
			if not exists (select * from sDeskMenu WHERE UPPER(DeskName) = 'TEMPLATE VIEW')
				begin
					select @DeskMenuID = COALESCE(MAX(DeskMenuID),0) + 1 From sDeskMenu
					INSERT INTO [sDeskMenu]
					([DeskMenuID]
				   ,[DeskMenuTypeID]
				   ,[DeskName]           
				   ,[DeskIcon]
				   ,[DeskUrl]
				   ,[DeskSort]
				   ,[DeskActive]
				   ,[DeskWindowName]
				   ,[DeskMenuRepId])
					VALUES
				   (@DeskMenuID
				   ,@DeskMenuTypeID
				   ,'Template View'           
				   ,'pg-next.gif'
				   ,'../Vendor/Vendor_Template_List.aspx'
				   ,'00' + convert(nvarchar(3),@DeskMenuID)
				   ,1
				   ,'main'
				   ,NEWID())
				end
				
			 if not exists (select * from sDeskMenu WHERE UPPER(DeskName) = 'VENDOR VIEW')
					begin
						select @DeskMenuID = COALESCE(MAX(DeskMenuID),0) + 1 From sDeskMenu
						INSERT INTO [sDeskMenu]
						([DeskMenuID]
					   ,[DeskMenuTypeID]
					   ,[DeskName]           
					   ,[DeskIcon]
					   ,[DeskUrl]
					   ,[DeskSort]
					   ,[DeskActive]
					   ,[DeskWindowName]
					   ,[DeskMenuRepId])
						VALUES
					   (@DeskMenuID
					   ,@DeskMenuTypeID
					   ,'Vendor View'           
					   ,'pg-next.gif'
					   ,'../Vendor/Vendor_Folder_List.aspx'
					   ,'00' + convert(nvarchar(3),@DeskMenuID)
					   ,1
					   ,'main'
					   ,NEWID())
					end
	end	
end

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03251'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03251', GetDate())

END

GO