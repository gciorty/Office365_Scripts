function ListItems ($FOLDER)
{
    $Items = Get-PnPFolderItem -FolderSiteRelativeUrl $FOLDER

	Foreach ($item in $Items)
	{
        $iName = $item.Name.replace("%","")  
		if ($item.GetType().Name -eq "Folder")
		{
            $nPath = $FOLDER+"/"+$item.Name        
            ListItems $nPath    
		}
		else
		{
			$nPath = $FOLDER+"/"+$item.Name 
			$clientContext = Get-PnPContext
			try
			{
				$ListItem = Get-PnPFile -Url $nPath -AsListItem
				# Get the File object
				$targetFile = $ListItem.File
				$clientContext.Load($targetFile)
				$clientContext.ExecuteQuery()
				 
				# The file should be checked out for this operation
				$targetFile.UndoCheckOut()
				 
				$clientContext.ExecuteQuery()
				
				echo $nPath
			}
			catch
			{
				##
			}
			

		}
	}
    
}

$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path C:\support\output.txt -append

# Change path here
ListItems "/Shared Documents/Test"

Stop-Transcript