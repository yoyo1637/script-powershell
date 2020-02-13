#Script FRX_Socket 
function global:FRX_Socket-Listen-Connect{
    param($port=1984)
    $socket = new-object System.Net.Sockets.TcpListener('0.0.0.0',$port)
    if($socket -eq $null){exit 1}
    $socket.Start()

    return $socket    
}
function global:FRX_Socket-Listen-Read{
    param($socket,$buffersize=512)
    $script:client = $socket.AcceptTcpClient()

    $stream = $script:client.GetStream() # je récupère ce qui est envoyé
    # Mais qu'est ce qui a été transmis alors ?
    $buffer = New-Object system.byte[] $buffersize
    do{
        $read = $null
        while($stream.DataAvailable -or $read -eq $null){
            $read = $stream.read($buffer,0,$buffersize)
        }    
    }while($read -gt 1)
    $message = ([System.Text.Encoding]::ASCII).GetString($buffer)
    $message = $message.substring(0,$message.IndexOf(0))
    
    return $message    
}
function global:FRX_Socket-Listen-Close{
    param($socket)
    $socket.stop()
    $script:client.close()
    return $null
}
Function global:FRX_Socket-Send-Port{
    param($port = 1984,$IPTarget=127.0.0.1,$message="echo123456")
    $socket = new-object System.Net.Sockets.TcpClient($IPTarget, $port)
    $data = [System.Text.Encoding]::ASCII.GetBytes($message)
    $stream = $socket.GetStream()
    $stream.Write($data, 0, $data.Length)
    $socket.close()
    return $null
}