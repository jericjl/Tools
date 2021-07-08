function CreateVpn{
    #Loop the value of the Hash
    foreach($vpn in $VpnData){
            
            $server_address = $($vpn.Values)[0]
            $vpn_name       = $($vpn.Values)[1]
            $secret_key     = $($vpn.Values)[2]
            
        #Check VPN name before adding
        if( (Get-VpnConnection).Name -eq $($vpn_name) ) 
            {write-host "VPN $vpn_name is already in exist"
            return
            }

        else{
            #convert System.Security.SecureString to plaintext
            $key = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secret_key)
            $key_string = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($key)

            #Add VPN connection if VPN name does not exist
            Add-VpnConnection -Name "$vpn_name" -ServerAddress "$server_address" -TunnelType "L2tp" -EncryptionLevel "Optional" -AuthenticationMethod Pap,MsChapv2 -SplitTunneling -L2tpPsk "$key_string" -Force -RememberCredential -PassThru
        } #if and else condition
        
    } #foreach loop

   
}



$secret1 = Read-Host 'Enter VPN Secret1 key' -AsSecureString
$secret2     = Read-Host 'Enter VPN Secret2 key' -AsSecureString

$VpnData = (@{
    vpn_name    = "PH"
    server_add  = "example1.server.com"
    secret      =  $secret1
},@{  
    vpn_name    = "US" 
    server_add  = "example2.server.com"
    secret      = $secret2
})

#Run the Function createVPN 
CreateVPN -VpnName $VpnData
