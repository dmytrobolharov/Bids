
begin
	Declare @DeskMenuTypeID int
	Declare @DeskMenuID int
	if exists (select * from sDeskMenuType WHERE UPPER(DeskMenuTypeName) = 'VENDOR FOLDER')
		begin				
			select @DeskMenuTypeID = DeskMenuTypeID From sDeskMenuType where UPPER(DeskMenuTypeName) = 'VENDOR FOLDER'

				
			 if not exists (select * from sDeskMenu WHERE UPPER(DeskName) = 'PROFILE')
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
					   ,'Profile'           
					   ,'pg-next.gif'
					   ,'../Vendor/Vendor_Profile_List.aspx'
					   ,'00' + convert(nvarchar(3),@DeskMenuID)
					   ,1
					   ,'main'
					   ,NEWID())
					end
	end	
end

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03260'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03260', GetDate())

END

GO