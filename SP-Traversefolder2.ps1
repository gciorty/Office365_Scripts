function ListItems ($FOLDER)
{
    $Items = Get-PnPFolderItem -FolderSiteRelativeUrl $FOLDER

	Foreach ($item in $Items)
	{
        $iName = $item.Name.replace("%","")  
		if ($item.GetType().Name -eq "Folder")
		{
            $nPath = $FOLDER+"/"+$item.Name
            $dPath = $nPath.replace("SharePointTest","Resources")
            echo "$dPath""*** CREATED! ***"
            $calc = $dPath.Length - $item.Name.Length
            Add-PnPFolder -Name $iName -Folder $dPath.substring(0,$calc)            
            ListItems $nPath    
		}
		else
		{
			$fPath = $FOLDER+"/"+$item.Name
            $dPath = $fPath.replace("SharePointTest","Resources").replace("% ","").replace("%","")
            
            $calc = $dPath.Length - $item.Name.Length

            if ($item.Name.Contains("%"))
            {
                $calc = $calc + 1
            }

            $dPath = $dPath.substring(0,$calc)
            
            if ($FOLDER -ne "/SharePointTest/Forms")
            {
             Copy-PnPFile -SourceUrl "$fPath" -TargetUrl "$dPath" -OverwriteIfAlreadyExists -Force             
            }
            
            echo "$fPath""$dPath""*** COPIED! ***"
		}
	}
    
}

$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path C:\support\output.txt -append

ListItems "/SharePointTest"

Stop-Transcript