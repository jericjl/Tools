function RemoveVpnConnection{

    foreach($vpn_name in (Get-VpnConnection).Name){
        #Check if VPN Name US-Danvers-VPN exist
        if ($vpn_name.Contains("US-VPN")) {
            
            foreach($us_route in $Remove_UsMerakiVpnRoutes){
                #Add route if VPN name exist 
                #$us_route
               try {
                Remove-VpnConnectionRoute -ConnectionName $vpn_name -DestinationPrefix $us_route -PassThru  
               }
               catch {
                "No Route with network prefix $us_route is applied to $vpn_name. "
               } 
            }
        } #if
        #Check if VPN Name BGC-Meraki-VPN exist
        elseif ($vpn_name.Contains("BGC-Meraki-VPN")) {
             
            foreach($ph_route in $Remove_PhMerakiVpnRoutes){
                #Add route if VPN name exist    
                #$bgc_route
                try {
                    Remove-VpnConnectionRoute -ConnectionName $vpn_name -DestinationPrefix $bgc_route -PassThru        
                }
                catch {
                    "No Route with network prefix $ph_route is applied to $vpn_name. "
                }
                
            }
        
        } #elseif
        else {
            #Do nothing
        } #else
    
} # End of foreach VPN name Checking

}



#Remove-VpnConnectionRoute -ConnectionName "US-Danvers-VPN" -DestinationPrefix 172.64.0.0/13 -PassThru   

    # Add routing prefix here inside the ()
    # Use comma , when adding network prefix
    $Remove_UsMerakiVpnRoutes = (
        #Add IP Prefix
        #"1.1.1.1/32","4.4.2.2/32",
        ""
        )
    
        # Add routing prefix here inside the ()
        # Use comma , when adding network prefix
    $Remove_PhMerakiVpnRoutes = (
        #Add IP Prefix
        #"1.1.1.1/32","4.4.2.2/32",
        ""
        )
    
RemoveVpnConnection $Remove_UsMerakiVpnRoutes $Remove_PhMerakiVpnRoutes