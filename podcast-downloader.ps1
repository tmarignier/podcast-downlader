[Environment]::CurrentDirectory=(Get-Location -PSProvider FileSystem).ProviderPath
$wc = New-Object System.Net.WebClient
$wc.Encoding = [System.Text.Encoding]::UTF8
$a = ([xml]$wc.downloadstring("https://radiofrance-podcast.net/podcast09/rss_23119.xml"))
$a.rss.channel.item | foreach{  
    $url = New-Object System.Uri($_.enclosure.url)
    $file = $url.Segments[-1]
    $file
	$filename = $_.title[0]+".mp3"
    if (!(test-path $file))
    {
        (New-Object System.Net.WebClient).DownloadFile($url, $filename)
    }
}
