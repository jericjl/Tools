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

            #Add VPN connection if VPN name does not exist
            #Tunnel Type L2tp
            #Authentication Pap,MsChapv2
            #Enabled SplitTunneling
            #Remember User's Credentials when logged on
            Add-VpnConnection -Name "$vpn_name" -ServerAddress "$server_address" -TunnelType "L2tp" -EncryptionLevel "Optional" -AuthenticationMethod Pap,MsChapv2 -SplitTunneling -L2tpPsk "$secret_key" -Force -RememberCredential -PassThru
        } #if and else condition
        
    } #foreach loop

   
}


#Get your configuration details in Meraki / VPN Provider

$VpnData = (@{
    vpn_name    = "PH-VPN"
    server_add  = "example1.server.com"
    secret      = "<SecretKey / Pre-SharedKey>"
},@{  
    vpn_name    = "US-VPN" 
    server_add  = "example2.server.com"
    secret      = "<SecretKey / Pre-SharedKey>"
})

#Run the Function createVPN 
CreateVPN $VpnData
