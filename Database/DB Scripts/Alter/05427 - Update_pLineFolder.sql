
Declare @Custom UNIQUEIDENTIFIER = NULL   
if NOT EXISTS(SELECT  CustomId  FROM icustom1 WHERE Upper(Custom)=Upper('Yunique Apparel'))
		begin
			select  top 1  @Custom = CustomID FROM icustom1 where Active=1			
		end		
else
		begin
			SELECT  @Custom = CustomID  FROM icustom1 WHERE Upper(Custom)=Upper('Yunique Apparel')			
		end
update pLineFolder set LineFolderDivisionID=@Custom where LineFolderDivisionID is null
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05427', GetDate())
GO
